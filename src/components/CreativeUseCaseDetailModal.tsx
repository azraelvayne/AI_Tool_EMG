import { useState, useEffect } from 'react';
import { Lightbulb, Clock, Target, Sparkles, ArrowRight, Layers, Tag, Box } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Badge } from './ui/Badge';
import { Button } from './ui/Button';
import { ComplexityBadge } from './ComplexityBadge';
import { db } from '../lib/database';
import type { Tool } from '../types';

const TAG_DICTIONARY: Record<string, { label: string; type: 'tech' | 'category' | 'platform' }> = {
  'automation': { label: '自動化', type: 'category' },
  'marketing': { label: '行銷', type: 'category' },
  'sales': { label: '銷售', type: 'category' },
  'analytics': { label: '數據分析', type: 'tech' },
  'content-creation': { label: '內容創作', type: 'category' },
  'content creation': { label: '內容創作', type: 'category' },
  'n8n': { label: 'n8n 流程', type: 'platform' },
  'zapier': { label: 'Zapier', type: 'platform' },
  'openai': { label: 'OpenAI API', type: 'tech' },
  'webhook': { label: 'Webhook 串接', type: 'tech' },
  'api': { label: 'API 整合', type: 'tech' },
  'database': { label: '資料庫', type: 'tech' },
  'crm': { label: '客戶管理 (CRM)', type: 'category' },
  'seo': { label: 'SEO 優化', type: 'category' },
  'social-media': { label: '社群媒體', type: 'category' },
  'social media': { label: '社群媒體', type: 'category' },
  'workflow': { label: '工作流程', type: 'category' },
  'ai': { label: 'AI 技術', type: 'tech' },
  'notion': { label: 'Notion', type: 'platform' },
  'airtable': { label: 'Airtable', type: 'platform' },
  'slack': { label: 'Slack', type: 'platform' },
  'discord': { label: 'Discord', type: 'platform' },
  'telegram': { label: 'Telegram', type: 'platform' },
  'email': { label: '電子郵件', type: 'tech' },
  'data-processing': { label: '數據處理', type: 'tech' },
  'data processing': { label: '數據處理', type: 'tech' },
  'scheduling': { label: '排程管理', type: 'category' },
  'communication': { label: '溝通協作', type: 'category' },
  'productivity': { label: '生產力', type: 'category' },
  'health': { label: '健康', type: 'category' },
  'rehabilitation': { label: '康復訓練', type: 'category' },
  'recovery': { label: '恢復追蹤', type: 'category' },
  'exercise': { label: '運動記錄', type: 'category' },
};

interface CreativeUseCaseDetailModalProps {
  useCase: any | null;
  isOpen: boolean;
  onClose: () => void;
  language: 'en' | 'zh-TW';
  onApplyStack?: (tools: string[]) => void;
}

export function CreativeUseCaseDetailModal({
  useCase,
  isOpen,
  onClose,
  language,
  onApplyStack
}: CreativeUseCaseDetailModalProps) {
  const { t } = useTranslation();
  const [relatedTools, setRelatedTools] = useState<Tool[]>([]);
  const [loadingTools, setLoadingTools] = useState(false);

  useEffect(() => {
    if (useCase && isOpen) {
      loadRelatedTools();
    }
  }, [useCase, isOpen]);

  const loadRelatedTools = async () => {
    if (!useCase?.tools || useCase.tools.length === 0) {
      setRelatedTools([]);
      return;
    }

    try {
      setLoadingTools(true);
      const allTools = await db.getTools();
      const related = allTools.filter(tool =>
        useCase.tools.some((toolSlug: string) =>
          tool.tool_name.toLowerCase().includes(toolSlug.toLowerCase()) ||
          (tool as any).source_slug === toolSlug
        )
      );
      setRelatedTools(related);
    } catch (error) {
      console.error('Failed to load related tools:', error);
      setRelatedTools([]);
    } finally {
      setLoadingTools(false);
    }
  };

  if (!useCase) return null;

  const title = language === 'zh-TW' ? useCase.title_zh_tw || useCase.title : useCase.title_en || useCase.title;
  const description = language === 'zh-TW' ? useCase.description_zh_tw || useCase.description : useCase.description_en || useCase.description;

  const workflowSteps = typeof useCase.workflow_steps === 'string'
    ? JSON.parse(useCase.workflow_steps)
    : useCase.workflow_steps || [];

  const handleApplyStack = () => {
    if (onApplyStack && useCase.tools) {
      onApplyStack(useCase.tools);
      onClose();
    }
  };

  const renderTag = (tag: string) => {
    const normalizedTag = tag.toLowerCase().replace(/\s+/g, '-');
    const info = TAG_DICTIONARY[normalizedTag] || TAG_DICTIONARY[tag.toLowerCase()];

    const displayLabel = info ? info.label : tag.charAt(0).toUpperCase() + tag.slice(1);

    let badgeStyle = "bg-gray-100 text-gray-700 border-gray-200";
    let icon = <Tag className="w-3 h-3 mr-1" />;

    if (info?.type === 'platform') {
      badgeStyle = "bg-blue-50 text-blue-700 border-blue-200";
      icon = <Box className="w-3 h-3 mr-1" />;
    } else if (info?.type === 'tech') {
      badgeStyle = "bg-slate-50 text-slate-700 border-slate-200";
      icon = <Layers className="w-3 h-3 mr-1" />;
    } else if (info?.type === 'category') {
      badgeStyle = "bg-green-50 text-green-700 border-green-200";
    }

    return (
      <Badge key={tag} className={`${badgeStyle} flex items-center px-2 py-1`}>
        {icon}
        {displayLabel}
      </Badge>
    );
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} size="xl">
      <div className="space-y-6">
        <div className="flex items-start gap-5">
          <div className="w-20 h-20 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center flex-shrink-0 shadow-lg shadow-purple-100">
            <Lightbulb className="w-10 h-10 text-white" />
          </div>

          <div className="flex-1 min-w-0 pt-1">
            <div className="flex items-center gap-3 mb-3 flex-wrap">
              <h1 className="text-2xl md:text-3xl font-bold text-gray-900 leading-tight">
                {title}
              </h1>
              <ComplexityBadge level={useCase.difficulty} language={language} />
            </div>

            <p className="text-lg text-gray-600 leading-relaxed mb-4">
              {description}
            </p>

            <div className="flex items-center gap-6 text-sm text-gray-500 pb-2 border-b border-gray-100">
              {useCase.estimated_time && (
                <div className="flex items-center gap-1.5">
                  <Clock className="w-4 h-4 text-gray-400" />
                  <span>{t('common.estimated_time')}: <span className="font-medium text-gray-700">{useCase.estimated_time}</span></span>
                </div>
              )}
              {useCase.export_format && useCase.export_format.length > 0 && (
                <div className="flex items-center gap-1.5">
                  <Target className="w-4 h-4 text-gray-400" />
                  <span>{t('creative_use_cases.supported_export_formats')}: <span className="font-medium text-gray-700">{useCase.export_format.join(', ')}</span></span>
                </div>
              )}
            </div>
          </div>
        </div>

        {useCase.use_case_tags && useCase.use_case_tags.length > 0 && (
          <div className="flex flex-wrap gap-2">
            {useCase.use_case_tags.map((tag: string) => renderTag(tag))}
          </div>
        )}

        {workflowSteps && workflowSteps.length > 0 && (
          <div className="mt-8 bg-gray-50/50 rounded-2xl p-6 md:p-8 border border-gray-100">
            <h3 className="text-lg font-bold text-gray-900 mb-8 flex items-center gap-2">
              <Layers className="w-5 h-5 text-indigo-600" />
              {t('creative_use_cases.implementation_steps')}
            </h3>

            <div className="relative pl-2">
              <div className="absolute left-[19px] top-4 bottom-8 w-0.5 bg-indigo-100" />

              <div className="space-y-10">
                {workflowSteps.map((step: any, index: number) => {
                  const stepDesc = language === 'zh-TW'
                    ? step.description_zh || step.description
                    : step.description;

                  return (
                    <div key={index} className="relative flex gap-6 group">
                      <div className="flex-shrink-0 relative z-10">
                        <div className="w-10 h-10 rounded-full bg-white border-2 border-indigo-100 group-hover:border-indigo-500 group-hover:scale-110 transition-all duration-300 flex items-center justify-center shadow-sm">
                          <span className="text-sm font-bold text-indigo-600">
                            {index + 1}
                          </span>
                        </div>
                      </div>

                      <div className="flex-1 -mt-1">
                        <div className="bg-white p-5 rounded-xl border border-gray-200 shadow-sm hover:shadow-md transition-shadow">
                          {step.title && (
                            <h4 className="text-base font-bold text-gray-900 mb-2">
                              {step.title}
                            </h4>
                          )}
                          <p className="text-gray-600 leading-relaxed text-sm md:text-base">
                            {stepDesc}
                          </p>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          </div>
        )}

        {useCase.tools && useCase.tools.length > 0 && (
          <div className="mt-8">
            <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
              <Sparkles className="w-5 h-5 text-purple-600" />
              {t('creative_use_cases.tools_used_header')}
            </h3>

            {loadingTools ? (
              <div className="flex gap-4 animate-pulse">
                {[1, 2, 3].map(i => <div key={i} className="h-20 w-full bg-gray-100 rounded-xl" />)}
              </div>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                {useCase.tools.map((toolSlug: string) => {
                  const tool = relatedTools.find(t =>
                    t.tool_name.toLowerCase().includes(toolSlug.toLowerCase()) ||
                    (t as any).source_slug === toolSlug
                  );

                  return (
                    <div
                      key={toolSlug}
                      className="flex items-center gap-3 p-3 bg-white border border-gray-200 rounded-xl hover:border-purple-300 hover:shadow-sm transition-all"
                    >
                      <div className="w-10 h-10 rounded-lg bg-gray-50 flex items-center justify-center text-gray-400">
                        <Box size={20} />
                      </div>
                      <div className="min-w-0">
                        <p className="font-semibold text-gray-900 text-sm truncate">
                          {tool?.tool_name || toolSlug}
                        </p>
                        <p className="text-xs text-gray-500 truncate">
                          {tool?.categories?.functional_role?.[0] || 'AI Tool'}
                        </p>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        )}

        {onApplyStack && useCase.tools && useCase.tools.length > 0 && (
          <div className="mt-8 pt-6 border-t border-gray-100">
            <Button
              onClick={handleApplyStack}
              icon={ArrowRight}
              className="w-full bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700 text-white shadow-lg shadow-indigo-200 py-6 text-lg"
            >
              {t('creative_use_cases.apply_tool_stack')}
            </Button>
            <p className="text-center text-xs text-gray-400 mt-3">
              {language === 'zh-TW' ? '點擊背景空白處即可關閉視窗' : 'Click outside to close'}
            </p>
          </div>
        )}
      </div>
    </Modal>
  );
}
