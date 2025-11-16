import { useState } from 'react';
import { Sparkles, Send, Loader2, Layers } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Button } from './ui/Button';
import { Input } from './ui/Input';
import { Badge } from './ui/Badge';
import { aiRecommendation } from '../lib/ai-recommendation';
import type { Tool } from '../types';

interface AIRecommendationModalProps {
  isOpen: boolean;
  onClose: () => void;
  allTools: Tool[];
  onApplyStack?: (tools: Tool[]) => void;
}

export function AIRecommendationModal({
  isOpen,
  onClose,
  allTools,
  onApplyStack,
}: AIRecommendationModalProps) {
  const { t, i18n } = useTranslation();
  const [query, setQuery] = useState('');
  const [userLevel, setUserLevel] = useState<'beginner' | 'intermediate' | 'advanced'>('beginner');
  const [loading, setLoading] = useState(false);
  const [recommendations, setRecommendations] = useState<any>(null);

  const language = i18n.language as 'en' | 'zh-TW';

  const handleGenerate = () => {
    if (!query.trim()) return;

    setLoading(true);
    setTimeout(() => {
      const result = aiRecommendation.generateRecommendations(query, allTools, {
        userLevel,
      });
      setRecommendations(result);
      setLoading(false);
    }, 1000);
  };

  const examples = [
    language === 'zh-TW' ? '我想建立自動化工作流程' : 'I want to build automation workflows',
    language === 'zh-TW' ? '我需要 AI 內容生成工具' : 'I need AI content generation tools',
    language === 'zh-TW' ? '我想分析和視覺化資料' : 'I want to analyze and visualize data',
    language === 'zh-TW' ? '我需要建立知識庫' : 'I need to build a knowledge base',
  ];

  return (
    <Modal isOpen={isOpen} onClose={onClose} title={language === 'zh-TW' ? 'AI 智慧推薦' : 'AI Smart Recommendations'} size="xl">
      <div className="space-y-6">
        <div className="bg-gradient-to-r from-purple-50 to-blue-50 border border-purple-200 rounded-lg p-4">
          <div className="flex items-start gap-3">
            <div className="w-10 h-10 bg-purple-500 rounded-lg flex items-center justify-center flex-shrink-0">
              <Sparkles className="w-5 h-5 text-white" />
            </div>
            <div className="flex-1">
              <h3 className="font-semibold text-gray-900 mb-1">
                {language === 'zh-TW' ? '描述您的需求' : 'Describe Your Needs'}
              </h3>
              <p className="text-sm text-gray-600">
                {language === 'zh-TW'
                  ? '告訴我們您想做什麼，我們將根據您的需求推薦最適合的工具組合。'
                  : 'Tell us what you want to do, and we\'ll recommend the best tool combinations for your needs.'}
              </p>
            </div>
          </div>
        </div>

        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-2">
            {language === 'zh-TW' ? '您的技能等級' : 'Your Skill Level'}
          </label>
          <div className="flex gap-2">
            {['beginner', 'intermediate', 'advanced'].map((level) => (
              <button
                key={level}
                onClick={() => setUserLevel(level as any)}
                className={`flex-1 py-2 px-4 rounded-lg border-2 transition-all ${
                  userLevel === level
                    ? 'border-purple-500 bg-purple-50 text-purple-700 font-medium'
                    : 'border-gray-200 hover:border-gray-300 text-gray-700'
                }`}
              >
                {language === 'zh-TW'
                  ? level === 'beginner'
                    ? '初學者'
                    : level === 'intermediate'
                    ? '中級'
                    : '進階'
                  : level.charAt(0).toUpperCase() + level.slice(1)}
              </button>
            ))}
          </div>
        </div>

        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-2">
            {language === 'zh-TW' ? '描述您想做的事' : 'Describe What You Want to Do'}
          </label>
          <div className="flex gap-2">
            <Input
              value={query}
              onChange={setQuery}
              placeholder={
                language === 'zh-TW' ? '例如：我想建立一個 AI 聊天機器人' : 'e.g., I want to build an AI chatbot'
              }
              onKeyPress={(e) => {
                if (e.key === 'Enter') {
                  handleGenerate();
                }
              }}
              className="flex-1"
            />
            <Button
              onClick={handleGenerate}
              variant="primary"
              icon={loading ? Loader2 : Send}
              disabled={!query.trim() || loading}
            >
              {loading
                ? (language === 'zh-TW' ? '生成中...' : 'Generating...')
                : (language === 'zh-TW' ? '生成推薦' : 'Generate')}
            </Button>
          </div>

          <div className="mt-3">
            <p className="text-xs text-gray-500 mb-2">
              {language === 'zh-TW' ? '試試這些範例：' : 'Try these examples:'}
            </p>
            <div className="flex flex-wrap gap-2">
              {examples.map((example) => (
                <button
                  key={example}
                  onClick={() => setQuery(example)}
                  className="text-xs px-3 py-1 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-full transition-colors"
                >
                  {example}
                </button>
              ))}
            </div>
          </div>
        </div>

        {recommendations && (
          <div className="space-y-4">
            <div className="flex items-center gap-2 pt-4 border-t border-gray-200">
              <Layers className="w-5 h-5 text-purple-600" />
              <h3 className="text-lg font-semibold text-gray-900">
                {language === 'zh-TW' ? '推薦的工具堆疊' : 'Recommended Tool Stacks'}
              </h3>
            </div>

            {recommendations.stacks.map((stack: any, index: number) => (
              <div
                key={index}
                className="border-2 border-gray-200 rounded-lg p-4 hover:border-purple-300 transition-colors"
              >
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <h4 className="font-semibold text-gray-900 mb-1">{stack.name}</h4>
                    <p className="text-sm text-gray-600">{stack.strategy}</p>
                  </div>
                  {stack.score > 0 && (
                    <Badge color="#10B981">
                      {language === 'zh-TW' ? '匹配度' : 'Match'}: {Math.round(stack.score)}/10
                    </Badge>
                  )}
                </div>

                <div className="flex flex-wrap gap-2 mb-3">
                  {stack.tools.map((tool: Tool) => (
                    <div
                      key={tool.id}
                      className="flex items-center gap-2 px-3 py-1.5 bg-gray-50 rounded-lg border border-gray-200"
                    >
                      <span className="text-sm font-medium text-gray-900">{tool.tool_name}</span>
                    </div>
                  ))}
                </div>

                {onApplyStack && (
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => onApplyStack(stack.tools)}
                    className="w-full"
                  >
                    {language === 'zh-TW' ? '套用此堆疊' : 'Apply This Stack'}
                  </Button>
                )}
              </div>
            ))}

            <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
              <p className="text-sm text-blue-800">
                <strong>{language === 'zh-TW' ? '提示：' : 'Tip:'}</strong>{' '}
                {language === 'zh-TW'
                  ? '這些推薦基於規則式演算法生成。在 v1.2 版本中，我們將整合 LLM 以提供更智慧的推薦。'
                  : 'These recommendations are generated using rule-based algorithms. In v1.2, we will integrate LLM for smarter recommendations.'}
              </p>
            </div>
          </div>
        )}
      </div>
    </Modal>
  );
}
