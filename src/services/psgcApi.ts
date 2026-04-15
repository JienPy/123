const BASE_URL = 'https://psgc.gitlab.io/api';

export interface Province {
  code: string;
  name: string;
}

export interface CityMunicipality {
  code: string;
  name: string;
}

const cache: Record<string, unknown> = {};

async function cachedFetch<T>(url: string): Promise<T> {
  if (cache[url]) return cache[url] as T;
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Failed to fetch ${url}`);
  const data = await res.json();
  cache[url] = data;
  return data as T;
}

export async function getProvinces(): Promise<Province[]> {
  const provinces = await cachedFetch<Province[]>(`${BASE_URL}/provinces/`);
  return provinces.sort((a, b) => a.name.localeCompare(b.name));
}

export async function getCitiesForProvince(provinceCode: string): Promise<CityMunicipality[]> {
  const cities = await cachedFetch<CityMunicipality[]>(
    `${BASE_URL}/provinces/${provinceCode}/cities-municipalities/`
  );
  return cities.sort((a, b) => a.name.localeCompare(b.name));
}
