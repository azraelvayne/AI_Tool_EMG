import { useState, useEffect } from 'react';
import { 
  X, Lightbulb, Clock, Target, Sparkles, 
  ArrowRight, Layers, Tag, Box, PlayCircle 
} from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Badge } from './ui/Badge';
import { Button } from './ui/Button';
import { ComplexityBadge } from './ComplexityBadge';
import { db } from '../lib/database';
import type { Tool } from '../types';

// 標籤字典：解決紅色英文看不懂的問題
const TAG_DICTIONARY: Record<string, { label: string; type: 'tech' | 'category' | 'platform' }> = {
  'automation': { label: '自動化', type: 'category' },
  'marketing': { label: '行銷', type: 'category' },
  'sales': { label: '銷售', type: 'category' },
  'analytics': { label: '數據分析', type: 'tech' },
  'content-creation': { label: '內容創作', type: 'category' },
  'n8n': { label: 'n8n 流程', type: 'platform' },
  'zapier': { label: 'Zapier', type: 'platform' },
  'openai': { label: 'OpenAI API', type: 'tech' },
  'webhook': { label: 'Webhook', type: 'tech' },
  'api': { label: 'API 整合', type: 'tech' },
  'database': { label: '資料庫', type: 'tech' },
  'crm': { label: 'CRM 客戶管理', type: 'category' },
  'seo': { label: 'SEO 優化', type: 'category' },
  'social-media': { label: '社群媒體', type: 'category' },
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
    const info = TAG_DICTIONARY[normalizedTag];
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
      badgeStyle = "bg-emerald-50 text-emerald-700 border-emerald-200";
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
      <div className="relative">
        {/* 右上角關閉按鈕 */}
        <button
          onClick={onClose}
          className="absolute -top-2 -right-2 p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 rounded-lg transition-colors z-10"
        >
          <X size={24} />
        </button>

        <div className="pr-4">
          {/* 標題與圖示 */}
          <div className="flex items-start gap-6 mb-8">
            <div className="w-20 h-20 rounded-2xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center flex-shrink-0 shadow-lg shadow-indigo-200">
              <Lightbulb className="w-10 h-10 text-white" />
            </div>

            <div className="flex-1 min-w-0 pt-1">
              <div className="flex items-center gap-3 mb-3 flex-wrap">
                <h1 className="text-3xl font-bold text-gray-900 leading-tight">{title}</h1>
                <ComplexityBadge level={useCase.difficulty} language={language} />
              </div>
              
              <div className="flex flex-wrap gap-2 mb-4">
                {useCase.use_case_tags?.map((tag: string) => renderTag(tag))}
              </div>

              <div className="flex items-center gap-6 text-sm text-gray-500 pt-2 border-t border-gray-100">
                {useCase.estimated_time && (
                  <div className="flex items-center gap-1.5">
                    <Clock className="w-4 h-4 text-indigo-500" />
                    <span className="font-medium text-gray-700">{useCase.estimated_time}</span>
                  </div>
                )}
              </div>
            </div>
          </div>

          <p className="text-lg text-gray-600 leading-relaxed mb-8 bg-gray-50 p-4 rounded-xl border border-gray-100">
            {description}
          </p>

          {/* 垂直時間軸設計 */}
          <div className="space-y-8 mb-10">
            <h3 className="text-xl font-bold text-gray-900 flex items-center gap-2">
              <PlayCircle className="w-6 h-6 text-indigo-600" />
              {t('creative_use_cases.implementation_steps')}
            </h3>
            
            <div className="relative pl-4">
              <div className="absolute left-[27px] top-4 bottom-4 w-0.5 bg-gray-200" />

              <div className="space-y-8">
                {workflowSteps.map((step: any, index: number) => {
                  const stepDesc = language === 'zh-TW'
                    ? step.description_zh || step.description
                    : step.description;

                  return (
                    <div key={index} className="relative flex gap-6 group">
                      <div className="flex-shrink-0 relative z-10">
                        <div className="w-14 h-14 rounded-full bg-white border-2 border-indigo-100 group-hover:border-indigo-500 group-hover:scale-110 transition-all duration-300 flex items-center justify-center shadow-sm">
                          <span className="text-xl font-bold text-indigo-600">
                            {index + 1}
                          </span>
                        </div>
                      </div>
                      <div className="flex-1 pt-2">
                        <div className="bg-white p-5 rounded-xl border border-gray-200 shadow-sm hover:shadow-md hover:border-indigo-200 transition-all">
                          {step.title && (
                            <h4 className="text-lg font-bold text-gray-900 mb-2">
                              {step.title}
                            </h4>
                          )}
                          <p className="text-gray-600 leading-relaxed">
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

          {/* 工具列表 */}
          {useCase.tools && useCase.tools.length > 0 && (
            <div className="mb-8">
              <h3 className="text-xl font-bold text-gray-900 mb-6 flex items-center gap-2">
                <Sparkles className="w-5 h-5 text-purple-600" />
                {t('creative_use_cases.tools_used_header')}
              </h3>
              
              {loadingTools ? (
                <div className="flex gap-4 animate-pulse">
                  <div className="h-24 w-full bg-gray-100 rounded-xl" />
                </div>
              ) : (
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                  {useCase.tools.map((toolSlug: string) => {
                    const tool = relatedTools.find(t =>
                      t.tool_name.toLowerCase().includes(toolSlug.toLowerCase()) ||
                      (t as any).source_slug === toolSlug
                    );
                    return (
                      <div key={toolSlug} className="flex items-start gap-3 p-4 bg-white border border-gray-200 rounded-xl">
                        <div className="w-10 h-10 rounded-lg bg-purple-50 flex items-center justify-center text-purple-500">
                          <Box size={20} />
                        </div>
                        <div>
                          <p className="font-bold text-gray-900 text-sm truncate">{tool?.tool_name || toolSlug}</p>
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          )}

          {/* 底部按鈕 */}
          {onApplyStack && useCase.tools && useCase.tools.length > 0 && (
            <div className="mt-10 pt-6 border-t border-gray-100">
              <Button 
                onClick={handleApplyStack} 
                icon={ArrowRight} 
                className="w-full bg-gradient-to-r from-indigo-600 to-purple-600 text-white shadow-lg py-4 text-lg rounded-xl"
              >
                {t('creative_use_cases.apply_tool_stack')}
              </Button>
              <p className="text-center text-xs text-gray-400 mt-3">
                點擊背景空白處即可關閉視窗
              </p>
            </div>
          )}
        </div>
      </div>
    </Modal>
  );
}