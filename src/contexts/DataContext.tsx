import { createContext, useContext, useState, useEffect, ReactNode } from "react";
import {
  fetchInventory,
  createInventoryItem as apiCreateItem,
  updateInventoryItem as apiUpdateItem,
  deleteInventoryItem as apiDeleteItem,
  fetchCategories,
  fetchUnits,
  InventoryItem,
  Category,
  Unit,
} from "@/services/directus";
import {
  fetchOrders,
  fetchOrder,
  fetchOrderStats,
  updateOrderStatus as apiUpdateOrderStatus,
  Order,
  OrderStats,
  OrderStatus,
} from "@/services/orders";

export type { InventoryItem, Category, Unit, Order, OrderStats, OrderStatus };

interface DataContextType {
  inventory: InventoryItem[];
  categories: Category[];
  units: Unit[];
  orders: Order[];
  orderStats: OrderStats | null;
  isLoading: boolean;
  error: string | null;
  addInventoryItem: (item: Omit<InventoryItem, 'id'>) => Promise<InventoryItem>;
  updateInventoryItem: (id: string, item: Partial<InventoryItem>) => Promise<void>;
  deleteInventoryItem: (id: string) => Promise<void>;
  updateOrderStatus: (id: number, status: OrderStatus) => Promise<void>;
  refreshInventory: () => Promise<void>;
  refreshCategories: () => Promise<void>;
  refreshUnits: () => Promise<void>;
  refreshOrders: () => Promise<void>;
  refreshOrderStats: () => Promise<void>;
}

const DataContext = createContext<DataContextType | undefined>(undefined);

export function DataProvider({ children }: { children: ReactNode }) {
  const [inventory, setInventory] = useState<InventoryItem[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [units, setUnits] = useState<Unit[]>([]);
  const [orders, setOrders] = useState<Order[]>([]);
  const [orderStats, setOrderStats] = useState<OrderStats | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const refreshInventory = async () => {
    try {
      setIsLoading(true);
      setError(null);
      const data = await fetchInventory();
      setInventory(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch inventory');
      console.error('Failed to fetch inventory:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const refreshCategories = async () => {
    try {
      const data = await fetchCategories();
      setCategories(data);
    } catch (err) {
      console.error('Failed to fetch categories:', err);
    }
  };

  const refreshUnits = async () => {
    try {
      const data = await fetchUnits();
      setUnits(data);
    } catch (err) {
      console.error('Failed to fetch units:', err);
    }
  };

  const refreshOrders = async () => {
    try {
      const data = await fetchOrders();
      setOrders(data);
    } catch (err) {
      console.error('Failed to fetch orders:', err);
    }
  };

  const refreshOrderStats = async () => {
    try {
      const data = await fetchOrderStats();
      setOrderStats(data);
    } catch (err) {
      console.error('Failed to fetch order stats:', err);
    }
  };

  useEffect(() => {
    const loadData = async () => {
      setIsLoading(true);
      await Promise.all([
        refreshInventory(),
        refreshCategories(),
        refreshUnits(),
        refreshOrders(),
        refreshOrderStats(),
      ]);
      setIsLoading(false);
    };
    loadData();
  }, []);

  const addInventoryItem = async (item: Omit<InventoryItem, 'id'>): Promise<InventoryItem> => {
    try {
      const newItem = await apiCreateItem(item);
      setInventory(prev => [newItem, ...prev]);
      return newItem;
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to add item');
      throw err;
    }
  };

  const updateInventoryItem = async (id: string, updatedItem: Partial<InventoryItem>) => {
    try {
      const updated = await apiUpdateItem(id, updatedItem);
      setInventory(prev => prev.map(item => item.id === id ? updated : item));
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to update item');
      throw err;
    }
  };

  const deleteInventoryItem = async (id: string) => {
    try {
      await apiDeleteItem(id);
      setInventory(prev => prev.filter(item => item.id !== id));
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to delete item');
      throw err;
    }
  };

  const updateOrderStatus = async (id: number, status: OrderStatus) => {
    try {
      // Get the current order to check its current status
      const currentOrder = orders.find(o => o.id === id);

      // If changing to "processed", deduct inventory quantities
      if (status === 'processed' && currentOrder?.status === 'pending') {
        // Fetch fresh order data to ensure we have items
        const orderWithItems = await fetchOrder(id);
        console.log('Processing order:', orderWithItems);

        if (orderWithItems.items && orderWithItems.items.length > 0) {
          // Deduct inventory for each order item
          for (const item of orderWithItems.items) {
            // Handle inventory_id which could be a number or an object with id
            let inventoryId: string | null = null;
            if (item.inventory_id !== null && item.inventory_id !== undefined) {
              if (typeof item.inventory_id === 'object' && item.inventory_id !== null) {
                // If it's an object (M2O relationship), get the id property
                inventoryId = (item.inventory_id as { id: number }).id?.toString();
              } else {
                // If it's a number, convert to string
                inventoryId = String(item.inventory_id);
              }
            }

            console.log('Order item:', item.product_name, 'inventory_id:', inventoryId, 'quantity:', item.quantity);

            // Try to find inventory item by ID first, then by product name as fallback
            let inventoryItem = inventoryId
              ? inventory.find(inv => inv.id === inventoryId)
              : null;

            // Fallback: match by product name if inventory_id doesn't match
            if (!inventoryItem && item.product_name) {
              inventoryItem = inventory.find(inv =>
                inv.name.toLowerCase() === item.product_name.toLowerCase()
              );
              console.log('Fallback match by product name:', inventoryItem);
            }

            console.log('Found inventory item:', inventoryItem);

            if (inventoryItem) {
              const newQuantity = Math.max(0, inventoryItem.quantity - item.quantity);
              console.log('Updating quantity from', inventoryItem.quantity, 'to', newQuantity);
              await apiUpdateItem(inventoryItem.id, { quantity: newQuantity });
            } else {
              console.log('No matching inventory item found for:', item.product_name);
            }
          }
          // Refresh inventory after deductions
          await refreshInventory();
        }
      }

      await apiUpdateOrderStatus(id, status);
      setOrders(prev => prev.map(order =>
        order.id === id ? { ...order, status } : order
      ));
      // Refresh stats after status change
      await refreshOrderStats();
    } catch (err) {
      console.error('Error updating order status:', err);
      setError(err instanceof Error ? err.message : 'Failed to update order');
      throw err;
    }
  };

  return (
    <DataContext.Provider value={{
      inventory,
      categories,
      units,
      orders,
      orderStats,
      isLoading,
      error,
      addInventoryItem,
      updateInventoryItem,
      deleteInventoryItem,
      updateOrderStatus,
      refreshInventory,
      refreshCategories,
      refreshUnits,
      refreshOrders,
      refreshOrderStats,
    }}>
      {children}
    </DataContext.Provider>
  );
}

export function useData() {
  const context = useContext(DataContext);
  if (context === undefined) {
    throw new Error("useData must be used within a DataProvider");
  }
  return context;
}
