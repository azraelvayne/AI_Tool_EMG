import { ReactNode, useState } from 'react';
import { Search, Sparkles, Filter, Grid, List } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Input } from './ui/Input';
import { Button } from './ui/Button';
import { ToolCard } from './ToolCard';
import { FilterPanel } from './FilterPanel';
import { ToolDetailModal } from './ToolDetailModal';
import { PopularToolsModal } from './PopularToolsModal';
import { FeaturedStacksModal } from './FeaturedStacksModal';
import { useApp } from '../contexts/AppContext';
import { Modal } from './ui/Modal';
import type { CategoryMetadata } from '../types';

interface ToolsExplorerLayoutProps {
  title?: string;
  subtitle?: string;
  showAIButton?: boolean;
  onAIClick?: () => void;
  headerActions?: ReactNode;
}

export function ToolsExplorerLayout({
  title,
  subtitle,
  showAIButton = true,
  onAIClick,
  headerActions,
}: ToolsExplorerLayoutProps) {
  const { t } = useTranslation();
  const { tools, categories, searchQuery, setSearchQuery, loading, error } = useApp();
  const [showFilters, setShowFilters] = useState(false);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  const [selectedToolId, setSelectedToolId] = useState<string | null>(null);
  const [showPopularTools, setShowPopularTools] = useState(false);
  const [showFeaturedStacks, setShowFeaturedStacks] = useState(false);

  const selectedTool = tools.find(t => t.id === selectedToolId) || null;

  const handleSearch = (value: string) => {
    setSearchQuery(value);
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="bg-gradient-hero-cool text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          {headerActions && (
            <div className="absolute top-4 right-4">
              {headerActions}
            </div>
          )}

          <div className="text-center mb-8">
            <h1 className="text-4xl md:text-5xl font-bold mb-4 drop-shadow-sm">
              {title || t('home.title')}
            </h1>
            <p className="text-xl text-white/90 max-w-2xl mx-auto drop-shadow-sm">
              {subtitle || t('home.subtitle')}
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
              {showAIButton && (
                <Button
                  variant="secondary"
                  icon={Sparkles}
                  onClick={onAIClick}
                >
                  {t('home.ai_generate')}
                </Button>
              )}
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

            {error ? (
              <div className="text-center py-16">
                <div className="w-24 h-24 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <svg className="w-12 h-12 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <h3 className="text-xl font-semibold text-gray-900 mb-2">{t('common.error')}</h3>
                <p className="text-gray-600 mb-6">{error}</p>
                <Button onClick={() => window.location.reload()}>
                  {t('common.retry')}
                </Button>
              </div>
            ) : loading ? (
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
                {showAIButton && (
                  <Button icon={Sparkles} onClick={onAIClick}>
                    {t('home.ai_generate')}
                  </Button>
                )}
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
    </div>
  );
}
