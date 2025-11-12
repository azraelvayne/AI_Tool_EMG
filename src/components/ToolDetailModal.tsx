import { useState } from 'react';
import { X, Star, Download, Copy, Sparkles, ExternalLink, BookOpen, Map, Target, Lightbulb } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Badge } from './ui/Badge';
import { Button } from './ui/Button';
import { ExportModal } from './ExportModal';
import type { Tool, CategoryMetadata } from '../types';
import { useApp } from '../contexts/AppContext';
import { exportUtils } from '../lib/export';
import * as Icons from 'lucide-react';

interface ToolDetailModalProps {
  tool: Tool | null;
  isOpen: boolean;
  onClose: () => void;
  categories: CategoryMetadata[];
}

type TabType = 'encyclopedia' | 'guide' | 'strategy' | 'inspiration';

export function ToolDetailModal({ tool, isOpen, onClose, categories }: ToolDetailModalProps) {
  const { t } = useTranslation();
  const { favorites, toggleFavorite, getTranslatedCategoryValue } = useApp();
  const [activeTab, setActiveTab] = useState<TabType>('encyclopedia');
  const [showExport, setShowExport] = useState(false);

  if (!tool) return null;

  const isFavorited = favorites.includes(tool.id || '');
  const toolCategories = tool.categories as any;
  const descriptions = tool.description_styles as any;

  const getIcon = (iconName: string) => {
    if (!iconName) return Icons.Box;
    const IconComponent = (Icons as any)[iconName.split('-').map((word: string, i: number) =>
      i === 0 ? word : word.charAt(0).toUpperCase() + word.slice(1)
    ).join('')];
    return IconComponent || Icons.Box;
  };

  const getCategoryMetadata = (categoryType: string, value: string) => {
    return categories.find(c => c.category_type === categoryType && c.category_value === value);
  };

  const tabs = [
    { id: 'encyclopedia' as TabType, label: t('detail.tabs.encyclopedia'), icon: BookOpen, description: t('detail.tabs.encyclopedia_desc') },
    { id: 'guide' as TabType, label: t('detail.tabs.guide'), icon: Map, description: t('detail.tabs.guide_desc') },
    { id: 'strategy' as TabType, label: t('detail.tabs.strategy'), icon: Target, description: t('detail.tabs.strategy_desc') },
    { id: 'inspiration' as TabType, label: t('detail.tabs.inspiration'), icon: Lightbulb, description: t('detail.tabs.inspiration_desc') }
  ];

  return (
    <Modal isOpen={isOpen} onClose={onClose} size="xl">
      <div className="relative">
        <button
          onClick={onClose}
          className="absolute top-0 right-0 p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 rounded-lg transition-colors z-10"
        >
          <X size={24} />
        </button>

        <div className="pr-12">
          <div className="flex items-start gap-4 mb-6">
            {(() => {
              const primaryRole = toolCategories.functional_role?.[0];
              const roleMetadata = primaryRole ? getCategoryMetadata('functional_role', primaryRole) : null;
              const RoleIcon = roleMetadata ? getIcon(roleMetadata.icon_name) : Icons.Box;

              return (
                <div
                  className="w-16 h-16 rounded-xl flex items-center justify-center flex-shrink-0"
                  style={{ backgroundColor: roleMetadata?.color_hex + '20' }}
                >
                  <RoleIcon size={32} style={{ color: roleMetadata?.color_hex }} />
                </div>
              );
            })()}

            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 mb-2">
                <h1 className="text-3xl font-bold text-gray-900">{tool.tool_name}</h1>
                {tool.is_verified && (
                  <Badge color="#10B981" icon={Sparkles} size="sm">
                    {t('tool.verified')}
                  </Badge>
                )}
              </div>
              <p className="text-lg text-gray-600 mb-4">{tool.summary}</p>

              <div className="flex flex-wrap gap-2">
                <Button
                  size="sm"
                  icon={isFavorited ? Star : Star}
                  onClick={() => toggleFavorite(tool.id || '')}
                  variant={isFavorited ? 'primary' : 'outline'}
                >
                  {isFavorited ? t('tool.favorited') : t('tool.add_favorite')}
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  icon={Download}
                  onClick={() => setShowExport(true)}
                >
                  {t('detail.export_btn')}
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  icon={Copy}
                  onClick={() => {
                    exportUtils.copyToClipboard(exportUtils.exportJSON(tool, true));
                  }}
                >
                  {t('detail.copy_json')}
                </Button>
              </div>
            </div>
          </div>

          <div className="mb-6">
            <h3 className="text-sm font-semibold text-gray-700 mb-3">{t('tool.classifications')}</h3>
            <div className="flex flex-wrap gap-2">
              {toolCategories.purpose?.map((purpose: string) => {
                const metadata = getCategoryMetadata('purpose', purpose);
                const Icon = metadata ? getIcon(metadata.icon_name) : undefined;
                return (
                  <Badge key={purpose} color={metadata?.color_hex} icon={Icon}>
                    {getTranslatedCategoryValue(purpose)}
                  </Badge>
                );
              })}
              {toolCategories.functional_role?.map((role: string) => {
                const metadata = getCategoryMetadata('functional_role', role);
                const Icon = metadata ? getIcon(metadata.icon_name) : undefined;
                return (
                  <Badge key={role} color={metadata?.color_hex} icon={Icon}>
                    {getTranslatedCategoryValue(role)}
                  </Badge>
                );
              })}
              {toolCategories.tech_layer?.map((layer: string) => {
                const metadata = getCategoryMetadata('tech_layer', layer);
                const Icon = metadata ? getIcon(metadata.icon_name) : undefined;
                return (
                  <Badge key={layer} color={metadata?.color_hex} icon={Icon}>
                    {getTranslatedCategoryValue(layer)}
                  </Badge>
                );
              })}
              {toolCategories.difficulty && (() => {
                const metadata = getCategoryMetadata('difficulty', toolCategories.difficulty);
                const Icon = metadata ? getIcon(metadata.icon_name) : undefined;
                return (
                  <Badge color={metadata?.color_hex} icon={Icon}>
                    {getTranslatedCategoryValue(toolCategories.difficulty)}
                  </Badge>
                );
              })()}
            </div>
          </div>

          <div className="border-b border-gray-200 mb-6">
            <div className="flex gap-1 overflow-x-auto">
              {tabs.map((tab) => (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`flex items-center gap-2 px-4 py-3 border-b-2 transition-colors whitespace-nowrap ${
                    activeTab === tab.id
                      ? 'border-blue-600 text-blue-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                  }`}
                >
                  <tab.icon size={18} />
                  <div className="text-left">
                    <div className="font-medium">{tab.label}</div>
                    <div className="text-xs opacity-75">{tab.description}</div>
                  </div>
                </button>
              ))}
            </div>
          </div>

          <div className="min-h-[200px]">
            {activeTab === 'encyclopedia' && (
              <div className="prose max-w-none">
                <p className="text-lg text-gray-700 leading-relaxed">
                  {descriptions.encyclopedia}
                </p>
              </div>
            )}

            {activeTab === 'guide' && (
              <div className="prose max-w-none">
                <p className="text-gray-700 leading-relaxed">
                  {descriptions.guide}
                </p>
              </div>
            )}

            {activeTab === 'strategy' && (
              <div className="prose max-w-none">
                <p className="text-gray-700 leading-relaxed mb-6">
                  {descriptions.strategy}
                </p>

                {tool.use_case_templates && tool.use_case_templates.length > 0 && (
                  <div className="mt-6">
                    <h4 className="text-lg font-semibold text-gray-900 mb-4">{t('tool.use_case_templates')}</h4>
                    {tool.use_case_templates.map((useCase, index) => (
                      <div key={index} className="bg-gray-50 rounded-lg p-4 mb-4">
                        <h5 className="font-semibold text-gray-900 mb-2">{useCase.goal}</h5>
                        <p className="text-sm text-gray-600 mb-3">{t('tool.method')}: {useCase.method}</p>
                        <div className="mb-3">
                          <span className="text-sm font-medium text-gray-700">{t('tool.stack')}: </span>
                          <div className="flex flex-wrap gap-2 mt-1">
                            {useCase.tool_stack.map((tool) => (
                              <Badge key={tool} size="sm">{tool}</Badge>
                            ))}
                          </div>
                        </div>
                        <div>
                          <span className="text-sm font-medium text-gray-700 mb-2 block">{t('tool.steps')}:</span>
                          <ol className="list-decimal list-inside space-y-1 text-sm text-gray-600">
                            {useCase.steps.map((step, i) => (
                              <li key={i}>{step}</li>
                            ))}
                          </ol>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}

            {activeTab === 'inspiration' && (
              <div>
                <p className="text-gray-600 mb-4">{t('tool.creative_ideas_for')} {tool.tool_name}:</p>
                <div className="space-y-4">
                  {descriptions.inspiration?.map((idea: string, index: number) => (
                    <div key={index} className="bg-gradient-to-br from-blue-50 to-teal-50 rounded-lg p-4 border border-blue-100">
                      <div className="flex items-start gap-3">
                        <div className="w-8 h-8 rounded-full bg-blue-600 text-white flex items-center justify-center flex-shrink-0 font-bold">
                          {index + 1}
                        </div>
                        <p className="text-gray-700 flex-1">{idea}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {toolCategories.common_pairings && toolCategories.common_pairings.length > 0 && (
            <div className="mt-8 pt-6 border-t border-gray-200">
              <h4 className="text-lg font-semibold text-gray-900 mb-4">{t('tool.commonly_paired_with')}</h4>
              <div className="flex flex-wrap gap-2">
                {toolCategories.common_pairings.map((pairing: string) => (
                  <button
                    key={pairing}
                    className="flex items-center gap-2 px-4 py-2 bg-white border-2 border-gray-200 rounded-lg hover:border-blue-300 hover:bg-blue-50 transition-colors"
                  >
                    <span className="font-medium text-gray-900">{pairing}</span>
                    <ExternalLink size={14} className="text-gray-400" />
                  </button>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>

      {tool && (
        <ExportModal
          tool={tool}
          isOpen={showExport}
          onClose={() => setShowExport(false)}
        />
      )}
    </Modal>
  );
}
