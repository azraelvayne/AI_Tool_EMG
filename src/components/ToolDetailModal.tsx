import { useState, useEffect } from 'react';
import { X, Star, Download, Copy, Sparkles, ExternalLink, BookOpen, Map, Target, Lightbulb, Package, Link as LinkIcon, FileJson, Code } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Badge } from './ui/Badge';
import { Button } from './ui/Button';
import { ExportModal } from './ExportModal';
import type { Tool, CategoryMetadata } from '../types';
import { useApp } from '../contexts/AppContext';
import { exportUtils } from '../lib/export';
import { db } from '../lib/database';
import * as Icons from 'lucide-react';

interface ToolDetailModalProps {
  tool: Tool | null;
  isOpen: boolean;
  onClose: () => void;
  categories: CategoryMetadata[];
}

type TabType = 'encyclopedia' | 'guide' | 'strategy' | 'inspiration' | 'templates' | 'pairings';

export function ToolDetailModal({ tool, isOpen, onClose, categories }: ToolDetailModalProps) {
  const { t } = useTranslation();
  const { favorites, toggleFavorite, getTranslatedCategoryValue } = useApp();
  const [activeTab, setActiveTab] = useState<TabType>('encyclopedia');
  const [showExport, setShowExport] = useState(false);
  const [exportTemplates, setExportTemplates] = useState<any[]>([]);
  const [toolPairings, setToolPairings] = useState<any[]>([]);
  const [loadingTemplates, setLoadingTemplates] = useState(false);
  const [loadingPairings, setLoadingPairings] = useState(false);

  useEffect(() => {
    if (tool?.id && isOpen) {
      loadExportTemplates();
      loadToolPairings();
    }
  }, [tool?.id, isOpen]);

  const loadExportTemplates = async () => {
    if (!tool?.id) return;
    try {
      setLoadingTemplates(true);
      const templates = await db.getExportTemplates(tool.id);
      setExportTemplates(templates || []);
    } catch (error) {
      console.error('Failed to load export templates:', error);
      setExportTemplates([]);
    } finally {
      setLoadingTemplates(false);
    }
  };

  const loadToolPairings = async () => {
    if (!tool?.id) return;
    try {
      setLoadingPairings(true);
      const pairings = await db.getToolPairings(tool.id);
      setToolPairings(pairings || []);
    } catch (error) {
      console.error('Failed to load tool pairings:', error);
      setToolPairings([]);
    } finally {
      setLoadingPairings(false);
    }
  };

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
    { id: 'inspiration' as TabType, label: t('detail.tabs.inspiration'), icon: Lightbulb, description: t('detail.tabs.inspiration_desc') },
    { id: 'templates' as TabType, label: 'Export Templates', icon: FileJson, description: 'Ready-to-use workflow templates', badge: exportTemplates.length },
    { id: 'pairings' as TabType, label: 'Tool Pairings', icon: LinkIcon, description: 'Recommended tool combinations', badge: toolPairings.length }
  ];

  const handleDownloadTemplate = (template: any) => {
    if (template.format === 'json') {
      const filename = `${tool.tool_name.toLowerCase().replace(/\s+/g, '-')}-${template.platform}-template.json`;
      exportUtils.downloadFile(
        JSON.stringify(template.payload, null, 2),
        filename,
        'application/json'
      );
    }
  };

  const getPairedTool = async (pairing: any) => {
    const pairedToolId = pairing.tool_id_1 === tool.id ? pairing.tool_id_2 : pairing.tool_id_1;
    return await db.getToolById(pairedToolId);
  };

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
                  className={`flex items-center gap-2 px-4 py-3 border-b-2 transition-colors whitespace-nowrap relative ${
                    activeTab === tab.id
                      ? 'border-blue-600 text-blue-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                  }`}
                >
                  <tab.icon size={18} />
                  <div className="text-left">
                    <div className="font-medium flex items-center gap-2">
                      {tab.label}
                      {tab.badge !== undefined && tab.badge > 0 && (
                        <span className="inline-flex items-center justify-center w-5 h-5 text-xs font-bold text-white bg-blue-600 rounded-full">
                          {tab.badge}
                        </span>
                      )}
                    </div>
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

            {activeTab === 'templates' && (
              <div>
                <p className="text-gray-600 mb-4">Ready-to-use templates for {tool.tool_name} across popular platforms:</p>
                {loadingTemplates ? (
                  <div className="text-center py-8">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
                    <p className="text-gray-500 mt-2">Loading templates...</p>
                  </div>
                ) : exportTemplates.length === 0 ? (
                  <div className="text-center py-8 bg-gray-50 rounded-lg">
                    <Package className="w-12 h-12 text-gray-300 mx-auto mb-2" />
                    <p className="text-gray-600">No export templates available yet</p>
                    <p className="text-sm text-gray-500 mt-1">Templates are being added regularly</p>
                  </div>
                ) : (
                  <div className="space-y-4">
                    {exportTemplates.map((template) => (
                      <div key={template.id} className="border border-gray-200 rounded-lg p-4 hover:border-blue-300 transition-colors">
                        <div className="flex items-start justify-between mb-2">
                          <div className="flex items-center gap-2">
                            {template.platform === 'n8n' && <div className="px-2 py-1 bg-pink-100 text-pink-700 text-xs font-semibold rounded">n8n</div>}
                            {template.platform === 'langflow' && <div className="px-2 py-1 bg-purple-100 text-purple-700 text-xs font-semibold rounded">Langflow</div>}
                            {template.platform === 'zapier' && <div className="px-2 py-1 bg-orange-100 text-orange-700 text-xs font-semibold rounded">Zapier</div>}
                            <span className="text-xs text-gray-500">{template.version}</span>
                          </div>
                          <Badge size="sm">{template.format.toUpperCase()}</Badge>
                        </div>
                        <h4 className="font-medium text-gray-900 mb-1">
                          {template.payload?.name || template.payload?.title || `${tool.tool_name} Template`}
                        </h4>
                        <p className="text-sm text-gray-600 mb-3">
                          {template.payload?.description || `${template.format === 'json' ? 'Importable workflow' : 'Setup guide'} for ${template.platform}`}
                        </p>
                        <div className="flex gap-2">
                          {template.format === 'json' && (
                            <Button size="sm" icon={Download} onClick={() => handleDownloadTemplate(template)}>
                              Download JSON
                            </Button>
                          )}
                          {template.format === 'guide' && template.payload?.template_url && (
                            <Button
                              size="sm"
                              variant="outline"
                              icon={ExternalLink}
                              onClick={() => window.open(template.payload.template_url, '_blank')}
                            >
                              View Template
                            </Button>
                          )}
                          <Button
                            size="sm"
                            variant="outline"
                            icon={Copy}
                            onClick={() => {
                              exportUtils.copyToClipboard(JSON.stringify(template.payload, null, 2));
                            }}
                          >
                            Copy
                          </Button>
                        </div>
                        {template.format === 'guide' && template.payload?.setup_steps && (
                          <div className="mt-3 pt-3 border-t border-gray-100">
                            <p className="text-xs font-semibold text-gray-700 mb-2">Setup Steps:</p>
                            <ol className="list-decimal list-inside text-sm text-gray-600 space-y-1">
                              {template.payload.setup_steps.map((step: string, idx: number) => (
                                <li key={idx}>{step}</li>
                              ))}
                            </ol>
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}

            {activeTab === 'pairings' && (
              <div>
                <p className="text-gray-600 mb-4">Tools that work well with {tool.tool_name}:</p>
                {loadingPairings ? (
                  <div className="text-center py-8">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
                    <p className="text-gray-500 mt-2">Loading pairings...</p>
                  </div>
                ) : toolPairings.length === 0 ? (
                  <div className="text-center py-8 bg-gray-50 rounded-lg">
                    <LinkIcon className="w-12 h-12 text-gray-300 mx-auto mb-2" />
                    <p className="text-gray-600">No tool pairings available yet</p>
                    <p className="text-sm text-gray-500 mt-1">Check back soon for recommendations</p>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {toolPairings.map((pairing) => {
                      const isAlternative = pairing.relationship_type === 'alternative_to';
                      const isComplement = pairing.relationship_type === 'complements';
                      const strengthPercent = (pairing.strength / 10) * 100;

                      return (
                        <div key={pairing.id} className="border border-gray-200 rounded-lg p-4 hover:border-blue-300 transition-colors">
                          <div className="flex items-start justify-between mb-2">
                            <div className="flex items-center gap-2 flex-1">
                              <Code className="w-4 h-4 text-gray-400" />
                              <span className="font-medium text-gray-900">
                                {pairing.tool_id_1 === tool.id ? 'Tool 2' : 'Tool 1'}
                              </span>
                            </div>
                            <div className="flex items-center gap-2">
                              {isAlternative && (
                                <Badge size="sm" color="#F59E0B">Alternative</Badge>
                              )}
                              {isComplement && (
                                <Badge size="sm" color="#8B5CF6">Complements</Badge>
                              )}
                              {!isAlternative && !isComplement && (
                                <Badge size="sm" color="#10B981">Integrates</Badge>
                              )}
                            </div>
                          </div>
                          <div className="mb-3">
                            <div className="flex items-center justify-between text-xs text-gray-600 mb-1">
                              <span>Integration Strength</span>
                              <span className="font-semibold">{pairing.strength}/10</span>
                            </div>
                            <div className="w-full bg-gray-200 rounded-full h-2">
                              <div
                                className="bg-blue-600 h-2 rounded-full transition-all"
                                style={{ width: `${strengthPercent}%` }}
                              ></div>
                            </div>
                          </div>
                          {pairing.rationale && (
                            <p className="text-sm text-gray-700 leading-relaxed">{pairing.rationale}</p>
                          )}
                        </div>
                      );
                    })}
                  </div>
                )}
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
