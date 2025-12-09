import type { LocalStorageData, Collection, UserMode } from '../types';

const STORAGE_KEY = 'ai_mapper_data';

function debounce<T extends (...args: any[]) => void>(
  func: T,
  wait: number
): (...args: Parameters<T>) => void {
  let timeout: NodeJS.Timeout | null = null;
  return function (...args: Parameters<T>) {
    if (timeout) clearTimeout(timeout);
    timeout = setTimeout(() => func(...args), wait);
  };
}

const defaultData: LocalStorageData = {
  favorites: [],
  collections: [],
  recent_searches: [],
  ui_preferences: {
    mode: 'creator',
    theme: 'light'
  },
  onboarding_completed: false
};

const saveDataImmediate = (data: Partial<LocalStorageData>) => {
  try {
    const stored = localStorage.getItem(STORAGE_KEY);
    const current = stored ? { ...defaultData, ...JSON.parse(stored) } : defaultData;
    const updated = { ...current, ...data };
    localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
  } catch (error) {
    console.error('Failed to save to localStorage:', error);
  }
};

const debouncedSaveData = debounce(saveDataImmediate, 300);

export const storage = {
  getData(): LocalStorageData {
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      if (!stored) return defaultData;
      return { ...defaultData, ...JSON.parse(stored) };
    } catch {
      return defaultData;
    }
  },

  saveData(data: Partial<LocalStorageData>): void {
    debouncedSaveData(data);
  },

  saveDataImmediate(data: Partial<LocalStorageData>): void {
    saveDataImmediate(data);
  },

  getFavorites(): string[] {
    return this.getData().favorites;
  },

  addFavorite(toolId: string): void {
    const data = this.getData();
    if (!data.favorites.includes(toolId)) {
      data.favorites.push(toolId);
      this.saveData(data);
    }
  },

  removeFavorite(toolId: string): void {
    const data = this.getData();
    data.favorites = data.favorites.filter(id => id !== toolId);
    this.saveData(data);
  },

  isFavorite(toolId: string): boolean {
    return this.getFavorites().includes(toolId);
  },

  getCollections(): Collection[] {
    return this.getData().collections;
  },

  createCollection(name: string, toolIds: string[] = []): Collection {
    const collection: Collection = {
      id: crypto.randomUUID(),
      name,
      tool_ids: toolIds,
      created_at: new Date().toISOString()
    };

    const data = this.getData();
    data.collections.push(collection);
    this.saveData(data);

    return collection;
  },

  updateCollection(id: string, updates: Partial<Collection>): void {
    const data = this.getData();
    const index = data.collections.findIndex(c => c.id === id);
    if (index !== -1) {
      data.collections[index] = { ...data.collections[index], ...updates };
      this.saveData(data);
    }
  },

  deleteCollection(id: string): void {
    const data = this.getData();
    data.collections = data.collections.filter(c => c.id !== id);
    this.saveData(data);
  },

  addToolToCollection(collectionId: string, toolId: string): void {
    const data = this.getData();
    const collection = data.collections.find(c => c.id === collectionId);
    if (collection && !collection.tool_ids.includes(toolId)) {
      collection.tool_ids.push(toolId);
      this.saveData(data);
    }
  },

  removeToolFromCollection(collectionId: string, toolId: string): void {
    const data = this.getData();
    const collection = data.collections.find(c => c.id === collectionId);
    if (collection) {
      collection.tool_ids = collection.tool_ids.filter(id => id !== toolId);
      this.saveData(data);
    }
  },

  addRecentSearch(query: string): void {
    const data = this.getData();
    data.recent_searches = [query, ...data.recent_searches.filter(q => q !== query)].slice(0, 10);
    this.saveData(data);
  },

  getRecentSearches(): string[] {
    return this.getData().recent_searches;
  },

  setUserMode(mode: UserMode): void {
    const data = this.getData();
    data.ui_preferences.mode = mode;
    this.saveData(data);
  },

  getUserMode(): UserMode {
    return this.getData().ui_preferences.mode;
  },

  completeOnboarding(): void {
    this.saveData({ onboarding_completed: true });
  },

  isOnboardingCompleted(): boolean {
    return this.getData().onboarding_completed;
  },

  generateSessionId(): string {
    const stored = sessionStorage.getItem('session_id');
    if (stored) return stored;

    const newId = crypto.randomUUID();
    sessionStorage.setItem('session_id', newId);
    return newId;
  },

  getAdminToken(): string | null {
    try {
      const token = localStorage.getItem('admin_token');
      if (!token) return null;

      const data = JSON.parse(token);
      const expiresAt = new Date(data.expiresAt);

      if (expiresAt < new Date()) {
        this.clearAdminToken();
        return null;
      }

      return data.token;
    } catch {
      return null;
    }
  },

  setAdminToken(token: string, expiresInHours: number = 24): void {
    try {
      const expiresAt = new Date();
      expiresAt.setHours(expiresAt.getHours() + expiresInHours);

      const data = {
        token,
        expiresAt: expiresAt.toISOString()
      };

      localStorage.setItem('admin_token', JSON.stringify(data));
    } catch (error) {
      console.error('Failed to set admin token:', error);
    }
  },

  clearAdminToken(): void {
    try {
      localStorage.removeItem('admin_token');
    } catch (error) {
      console.error('Failed to clear admin token:', error);
    }
  },

  isAdminAuthenticated(): boolean {
    return this.getAdminToken() !== null;
  }
};
