const DIRECTUS_URL = 'http://localhost:8055';

// Re-use auth from directus.ts
let accessToken: string | null = null;
let tokenExpiry: number | null = null;

interface AuthResponse {
  data: {
    access_token: string;
    refresh_token: string;
    expires: number;
  };
}

async function getToken(): Promise<string> {
  if (accessToken && tokenExpiry && Date.now() < tokenExpiry) {
    return accessToken;
  }

  const response = await fetch(`${DIRECTUS_URL}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      email: 'admin@example.com',
      password: 'admin123',
    }),
  });

  if (!response.ok) {
    throw new Error('Failed to authenticate with Directus');
  }

  const data: AuthResponse = await response.json();
  accessToken = data.data.access_token;
  tokenExpiry = Date.now() + data.data.expires - 60000;
  return accessToken;
}

// ============ Types ============

export type OrderStatus = 'pending' | 'processed' | 'on_delivery' | 'completed' | 'cancelled';

export interface OrderItem {
  id: number;
  order_id: number;
  inventory_id: number | { id: number } | null;
  product_name: string;
  quantity: number;
  unit_price: string;
  subtotal: string;
}

export interface Order {
  id: number;
  customer_name: string;
  customer_email: string;
  customer_phone: string;
  shipping_address: string;
  payment_method: 'cod' | 'gcash' | 'bank_transfer';
  status: OrderStatus;
  subtotal: string;
  shipping_fee: string;
  total_amount: string;
  notes: string | null;
  user_id: string | null;
  date_created: string;
  date_updated: string | null;
  items: OrderItem[];
}

export interface OrderFilters {
  status?: OrderStatus | 'all';
  search?: string;
  page?: number;
  limit?: number;
}

export interface OrderStats {
  pendingToday: number;
  inProgress: number;
  completed: number;
  totalRevenue: number;
}

// ============ API Functions ============

export async function fetchOrders(filters?: OrderFilters): Promise<Order[]> {
  const token = await getToken();

  const params = new URLSearchParams();
  params.append('sort', '-date_created');
  params.append('fields', '*,items.*');

  if (filters?.status && filters.status !== 'all') {
    params.append('filter[status][_eq]', filters.status);
  }

  if (filters?.search) {
    params.append('filter[_or][0][customer_name][_icontains]', filters.search);
    params.append('filter[_or][1][customer_email][_icontains]', filters.search);
    params.append('filter[_or][2][id][_eq]', filters.search);
  }

  if (filters?.limit) {
    params.append('limit', filters.limit.toString());
  }

  if (filters?.page && filters?.limit) {
    params.append('offset', ((filters.page - 1) * filters.limit).toString());
  }

  const response = await fetch(`${DIRECTUS_URL}/items/orders?${params.toString()}`, {
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to fetch orders');
  }

  const data = await response.json();
  return data.data || [];
}

export async function fetchOrder(id: number): Promise<Order> {
  const token = await getToken();

  const response = await fetch(
    `${DIRECTUS_URL}/items/orders/${id}?fields=*,items.*`,
    {
      headers: { Authorization: `Bearer ${token}` },
    }
  );

  if (!response.ok) {
    throw new Error('Failed to fetch order');
  }

  const data = await response.json();
  return data.data;
}

export async function updateOrderStatus(id: number, status: OrderStatus): Promise<Order> {
  const token = await getToken();

  const response = await fetch(`${DIRECTUS_URL}/items/orders/${id}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({ status }),
  });

  if (!response.ok) {
    throw new Error('Failed to update order status');
  }

  const data = await response.json();
  return data.data;
}

export async function fetchOrderStats(): Promise<OrderStats> {
  const token = await getToken();

  // Get today's date at midnight
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const todayISO = today.toISOString();

  // Fetch all orders to calculate stats
  const response = await fetch(
    `${DIRECTUS_URL}/items/orders?fields=id,status,total_amount,date_created`,
    {
      headers: { Authorization: `Bearer ${token}` },
    }
  );

  if (!response.ok) {
    throw new Error('Failed to fetch order stats');
  }

  const data = await response.json();
  const orders: Order[] = data.data || [];

  // Calculate stats
  const pendingToday = orders.filter(
    (o) => o.status === 'pending' && new Date(o.date_created) >= today
  ).length;

  const inProgress = orders.filter(
    (o) => o.status === 'processed' || o.status === 'on_delivery'
  ).length;

  const completedOrders = orders.filter((o) => o.status === 'completed');
  const completed = completedOrders.length;

  const totalRevenue = completedOrders.reduce(
    (sum, o) => sum + parseFloat(o.total_amount || '0'),
    0
  );

  return {
    pendingToday,
    inProgress,
    completed,
    totalRevenue,
  };
}

export async function fetchCompletedOrders(): Promise<Order[]> {
  const token = await getToken();

  const response = await fetch(
    `${DIRECTUS_URL}/items/orders?filter[status][_eq]=completed&sort=-date_created&fields=*,items.*`,
    {
      headers: { Authorization: `Bearer ${token}` },
    }
  );

  if (!response.ok) {
    throw new Error('Failed to fetch completed orders');
  }

  const data = await response.json();
  return data.data || [];
}

// Helper function to get status display info
export function getStatusInfo(status: OrderStatus): { label: string; color: string; bgColor: string } {
  switch (status) {
    case 'pending':
      return { label: 'Pending', color: 'text-yellow-700', bgColor: 'bg-yellow-100 border-yellow-300' };
    case 'processed':
      return { label: 'Processed', color: 'text-blue-700', bgColor: 'bg-blue-100 border-blue-300' };
    case 'on_delivery':
      return { label: 'On Delivery', color: 'text-purple-700', bgColor: 'bg-purple-100 border-purple-300' };
    case 'completed':
      return { label: 'Completed', color: 'text-green-700', bgColor: 'bg-green-100 border-green-300' };
    case 'cancelled':
      return { label: 'Cancelled', color: 'text-red-700', bgColor: 'bg-red-100 border-red-300' };
    default:
      return { label: status, color: 'text-gray-700', bgColor: 'bg-gray-100 border-gray-300' };
  }
}

// Helper to get next status action
export function getNextStatusAction(status: OrderStatus): { nextStatus: OrderStatus; label: string } | null {
  switch (status) {
    case 'pending':
      return { nextStatus: 'processed', label: 'Process Order' };
    case 'processed':
      return { nextStatus: 'on_delivery', label: 'Ship Order' };
    case 'on_delivery':
      return { nextStatus: 'completed', label: 'Complete Order' };
    default:
      return null;
  }
}

// Helper to format payment method
export function formatPaymentMethod(method: string): string {
  switch (method) {
    case 'cod':
      return 'Cash on Delivery';
    case 'gcash':
      return 'GCash';
    case 'bank_transfer':
      return 'Bank Transfer';
    default:
      return method;
  }
}
