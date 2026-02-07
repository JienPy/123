const DIRECTUS_URL = '';

interface AuthResponse {
  data: {
    access_token: string;
    refresh_token: string;
    expires: number;
  };
}

interface DirectusInventoryItem {
  id: number;
  product_name: string;
  sku: string | null;
  quantity: number;
  price: string;
  category: string | null;
  description: string | null;
  reorder_level: number | null;
  supplier: string | null;
  status: string | null;
  unit: string | null;
  user_created: string | null;
  user_updated: string | null;
  date_created: string | null;
  date_updated: string | null;
}

export interface InventoryItem {
  id: string;
  name: string;
  category: string;
  quantity: number;
  unit: string;
  price: number;
  description: string;
}

let accessToken: string | null = null;
let tokenExpiry: number | null = null;

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
  tokenExpiry = Date.now() + data.data.expires - 60000; // Refresh 1 min early
  return accessToken;
}

function mapFromDirectus(item: DirectusInventoryItem): InventoryItem {
  return {
    id: item.id.toString(),
    name: item.product_name,
    category: item.category || 'Other',
    quantity: item.quantity,
    unit: item.unit || 'pieces',
    price: parseFloat(item.price) || 0,
    description: item.description || '',
  };
}

function mapToDirectus(item: Omit<InventoryItem, 'id'>): Partial<DirectusInventoryItem> {
  return {
    product_name: item.name,
    category: item.category,
    quantity: item.quantity,
    unit: item.unit,
    price: item.price.toString(),
    description: item.description || null,
    status: 'in_stock',
  };
}

export async function fetchInventory(): Promise<InventoryItem[]> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/inventory`, {
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to fetch inventory');
  }

  const data = await response.json();
  return data.data.map(mapFromDirectus);
}

export async function createInventoryItem(item: Omit<InventoryItem, 'id'>): Promise<InventoryItem> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/inventory`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(mapToDirectus(item)),
  });

  if (!response.ok) {
    throw new Error('Failed to create inventory item');
  }

  const data = await response.json();
  return mapFromDirectus(data.data);
}

export async function updateInventoryItem(id: string, item: Partial<InventoryItem>): Promise<InventoryItem> {
  const token = await getToken();
  const updateData: Partial<DirectusInventoryItem> = {};

  if (item.name !== undefined) updateData.product_name = item.name;
  if (item.category !== undefined) updateData.category = item.category;
  if (item.quantity !== undefined) updateData.quantity = item.quantity;
  if (item.unit !== undefined) updateData.unit = item.unit;
  if (item.price !== undefined) updateData.price = item.price.toString();
  if (item.description !== undefined) updateData.description = item.description || null;

  const response = await fetch(`${DIRECTUS_URL}/items/inventory/${id}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(updateData),
  });

  if (!response.ok) {
    throw new Error('Failed to update inventory item');
  }

  const data = await response.json();
  return mapFromDirectus(data.data);
}

export async function deleteInventoryItem(id: string): Promise<void> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/inventory/${id}`, {
    method: 'DELETE',
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to delete inventory item');
  }
}

// ============ Categories API ============

export interface Category {
  id: string;
  name: string;
  description: string;
  status: 'active' | 'inactive';
}

interface DirectusCategory {
  id: number;
  name: string;
  description: string | null;
  status: string;
  date_created: string | null;
  date_updated: string | null;
}

export async function fetchCategories(): Promise<Category[]> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/categories`, {
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to fetch categories');
  }

  const data = await response.json();
  return data.data.map((item: DirectusCategory) => ({
    id: item.id.toString(),
    name: item.name,
    description: item.description || '',
    status: item.status as 'active' | 'inactive',
  }));
}

export async function createCategory(category: Omit<Category, 'id'>): Promise<Category> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/categories`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(category),
  });

  if (!response.ok) {
    throw new Error('Failed to create category');
  }

  const data = await response.json();
  return {
    id: data.data.id.toString(),
    name: data.data.name,
    description: data.data.description || '',
    status: data.data.status,
  };
}

export async function updateCategory(id: string, category: Partial<Category>): Promise<Category> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/categories/${id}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(category),
  });

  if (!response.ok) {
    throw new Error('Failed to update category');
  }

  const data = await response.json();
  return {
    id: data.data.id.toString(),
    name: data.data.name,
    description: data.data.description || '',
    status: data.data.status,
  };
}

export async function deleteCategory(id: string): Promise<void> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/categories/${id}`, {
    method: 'DELETE',
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to delete category');
  }
}

// ============ Units API ============

export interface Unit {
  id: string;
  name: string;
  abbreviation: string;
  status: 'active' | 'inactive';
}

interface DirectusUnit {
  id: number;
  name: string;
  abbreviation: string | null;
  status: string;
  date_created: string | null;
  date_updated: string | null;
}

export async function fetchUnits(): Promise<Unit[]> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/units`, {
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to fetch units');
  }

  const data = await response.json();
  return data.data.map((item: DirectusUnit) => ({
    id: item.id.toString(),
    name: item.name,
    abbreviation: item.abbreviation || '',
    status: item.status as 'active' | 'inactive',
  }));
}

export async function createUnit(unit: Omit<Unit, 'id'>): Promise<Unit> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/units`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(unit),
  });

  if (!response.ok) {
    throw new Error('Failed to create unit');
  }

  const data = await response.json();
  return {
    id: data.data.id.toString(),
    name: data.data.name,
    abbreviation: data.data.abbreviation || '',
    status: data.data.status,
  };
}

export async function updateUnit(id: string, unit: Partial<Unit>): Promise<Unit> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/units/${id}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(unit),
  });

  if (!response.ok) {
    throw new Error('Failed to update unit');
  }

  const data = await response.json();
  return {
    id: data.data.id.toString(),
    name: data.data.name,
    abbreviation: data.data.abbreviation || '',
    status: data.data.status,
  };
}

export async function deleteUnit(id: string): Promise<void> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/units/${id}`, {
    method: 'DELETE',
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to delete unit');
  }
}

// ============ Inventory Images API ============

export interface InventoryImage {
  id: string;
  inventoryId: string;
  fileId: string;
  url: string;
  filename: string;
}

interface DirectusFile {
  id: string;
  filename_download: string;
  title: string | null;
  type: string;
}

interface DirectusInventoryImage {
  id: number;
  inventory_id: number;
  directus_files_id: string | DirectusFile;
  date_created: string | null;
}

export function getFileUrl(fileId: string): string {
  return `${DIRECTUS_URL}/assets/${fileId}`;
}

export async function uploadFile(file: File): Promise<string> {
  const token = await getToken();
  const formData = new FormData();
  formData.append('file', file);

  const response = await fetch(`${DIRECTUS_URL}/files`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${token}`,
    },
    body: formData,
  });

  if (!response.ok) {
    throw new Error('Failed to upload file');
  }

  const data = await response.json();
  return data.data.id;
}

export async function createInventoryImage(inventoryId: string, fileId: string): Promise<InventoryImage> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/inventory_images`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({
      inventory_id: parseInt(inventoryId),
      directus_files_id: fileId,
    }),
  });

  if (!response.ok) {
    throw new Error('Failed to create inventory image');
  }

  const data = await response.json();
  return {
    id: data.data.id.toString(),
    inventoryId: data.data.inventory_id.toString(),
    fileId: fileId,
    url: getFileUrl(fileId),
    filename: '',
  };
}

export async function fetchInventoryImages(inventoryId: string): Promise<InventoryImage[]> {
  const token = await getToken();
  const response = await fetch(
    `${DIRECTUS_URL}/items/inventory_images?filter[inventory_id][_eq]=${inventoryId}&fields=*,directus_files_id.*`,
    {
      headers: { Authorization: `Bearer ${token}` },
    }
  );

  if (!response.ok) {
    throw new Error('Failed to fetch inventory images');
  }

  const data = await response.json();
  return data.data.map((item: DirectusInventoryImage) => {
    const file = item.directus_files_id as DirectusFile;
    return {
      id: item.id.toString(),
      inventoryId: item.inventory_id.toString(),
      fileId: typeof item.directus_files_id === 'string' ? item.directus_files_id : file.id,
      url: getFileUrl(typeof item.directus_files_id === 'string' ? item.directus_files_id : file.id),
      filename: typeof item.directus_files_id === 'string' ? '' : file.filename_download,
    };
  });
}

export async function deleteInventoryImage(id: string): Promise<void> {
  const token = await getToken();
  const response = await fetch(`${DIRECTUS_URL}/items/inventory_images/${id}`, {
    method: 'DELETE',
    headers: { Authorization: `Bearer ${token}` },
  });

  if (!response.ok) {
    throw new Error('Failed to delete inventory image');
  }
}

export async function uploadInventoryImages(inventoryId: string, files: File[]): Promise<InventoryImage[]> {
  const images: InventoryImage[] = [];

  for (const file of files) {
    const fileId = await uploadFile(file);
    const image = await createInventoryImage(inventoryId, fileId);
    image.filename = file.name;
    images.push(image);
  }

  return images;
}
