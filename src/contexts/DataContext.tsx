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

export type { InventoryItem, Category, Unit };

export interface Sale {
  id: string;
  orderId: string;
  customer: string;
  item: string;
  amount: number;
  date: string;
  status: "Completed" | "Pending" | "In Progress";
}

interface DataContextType {
  inventory: InventoryItem[];
  categories: Category[];
  units: Unit[];
  sales: Sale[];
  isLoading: boolean;
  error: string | null;
  addInventoryItem: (item: Omit<InventoryItem, 'id'>) => Promise<void>;
  updateInventoryItem: (id: string, item: Partial<InventoryItem>) => Promise<void>;
  deleteInventoryItem: (id: string) => Promise<void>;
  addSale: (sale: Sale) => void;
  refreshInventory: () => Promise<void>;
  refreshCategories: () => Promise<void>;
  refreshUnits: () => Promise<void>;
}

const DataContext = createContext<DataContextType | undefined>(undefined);

export function DataProvider({ children }: { children: ReactNode }) {
  const [inventory, setInventory] = useState<InventoryItem[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [units, setUnits] = useState<Unit[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const [sales, setSales] = useState<Sale[]>([
    { id: "1", orderId: "ORD-001", customer: "Rajesh Kumar", item: "3-Piece Suit", amount: 8500, date: "2025-10-02", status: "Completed" },
    { id: "2", orderId: "ORD-002", customer: "Priya Sharma", item: "Lehenga Alteration", amount: 3200, date: "2025-10-02", status: "In Progress" },
    { id: "3", orderId: "ORD-003", customer: "Amit Patel", item: "Shirt Stitching (2x)", amount: 1800, date: "2025-10-01", status: "Completed" },
    { id: "4", orderId: "ORD-004", customer: "Sneha Reddy", item: "Salwar Suit", amount: 4500, date: "2025-10-01", status: "Pending" },
    { id: "5", orderId: "ORD-005", customer: "Vikram Singh", item: "Blazer Alteration", amount: 2200, date: "2025-09-30", status: "Completed" },
  ]);

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

  useEffect(() => {
    const loadData = async () => {
      setIsLoading(true);
      await Promise.all([
        refreshInventory(),
        refreshCategories(),
        refreshUnits(),
      ]);
      setIsLoading(false);
    };
    loadData();
  }, []);

  const addInventoryItem = async (item: Omit<InventoryItem, 'id'>) => {
    try {
      const newItem = await apiCreateItem(item);
      setInventory(prev => [newItem, ...prev]);
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

  const addSale = (sale: Sale) => {
    setSales([sale, ...sales]);
  };

  return (
    <DataContext.Provider value={{
      inventory,
      categories,
      units,
      sales,
      isLoading,
      error,
      addInventoryItem,
      updateInventoryItem,
      deleteInventoryItem,
      addSale,
      refreshInventory,
      refreshCategories,
      refreshUnits,
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
