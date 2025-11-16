import { useState } from 'react';
import { Search, Sparkles, Filter, Grid, List } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Input } from '../components/ui/Input';
import { Button } from '../components/ui/Button';
import { ToolCard } from '../components/ToolCard';
import { FilterPanel } from '../components/FilterPanel';
import { ToolDetailModal } from '../components/ToolDetailModal';
import { LanguageSwitch } from '../components/LanguageSwitch';
import { PopularToolsModal } from '../components/PopularToolsModal';
import { FeaturedStacksModal } from '../components/FeaturedStacksModal';
import { AboutModal } from '../components/AboutModal';
import { AIRecommendationModal } from '../components/AIRecommendationModal';
import { useApp } from '../contexts/AppContext';
import { Modal } from '../components/ui/Modal';

export function HomePage() {
  const { t } = useTranslation();
  const { tools, categories, searchQuery, setSearchQuery, loading } = useApp();
  const [showFilters, setShowFilters] = useState(false);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  const [selectedToolId, setSelectedToolId] = useState<string | null>(null);
  const [showPopularTools, setShowPopularTools] = useState(false);
  const [showFeaturedStacks, setShowFeaturedStacks] = useState(false);
  const [showAbout, setShowAbout] = useState(false);
  const [showAIRecommendation, setShowAIRecommendation] = useState(false);

  const selectedTool = tools.find(t => t.id === selectedToolId) || null;

  const handleSearch = (value: string) => {
    setSearchQuery(value);
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="bg-gradient-to-br from-blue-600 via-teal-500 to-green-500 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <div className="absolute top-4 right-4">
            <LanguageSwitch />
          </div>
          <div className="text-center mb-8">
            <h1 className="text-4xl md:text-5xl font-bold mb-4">
              {t('home.title')}
            </h1>
            <p className="text-xl text-blue-50 max-w-2xl mx-auto">
              {t('home.subtitle')}
            </p>
          </div>

          <div className="max-w-3xl mx-auto">
            <div className="flex gap-3">
              <Input
                value={searchQuery}
                onChange={handleSearch}
                placeholder={t('home.search_placeholder')}
                icon={Search}
                className="flex-1"
              />
              <Button
                variant="secondary"
                icon={Sparkles}
                onClick={() => setShowAIRecommendation(true)}
              >
                {t('home.ai_generate')}
              </Button>
            </div>
          </div>

          <div className="mt-6 flex justify-center gap-4">
            <Button
              variant="ghost"
              size="sm"
              className="text-white hover:bg-white/10"
              onClick={() => setShowPopularTools(true)}
            >
              {t('home.popular_tools')}
            </Button>
            <Button
              variant="ghost"
              size="sm"
              className="text-white hover:bg-white/10"
              onClick={() => setShowFeaturedStacks(true)}
            >
              {t('home.featured_stacks')}
            </Button>
            <Button
              variant="ghost"
              size="sm"
              className="text-white hover:bg-white/10"
              onClick={() => setShowAbout(true)}
            >
              {t('home.learn_more')}
            </Button>
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
                  {searchQuery ? `${t('common.search')} "${searchQuery}"` : t('filter.all')}
                </h2>
                <p className="text-gray-600 mt-1">
                  {loading ? t('common.loading') : t('tool.tools_found', { count: tools.length })}
                </p>
              </div>

              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  icon={Filter}
                  onClick={() => setShowFilters(true)}
                  className="lg:hidden"
                >
                  {t('filter.title')}
                </Button>
                <button
                  onClick={() => setViewMode('grid')}
                  className={`p-2 rounded-lg transition-colors ${
                    viewMode === 'grid' ? 'bg-blue-100 text-blue-600' : 'text-gray-400 hover:bg-gray-100'
                  }`}
                >
                  <Grid size={20} />
                </button>
                <button
                  onClick={() => setViewMode('list')}
                  className={`p-2 rounded-lg transition-colors ${
                    viewMode === 'list' ? 'bg-blue-100 text-blue-600' : 'text-gray-400 hover:bg-gray-100'
                  }`}
                >
                  <List size={20} />
                </button>
              </div>
            </div>

            {loading ? (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {[...Array(6)].map((_, i) => (
                  <div key={i} className="bg-white rounded-xl border border-gray-200 p-6 animate-pulse">
                    <div className="flex items-start gap-3 mb-4">
                      <div className="w-12 h-12 bg-gray-200 rounded-lg" />
                      <div className="flex-1">
                        <div className="h-5 bg-gray-200 rounded w-1/2 mb-2" />
                        <div className="h-4 bg-gray-200 rounded w-3/4" />
                      </div>
                    </div>
                    <div className="flex gap-2">
                      <div className="h-6 bg-gray-200 rounded-full w-20" />
                      <div className="h-6 bg-gray-200 rounded-full w-24" />
                    </div>
                  </div>
                ))}
              </div>
            ) : tools.length === 0 ? (
              <div className="text-center py-16">
                <div className="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Search size={48} className="text-gray-400" />
                </div>
                <h3 className="text-xl font-semibold text-gray-900 mb-2">{t('tool.no_tools_found')}</h3>
                <p className="text-gray-600 mb-6">
                  {t('tool.try_adjusting')}
                </p>
                <Button icon={Sparkles}>
                  {t('home.ai_generate')}
                </Button>
              </div>
            ) : (
              <div className={viewMode === 'grid' ? 'grid grid-cols-1 md:grid-cols-2 gap-6' : 'space-y-4'}>
                {tools.map((tool) => (
                  <ToolCard
                    key={tool.id}
                    tool={tool}
                    categories={categories}
                    onClick={() => setSelectedToolId(tool.id || null)}
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
        title={t('filter.title')}
        size="lg"
      >
        <FilterPanel onClose={() => setShowFilters(false)} mobile />
      </Modal>

      <ToolDetailModal
        tool={selectedTool}
        isOpen={selectedToolId !== null}
        onClose={() => setSelectedToolId(null)}
        categories={categories}
      />

      <PopularToolsModal
        isOpen={showPopularTools}
        onClose={() => setShowPopularTools(false)}
        categories={categories}
        onToolClick={(toolId) => {
          setShowPopularTools(false);
          setSelectedToolId(toolId);
        }}
      />

      <FeaturedStacksModal
        isOpen={showFeaturedStacks}
        onClose={() => setShowFeaturedStacks(false)}
        categories={categories}
        onToolClick={(toolId) => {
          setShowFeaturedStacks(false);
          setSelectedToolId(toolId);
        }}
      />

      <AboutModal
        isOpen={showAbout}
        onClose={() => setShowAbout(false)}
      />

      <AIRecommendationModal
        isOpen={showAIRecommendation}
        onClose={() => setShowAIRecommendation(false)}
        allTools={tools}
        onApplyStack={(tools) => {
          setShowAIRecommendation(false);
        }}
      />
    </div>
  );
}
