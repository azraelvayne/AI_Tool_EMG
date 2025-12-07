import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import type { Tool, CategoryMetadata, FilterState, UserMode } from '../types';
import { db } from '../lib/database';
import { storage } from '../lib/localStorage';

interface AppContextType {
  tools: Tool[];
  categories: CategoryMetadata[];
  filters: FilterState;
  setFilters: (filters: FilterState) => void;
  toolNames: string[];
  setToolNames: (names: string[]) => void;
  favorites: string[];
  toggleFavorite: (toolId: string) => void;
  userMode: UserMode;
  setUserMode: (mode: UserMode) => void;
  searchQuery: string;
  setSearchQuery: (query: string) => void;
  loading: boolean;
  error: string | null;
  refreshTools: () => Promise<void>;
  getTranslatedCategoryValue: (categoryValue: string) => string;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

export function AppProvider({ children }: { children: ReactNode }) {
  const { i18n } = useTranslation();
  const [tools, setTools] = useState<Tool[]>([]);
  const [categories, setCategories] = useState<CategoryMetadata[]>([]);
  const [filters, setFilters] = useState<FilterState>({
    purpose: [],
    functional_role: [],
    tech_layer: [],
    data_flow_role: [],
    difficulty: [],
    application_field: []
  });
  const [favorites, setFavorites] = useState<string[]>([]);
  const [userMode, setUserModeState] = useState<UserMode>('creator');
  const [searchQuery, setSearchQuery] = useState('');
  const [toolNames, setToolNames] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    loadInitialData();
  }, []);

  useEffect(() => {
    loadInitialData();
  }, [i18n.language]);

  useEffect(() => {
    filterTools();
  }, [filters, searchQuery, toolNames]);

  const loadInitialData = async () => {
    try {
      setLoading(true);
      setError(null);
      const currentLang = i18n.language;
      const [toolsData, categoriesData] = await Promise.all([
        db.getToolsWithTranslations(currentLang),
        db.getCategoryMetadata(currentLang)
      ]);
      setTools(toolsData);
      setCategories(categoriesData);
      setFavorites(storage.getFavorites());
      setUserModeState(storage.getUserMode());
    } catch (error) {
      console.error('Error loading data:', error);
      setError(error instanceof Error ? error.message : 'Failed to load data');
    } finally {
      setLoading(false);
    }
  };

  const filterTools = async () => {
    try {
      setError(null);
      const currentLang = i18n.language;
      const filtered = await db.getToolsWithTranslations(currentLang, {
        search: searchQuery,
        toolNames: toolNames.length > 0 ? toolNames : undefined,
        ...filters
      });
      setTools(filtered);
    } catch (error) {
      console.error('Error filtering tools:', error);
      setError(error instanceof Error ? error.message : 'Failed to filter tools');
    }
  };

  const getTranslatedCategoryValue = (categoryValue: string): string => {
    const category = categories.find(c => c.category_value === categoryValue);
    return category?.translated_value || categoryValue;
  };

  const refreshTools = async () => {
    await loadInitialData();
  };

  const toggleFavorite = (toolId: string) => {
    if (storage.isFavorite(toolId)) {
      storage.removeFavorite(toolId);
    } else {
      storage.addFavorite(toolId);
    }
    setFavorites(storage.getFavorites());
  };

  const setUserMode = (mode: UserMode) => {
    storage.setUserMode(mode);
    setUserModeState(mode);
  };

  return (
    <AppContext.Provider
      value={{
        tools,
        categories,
        filters,
        setFilters,
        toolNames,
        setToolNames,
        favorites,
        toggleFavorite,
        userMode,
        setUserMode,
        searchQuery,
        setSearchQuery,
        loading,
        error,
        refreshTools,
        getTranslatedCategoryValue
      }}
    >
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within AppProvider');
  }
  return context;
}
