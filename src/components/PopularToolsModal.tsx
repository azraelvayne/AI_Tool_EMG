import { useState, useEffect } from 'react';
import { TrendingUp, X } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { ToolCard } from './ToolCard';
import { Button } from './ui/Button';
import { db } from '../lib/database';
import type { Tool, CategoryMetadata } from '../types';

interface PopularToolsModalProps {
  isOpen: boolean;
  onClose: () => void;
  categories: CategoryMetadata[];
  onToolClick: (toolId: string) => void;
}

export function PopularToolsModal({ isOpen, onClose, categories, onToolClick }: PopularToolsModalProps) {
  const { t, i18n } = useTranslation();
  const [tools, setTools] = useState<Tool[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');

  useEffect(() => {
    if (isOpen) {
      loadPopularTools();
    }
  }, [isOpen, i18n.language]);

  const loadPopularTools = async () => {
    try {
      setLoading(true);
      const popularTools = await db.getPopularTools(20, i18n.language);
      setTools(popularTools);
    } catch (error) {
      console.error('Error loading popular tools:', error);
    } finally {
      setLoading(false);
    }
  };

  const filteredTools = selectedCategory === 'all'
    ? tools
    : tools.filter(tool => {
        const categories = tool.categories as any;
        return categories.purpose?.includes(selectedCategory) ||
               categories.functional_role?.includes(selectedCategory) ||
               categories.application_field?.includes(selectedCategory);
      });

  const purposeCategories = categories.filter(c => c.category_type === 'purpose');

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="" size="xl">
      <div className="flex items-center justify-between mb-6 pb-4 border-b border-gray-200">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-gradient-to-br from-orange-500 to-red-500 rounded-lg flex items-center justify-center">
            <TrendingUp size={20} className="text-white" />
          </div>
          <div>
            <h2 className="text-2xl font-bold text-gray-900">{t('popular.title')}</h2>
            <p className="text-sm text-gray-600">{t('popular.subtitle')}</p>
          </div>
        </div>
        <button
          onClick={onClose}
          className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
        >
          <X size={20} className="text-gray-500" />
        </button>
      </div>

      <div className="mb-6">
        <div className="flex gap-2 flex-wrap">
          <Button
            size="sm"
            variant={selectedCategory === 'all' ? 'primary' : 'outline'}
            onClick={() => setSelectedCategory('all')}
          >
            {t('filter.all')}
          </Button>
          {purposeCategories.slice(0, 6).map((category) => (
            <Button
              key={category.id}
              size="sm"
              variant={selectedCategory === category.category_value ? 'primary' : 'outline'}
              onClick={() => setSelectedCategory(category.category_value)}
            >
              {category.translated_value || category.category_value}
            </Button>
          ))}
        </div>
      </div>

      {loading ? (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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
      ) : filteredTools.length === 0 ? (
        <div className="text-center py-12">
          <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <TrendingUp size={32} className="text-gray-400" />
          </div>
          <h3 className="text-lg font-semibold text-gray-900 mb-2">{t('popular.no_tools')}</h3>
          <p className="text-gray-600">{t('popular.no_tools_desc')}</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 max-h-[60vh] overflow-y-auto">
          {filteredTools.map((tool, index) => (
            <div key={tool.id} className="relative">
              {index < 3 && (
                <div className="absolute -top-2 -left-2 z-10 w-8 h-8 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-full flex items-center justify-center text-white text-sm font-bold shadow-lg">
                  {index + 1}
                </div>
              )}
              <ToolCard
                tool={tool}
                categories={categories}
                onClick={() => onToolClick(tool.id || '')}
              />
            </div>
          ))}
        </div>
      )}

      <div className="mt-6 pt-4 border-t border-gray-200">
        <p className="text-sm text-gray-500 text-center">
          {t('popular.based_on', { count: filteredTools.length })}
        </p>
      </div>
    </Modal>
  );
}
