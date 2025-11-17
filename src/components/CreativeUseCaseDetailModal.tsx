import { useState, useEffect } from 'react';
import { X, Lightbulb, Clock, Target, Sparkles, CheckCircle, ArrowRight } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Badge } from './ui/Badge';
import { Button } from './ui/Button';
import { ComplexityBadge } from './ComplexityBadge';
import { db } from '../lib/database';
import type { Tool } from '../types';

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
            <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-purple-500 to-blue-500 flex items-center justify-center flex-shrink-0">
              <Lightbulb className="w-8 h-8 text-white" />
            </div>

            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 mb-2 flex-wrap">
                <h1 className="text-3xl font-bold text-gray-900">{title}</h1>
                <ComplexityBadge level={useCase.difficulty} language={language} />
              </div>
              <p className="text-lg text-gray-600 mb-4">{description}</p>

              <div className="flex flex-wrap gap-2 mb-4">
                {useCase.use_case_tags && useCase.use_case_tags.length > 0 && (
                  <>
                    {useCase.use_case_tags.slice(0, 5).map((tag: string) => (
                      <Badge key={tag} className="bg-purple-50 text-purple-700 border-purple-200">
                        {tag}
                      </Badge>
                    ))}
                  </>
                )}
              </div>

              <div className="flex items-center gap-4 text-sm text-gray-600">
                {useCase.estimated_time && (
                  <div className="flex items-center gap-1">
                    <Clock className="w-4 h-4" />
                    <span>{useCase.estimated_time}</span>
                  </div>
                )}
                {useCase.export_format && useCase.export_format.length > 0 && (
                  <div className="flex items-center gap-1">
                    <Target className="w-4 h-4" />
                    <span>{useCase.export_format.join(', ')}</span>
                  </div>
                )}
              </div>
            </div>
          </div>

          <div className="space-y-6">
            {workflowSteps && workflowSteps.length > 0 && (
              <div>
                <h3 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
                  <CheckCircle className="w-5 h-5 text-blue-600" />
                  {language === 'zh-TW' ? '實作步驟' : 'Implementation Steps'}
                </h3>
                <div className="space-y-3">
                  {workflowSteps.map((step: any, index: number) => {
                    const stepDesc = language === 'zh-TW'
                      ? step.description_zh || step.description
                      : step.description;

                    return (
                      <div key={index} className="flex gap-3 p-4 bg-gray-50 rounded-lg border border-gray-200">
                        <div className="flex-shrink-0">
                          <div className="w-8 h-8 rounded-full bg-blue-600 text-white flex items-center justify-center font-bold text-sm">
                            {step.step || index + 1}
                          </div>
                        </div>
                        <div className="flex-1">
                          <p className="text-gray-900 font-medium mb-1">
                            {language === 'zh-TW' ? `步驟 ${step.step || index + 1}` : `Step ${step.step || index + 1}`}
                          </p>
                          <p className="text-gray-700">{stepDesc}</p>
                        </div>
                        {index < workflowSteps.length - 1 && (
                          <ArrowRight className="w-5 h-5 text-gray-400 self-center" />
                        )}
                      </div>
                    );
                  })}
                </div>
              </div>
            )}

            {useCase.tools && useCase.tools.length > 0 && (
              <div>
                <h3 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
                  <Sparkles className="w-5 h-5 text-purple-600" />
                  {language === 'zh-TW' ? '使用的工具' : 'Tools Used'}
                </h3>
                {loadingTools ? (
                  <div className="text-center py-4">
                    <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-purple-600 mx-auto"></div>
                  </div>
                ) : (
                  <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
                    {useCase.tools.map((toolSlug: string) => {
                      const tool = relatedTools.find(t =>
                        t.tool_name.toLowerCase().includes(toolSlug.toLowerCase()) ||
                        (t as any).source_slug === toolSlug
                      );

                      return (
                        <div
                          key={toolSlug}
                          className="p-3 bg-white border border-gray-200 rounded-lg hover:border-purple-300 hover:shadow-sm transition-all"
                        >
                          <p className="font-medium text-gray-900 text-sm">
                            {tool?.tool_name || toolSlug}
                          </p>
                          {tool && (
                            <p className="text-xs text-gray-500 mt-1 line-clamp-2">
                              {tool.summary}
                            </p>
                          )}
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            )}

            {useCase.export_format && useCase.export_format.length > 0 && (
              <div>
                <h3 className="text-lg font-semibold text-gray-900 mb-3">
                  {language === 'zh-TW' ? '支援的匯出格式' : 'Supported Export Formats'}
                </h3>
                <div className="flex flex-wrap gap-2">
                  {useCase.export_format.map((format: string) => (
                    <Badge key={format} size="sm" color="#10B981">
                      {format}
                    </Badge>
                  ))}
                </div>
              </div>
            )}
          </div>

          <div className="mt-8 pt-6 border-t border-gray-200 flex gap-3">
            <Button onClick={onClose} variant="outline" className="flex-1">
              {language === 'zh-TW' ? '關閉' : 'Close'}
            </Button>
            {onApplyStack && useCase.tools && useCase.tools.length > 0 && (
              <Button onClick={handleApplyStack} icon={Sparkles} className="flex-1">
                {language === 'zh-TW' ? '套用工具堆疊' : 'Apply Tool Stack'}
              </Button>
            )}
          </div>
        </div>
      </div>
    </Modal>
  );
}
