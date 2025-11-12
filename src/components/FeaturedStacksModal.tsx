import { useState, useEffect } from 'react';
import { Layers, ChevronDown, ChevronUp, X, Clock, Users, Download } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Button } from './ui/Button';
import { Badge } from './ui/Badge';
import { db } from '../lib/database';
import type { Tool, FeaturedStack, CategoryMetadata } from '../types';

interface FeaturedStacksModalProps {
  isOpen: boolean;
  onClose: () => void;
  categories?: CategoryMetadata[];
  onToolClick: (toolId: string) => void;
}

interface StackWithTools extends FeaturedStack {
  tools: Tool[];
}

export function FeaturedStacksModal({ isOpen, onClose, onToolClick }: FeaturedStacksModalProps) {
  const { t, i18n } = useTranslation();
  const [stacks, setStacks] = useState<StackWithTools[]>([]);
  const [loading, setLoading] = useState(true);
  const [expandedStack, setExpandedStack] = useState<string | null>(null);

  useEffect(() => {
    if (isOpen) {
      loadFeaturedStacks();
    }
  }, [isOpen, i18n.language]);

  const loadFeaturedStacks = async () => {
    try {
      setLoading(true);
      const featuredStacks = await db.getFeaturedStacksWithTools(i18n.language);
      setStacks(featuredStacks);
    } catch (error) {
      console.error('Error loading featured stacks:', error);
    } finally {
      setLoading(false);
    }
  };

  const toggleStack = (stackId: string) => {
    setExpandedStack(expandedStack === stackId ? null : stackId);
  };

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'beginner':
        return 'bg-green-100 text-green-700';
      case 'intermediate':
        return 'bg-yellow-100 text-yellow-700';
      case 'advanced':
        return 'bg-red-100 text-red-700';
      default:
        return 'bg-gray-100 text-gray-700';
    }
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="" size="xl">
      <div className="flex items-center justify-between mb-6 pb-4 border-b border-gray-200">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-gradient-to-br from-purple-500 to-blue-500 rounded-lg flex items-center justify-center">
            <Layers size={20} className="text-white" />
          </div>
          <div>
            <h2 className="text-2xl font-bold text-gray-900">{t('featured.title')}</h2>
            <p className="text-sm text-gray-600">{t('featured.subtitle')}</p>
          </div>
        </div>
        <button
          onClick={onClose}
          className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
        >
          <X size={20} className="text-gray-500" />
        </button>
      </div>

      {loading ? (
        <div className="space-y-4">
          {[...Array(4)].map((_, i) => (
            <div key={i} className="bg-white rounded-xl border border-gray-200 p-6 animate-pulse">
              <div className="flex items-start gap-4 mb-4">
                <div className="w-12 h-12 bg-gray-200 rounded-lg" />
                <div className="flex-1">
                  <div className="h-6 bg-gray-200 rounded w-1/3 mb-2" />
                  <div className="h-4 bg-gray-200 rounded w-2/3 mb-2" />
                  <div className="h-4 bg-gray-200 rounded w-1/2" />
                </div>
              </div>
            </div>
          ))}
        </div>
      ) : stacks.length === 0 ? (
        <div className="text-center py-12">
          <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <Layers size={32} className="text-gray-400" />
          </div>
          <h3 className="text-lg font-semibold text-gray-900 mb-2">{t('featured.no_stacks')}</h3>
          <p className="text-gray-600">{t('featured.no_stacks_desc')}</p>
        </div>
      ) : (
        <div className="space-y-4 max-h-[70vh] overflow-y-auto">
          {stacks.map((stack) => (
            <div
              key={stack.id}
              className="bg-white rounded-xl border border-gray-200 hover:border-blue-300 transition-all overflow-hidden"
            >
              <div
                className="p-6 cursor-pointer"
                onClick={() => toggleStack(stack.id)}
              >
                <div className="flex items-start gap-4">
                  <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-purple-500 rounded-lg flex items-center justify-center flex-shrink-0">
                    <Layers size={24} className="text-white" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between gap-4 mb-2">
                      <h3 className="text-lg font-semibold text-gray-900">{stack.stack_name}</h3>
                      <button className="p-1 hover:bg-gray-100 rounded transition-colors flex-shrink-0">
                        {expandedStack === stack.id ? (
                          <ChevronUp size={20} className="text-gray-500" />
                        ) : (
                          <ChevronDown size={20} className="text-gray-500" />
                        )}
                      </button>
                    </div>
                    {stack.tagline && (
                      <p className="text-sm text-blue-600 font-medium mb-2">{stack.tagline}</p>
                    )}
                    <p className="text-gray-600 text-sm mb-3">{stack.description}</p>
                    <div className="flex flex-wrap gap-2">
                      <Badge className={getDifficultyColor(stack.difficulty_level || 'intermediate')}>
                        {t(`filter.${stack.difficulty_level}`) || stack.difficulty_level}
                      </Badge>
                      {stack.target_audience && stack.target_audience !== 'all' && (
                        <Badge className="bg-blue-100 text-blue-700 flex items-center gap-1">
                          <Users size={14} />
                          {t(`nav.${stack.target_audience}_mode`) || stack.target_audience}
                        </Badge>
                      )}
                      {stack.estimated_setup_time && (
                        <Badge className="bg-gray-100 text-gray-700 flex items-center gap-1">
                          <Clock size={14} />
                          {stack.estimated_setup_time}
                        </Badge>
                      )}
                      <Badge className="bg-purple-100 text-purple-700">
                        {stack.tools.length} {t('featured.tools')}
                      </Badge>
                    </div>
                  </div>
                </div>
              </div>

              {expandedStack === stack.id && (
                <div className="border-t border-gray-200 bg-gray-50 p-6">
                  <div className="mb-4">
                    <h4 className="text-sm font-semibold text-gray-900 mb-2">{t('featured.use_case')}</h4>
                    <p className="text-sm text-gray-600">{stack.use_case}</p>
                  </div>

                  <div className="mb-4">
                    <h4 className="text-sm font-semibold text-gray-900 mb-3">{t('featured.included_tools')}</h4>
                    <div className="grid grid-cols-1 gap-3">
                      {stack.tools.map((tool) => (
                        <button
                          key={tool.id}
                          onClick={() => onToolClick(tool.id || '')}
                          className="flex items-center gap-3 p-3 bg-white rounded-lg border border-gray-200 hover:border-blue-300 hover:shadow-sm transition-all text-left"
                        >
                          <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-500 rounded-lg flex items-center justify-center flex-shrink-0">
                            <span className="text-white text-sm font-bold">
                              {tool.tool_name.charAt(0)}
                            </span>
                          </div>
                          <div className="flex-1 min-w-0">
                            <h5 className="font-medium text-gray-900 text-sm">{tool.tool_name}</h5>
                            <p className="text-xs text-gray-600 truncate">{tool.summary}</p>
                          </div>
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="flex gap-2">
                    <Button size="sm" variant="outline" icon={Download}>
                      {t('featured.export_stack')}
                    </Button>
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </Modal>
  );
}
