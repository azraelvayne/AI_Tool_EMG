import type { LocalStorageData, Collection, UserMode } from '../types';

const STORAGE_KEY = 'ai_mapper_data';

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
    try {
      const current = this.getData();
      const updated = { ...current, ...data };
      localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
    } catch (error) {
      console.error('Failed to save to localStorage:', error);
    }
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
  }
};
