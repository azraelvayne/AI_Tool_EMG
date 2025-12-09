import { useState, useEffect } from 'react';
import { Search, Lightbulb, Grid, List, ArrowLeft, Filter as FilterIcon } from 'lucide-react';
import { Input } from '../components/ui/Input';
import { Button } from '../components/ui/Button';
import { Modal } from '../components/ui/Modal';
import { InspirationCard } from '../components/InspirationCard';
import { db } from '../lib/database';
import type { Inspiration, SkillLevel } from '../types';
import { Breadcrumb } from '../components/navigation/Breadcrumb';
import { PageTransition } from '../components/animations/PageTransition';

interface InspirationBrowsePageProps {
  language: 'en' | 'zh-TW';
  onInspirationSelect: (inspirationKey: string) => void;
  onBackToHome: () => void;
}

interface FilterState {
  difficulty: SkillLevel[];
  searchQuery: string;
}

export function InspirationBrowsePage({ language, onInspirationSelect, onBackToHome }: InspirationBrowsePageProps) {
  const [inspirations, setInspirations] = useState<Inspiration[]>([]);
  const [filteredInspirations, setFilteredInspirations] = useState<Inspiration[]>([]);
  const [loading, setLoading] = useState(true);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState<FilterState>({
    difficulty: [],
    searchQuery: ''
  });

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        if (showFilters) {
          setShowFilters(false);
        } else {
          onBackToHome();
        }
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [onBackToHome, showFilters]);

  useEffect(() => {
    const loadInspirations = async () => {
      try {
        setLoading(true);
        const data = await db.getInspirations(language);
        setInspirations(data);
        setFilteredInspirations(data);
      } catch (error) {
        console.error('Error loading inspirations:', error);
      } finally {
        setLoading(false);
      }
    };

    loadInspirations();
  }, [language]);

  useEffect(() => {
    let results = [...inspirations];

    if (filters.searchQuery) {
      const query = filters.searchQuery.toLowerCase();
      results = results.filter(
        inspiration =>
          (language === 'zh-TW' ? inspiration.title_zh_tw : inspiration.title_en).toLowerCase().includes(query) ||
          (language === 'zh-TW' ? inspiration.description_zh_tw : inspiration.description_en).toLowerCase().includes(query)
      );
    }

    if (filters.difficulty.length > 0) {
      results = results.filter(inspiration => filters.difficulty.includes(inspiration.difficulty));
    }

    setFilteredInspirations(results);
  }, [filters, inspirations, language]);

  const handleDifficultyToggle = (difficulty: SkillLevel) => {
    setFilters(prev => ({
      ...prev,
      difficulty: prev.difficulty.includes(difficulty)
        ? prev.difficulty.filter(d => d !== difficulty)
        : [...prev.difficulty, difficulty]
    }));
  };

  const clearFilters = () => {
    setFilters({
      difficulty: [],
      searchQuery: ''
    });
  };

  const title = language === 'zh-TW'
    ? '探索 AI 應用靈感案例'
    : 'Explore AI Application Inspirations';

  const subtitle = language === 'zh-TW'
    ? '從真實案例中學習，發現 AI 自動化的無限可能'
    : 'Learn from real-world examples and discover the endless possibilities of AI automation';

  const difficultyLabels: Record<SkillLevel, { en: string; zh: string }> = {
    beginner: { en: 'Beginner', zh: '初學者' },
    intermediate: { en: 'Intermediate', zh: '中級' },
    advanced: { en: 'Advanced', zh: '進階' }
  };

  const FilterPanel = ({ mobile = false }: { mobile?: boolean }) => (
    <div className={mobile ? 'p-4' : 'bg-white rounded-xl border border-gray-200 p-6'}>
      <div className="mb-6">
        <h3 className="font-semibold text-gray-900 mb-3">
          {language === 'zh-TW' ? '難度等級' : 'Difficulty Level'}
        </h3>
        <div className="space-y-2">
          {(['beginner', 'intermediate', 'advanced'] as SkillLevel[]).map(difficulty => (
            <label key={difficulty} className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={filters.difficulty.includes(difficulty)}
                onChange={() => handleDifficultyToggle(difficulty)}
                className="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500"
              />
              <span className="text-sm text-gray-700">
                {language === 'zh-TW' ? difficultyLabels[difficulty].zh : difficultyLabels[difficulty].en}
              </span>
            </label>
          ))}
        </div>
      </div>

      {(filters.difficulty.length > 0 || filters.searchQuery) && (
        <Button
          variant="outline"
          size="sm"
          onClick={clearFilters}
          className="w-full"
        >
          {language === 'zh-TW' ? '清除篩選' : 'Clear Filters'}
        </Button>
      )}
    </div>
  );

  return (
    <PageTransition className="min-h-screen bg-gray-50">
      <div className="bg-gradient-peach text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              {
                label: language === 'zh-TW' ? '首頁' : 'Home',
                onClick: onBackToHome
              },
              {
                label: language === 'zh-TW' ? '靈感瀏覽' : 'Browse Inspirations',
                isCurrentPage: true
              }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="text-center mb-8">
            <div className="inline-flex items-center gap-2 bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full mb-4">
              <Lightbulb className="w-5 h-5" />
              <span className="text-sm font-medium">
                {language === 'zh-TW' ? 'AI 應用靈感庫' : 'AI Application Inspiration Library'}
              </span>
            </div>
            <h1 className="text-4xl md:text-5xl font-bold mb-4">
              {title}
            </h1>
            <p className="text-xl text-orange-50 max-w-2xl mx-auto">
              {subtitle}
            </p>
          </div>

          <div className="max-w-3xl mx-auto">
            <Input
              value={filters.searchQuery}
              onChange={(value) => setFilters(prev => ({ ...prev, searchQuery: value }))}
              placeholder={language === 'zh-TW' ? '搜尋靈感案例...' : 'Search inspirations...'}
              icon={Search}
              className="flex-1"
            />
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex gap-8">
          <aside className="hidden lg:block w-80 flex-shrink-0">
            <div className="sticky top-8">
              <FilterPanel />
            </div>
          </aside>

          <main className="flex-1 min-w-0">
            <div className="flex items-center justify-between mb-6">
              <div>
                <h2 className="text-2xl font-bold text-gray-900">
                  {filters.searchQuery
                    ? `${language === 'zh-TW' ? '搜尋' : 'Search'} "${filters.searchQuery}"`
                    : language === 'zh-TW' ? '所有靈感案例' : 'All Inspirations'}
                </h2>
                <p className="text-gray-600 mt-1">
                  {loading
                    ? (language === 'zh-TW' ? '載入中...' : 'Loading...')
                    : `${filteredInspirations.length} ${language === 'zh-TW' ? '個案例' : 'cases found'}`}
                </p>
              </div>

              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  icon={FilterIcon}
                  onClick={() => setShowFilters(true)}
                  className="lg:hidden"
                >
                  {language === 'zh-TW' ? '篩選' : 'Filter'}
                </Button>
                <button
                  onClick={() => setViewMode('grid')}
                  className={`p-2 rounded-lg transition-colors ${
                    viewMode === 'grid' ? 'bg-orange-100 text-orange-600' : 'text-gray-400 hover:bg-gray-100'
                  }`}
                >
                  <Grid size={20} />
                </button>
                <button
                  onClick={() => setViewMode('list')}
                  className={`p-2 rounded-lg transition-colors ${
                    viewMode === 'list' ? 'bg-orange-100 text-orange-600' : 'text-gray-400 hover:bg-gray-100'
                  }`}
                >
                  <List size={20} />
                </button>
              </div>
            </div>

            {loading ? (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {[...Array(6)].map((_, i) => (
                  <div key={i} className="bg-white rounded-xl border border-gray-200 p-6 animate-pulse">
                    <div className="h-6 bg-gray-200 rounded w-3/4 mb-4" />
                    <div className="h-4 bg-gray-200 rounded w-full mb-2" />
                    <div className="h-4 bg-gray-200 rounded w-5/6 mb-4" />
                    <div className="flex gap-2">
                      <div className="h-6 bg-gray-200 rounded-full w-20" />
                      <div className="h-6 bg-gray-200 rounded-full w-24" />
                    </div>
                  </div>
                ))}
              </div>
            ) : filteredInspirations.length === 0 ? (
              <div className="text-center py-16">
                <div className="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Search size={48} className="text-gray-400" />
                </div>
                <h3 className="text-xl font-semibold text-gray-900 mb-2">
                  {language === 'zh-TW' ? '找不到符合的靈感案例' : 'No inspirations found'}
                </h3>
                <p className="text-gray-600 mb-6">
                  {language === 'zh-TW' ? '試試調整篩選條件或搜尋關鍵字' : 'Try adjusting your filters or search query'}
                </p>
                <Button onClick={clearFilters}>
                  {language === 'zh-TW' ? '清除篩選' : 'Clear Filters'}
                </Button>
              </div>
            ) : (
              <div className={viewMode === 'grid' ? 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6' : 'space-y-4'}>
                {filteredInspirations.map((inspiration) => (
                  <InspirationCard
                    key={inspiration.id}
                    inspiration={inspiration}
                    language={language}
                    onClick={() => onInspirationSelect(inspiration.inspiration_key)}
                  />
                ))}
              </div>
            )}
          </main>
        </div>
      </div>

      <Modal
        isOpen={showFilters}
        onClose={() => setShowFilters(false)}
        title={language === 'zh-TW' ? '篩選條件' : 'Filters'}
        size="lg"
      >
        <FilterPanel mobile />
      </Modal>
    </PageTransition>
  );
}
