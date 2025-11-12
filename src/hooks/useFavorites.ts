import { useState, useEffect } from 'react';

const FAVORITES_KEY = 'ai_tool_favorites';

export interface Favorites {
  goals: string[];
  inspirations: string[];
}

const defaultFavorites: Favorites = {
  goals: [],
  inspirations: []
};

export function useFavorites() {
  const [favorites, setFavorites] = useState<Favorites>(() => {
    try {
      const stored = localStorage.getItem(FAVORITES_KEY);
      if (stored) {
        return JSON.parse(stored);
      }
    } catch (error) {
      console.error('Failed to load favorites:', error);
    }
    return defaultFavorites;
  });

  useEffect(() => {
    try {
      localStorage.setItem(FAVORITES_KEY, JSON.stringify(favorites));
    } catch (error) {
      console.error('Failed to save favorites:', error);
    }
  }, [favorites]);

  const toggleGoalFavorite = (goalKey: string) => {
    setFavorites(prev => ({
      ...prev,
      goals: prev.goals.includes(goalKey)
        ? prev.goals.filter(k => k !== goalKey)
        : [...prev.goals, goalKey]
    }));
  };

  const toggleInspirationFavorite = (inspirationKey: string) => {
    setFavorites(prev => ({
      ...prev,
      inspirations: prev.inspirations.includes(inspirationKey)
        ? prev.inspirations.filter(k => k !== inspirationKey)
        : [...prev.inspirations, inspirationKey]
    }));
  };

  const isGoalFavorite = (goalKey: string) => {
    return favorites.goals.includes(goalKey);
  };

  const isInspirationFavorite = (inspirationKey: string) => {
    return favorites.inspirations.includes(inspirationKey);
  };

  const clearAllFavorites = () => {
    setFavorites(defaultFavorites);
  };

  const getFavoriteCount = () => {
    return favorites.goals.length + favorites.inspirations.length;
  };

  return {
    favorites,
    toggleGoalFavorite,
    toggleInspirationFavorite,
    isGoalFavorite,
    isInspirationFavorite,
    clearAllFavorites,
    getFavoriteCount
  };
}
