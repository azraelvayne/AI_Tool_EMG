import { useState, useEffect } from 'react';
import { ArrowLeft, Clock, BookOpen, Wrench, Lightbulb, Users, Star, ExternalLink, Heart } from 'lucide-react';
import { motion } from 'framer-motion';
import { db } from '../lib/database';
import type { GoalWithDetails, ToolStack, Inspiration, Persona } from '../types';
import { ComplexityBadge } from '../components/ComplexityBadge';
import { Button } from '../components/ui/Button';
import { Badge } from '../components/ui/Badge';
import { Card } from '../components/ui/Card';
import { PageTransition } from '../components/animations/PageTransition';
import { SkeletonHeader, SkeletonSection } from '../components/animations/SkeletonBlock';
import { Breadcrumb } from '../components/navigation/Breadcrumb';
import { useFavorites } from '../hooks/useFavorites';

interface GoalDetailPageProps {
  language: 'en' | 'zh-TW';
  goalKey: string;
  onBackToHome: () => void;
  onBackToPersona?: () => void;
  onInspirationSelect?: (inspirationKey: string) => void;
  onPersonaSelect?: (personaKey: string) => void;
  selectedPersonaName?: string;
}

export function GoalDetailPage({
  language,
  goalKey,
  onBackToHome,
  onBackToPersona,
  onInspirationSelect,
  onPersonaSelect,
  selectedPersonaName
}: GoalDetailPageProps) {
  const [goal, setGoal] = useState<GoalWithDetails | null>(null);
  const [loading, setLoading] = useState(true);
  const [activeStackTab, setActiveStackTab] = useState(0);
  const { isGoalFavorite, toggleGoalFavorite } = useFavorites();

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        if (onBackToPersona) {
          onBackToPersona();
        } else {
          onBackToHome();
        }
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [onBackToHome, onBackToPersona]);

  useEffect(() => {
    const loadGoalData = async () => {
      try {
        setLoading(true);
        const goalData = await db.getGoalByKey(goalKey, language);
        if (goalData) {
          const goalWithDetails = await db.getGoalWithDetails(goalData.id, language);
          setGoal(goalWithDetails);
        }
      } catch (error) {
        console.error('Error loading goal:', error);
      } finally {
        setLoading(false);
      }
    };

    loadGoalData();
  }, [goalKey, language]);

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-white">
        <SkeletonHeader />
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-12">
          <SkeletonSection cardCount={3} />
          <SkeletonSection cardCount={2} />
        </div>
      </div>
    );
  }

  if (!goal) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-50 to-white">
        <div className="text-center">
          <p className="text-gray-600">{language === 'zh-TW' ? '找不到此目標' : 'Goal not found'}</p>
          <Button onClick={onBackToHome} className="mt-4">
            {language === 'zh-TW' ? '返回首頁' : 'Back to Home'}
          </Button>
        </div>
      </div>
    );
  }

  const title = language === 'zh-TW' ? goal.title_zh_tw : goal.title_en;
  const description = language === 'zh-TW' ? goal.description_zh_tw : goal.description_en;
  const outcome = language === 'zh-TW' ? goal.outcome_zh_tw : goal.outcome_en;

  return (
    <PageTransition className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      <div className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              {
                label: language === 'zh-TW' ? '首頁' : 'Home',
                onClick: onBackToHome
              },
              ...(selectedPersonaName ? [{
                label: selectedPersonaName,
                onClick: onBackToPersona
              }] : []),
              {
                label: language === 'zh-TW' ? goal?.title_zh_tw || '目標' : goal?.title_en || 'Goal',
                isCurrentPage: true
              }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="flex items-start justify-between">
            <div className="flex-1">
              <h1 className="text-4xl font-bold mb-4">{title}</h1>
              <p className="text-xl text-blue-100 mb-6 max-w-3xl leading-relaxed">{description}</p>
              <div className="flex flex-wrap items-center gap-3">
                <ComplexityBadge
                  level={goal.difficulty}
                  language={language}
                  showHint={true}
                  className="bg-white/10 backdrop-blur-sm"
                />
                <div className="flex items-center gap-2 text-blue-100">
                  <Clock className="w-5 h-5" />
                  <span>{language === 'zh-TW' ? '預估時間會因個人經驗而異' : 'Time varies by experience'}</span>
                </div>
              </div>
            </div>
            <motion.button
              onClick={() => toggleGoalFavorite(goalKey)}
              className="p-3 bg-white/10 backdrop-blur-sm rounded-xl hover:bg-white/20 transition-all duration-300"
              title={isGoalFavorite(goalKey)
                ? (language === 'zh-TW' ? '取消收藏' : 'Remove from favorites')
                : (language === 'zh-TW' ? '加入收藏' : 'Add to favorites')
              }
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.9 }}
            >
              <motion.div
                key={isGoalFavorite(goalKey) ? 'favorited' : 'not-favorited'}
                initial={{ scale: 1 }}
                animate={isGoalFavorite(goalKey) ? {
                  scale: [1, 1.3, 1],
                  rotate: [0, -10, 10, 0]
                } : {}}
                transition={{ duration: 0.5 }}
              >
                <Heart
                  className={`w-6 h-6 transition-all duration-300 ${
                    isGoalFavorite(goalKey) ? 'fill-pink-300 text-pink-300' : 'text-white'
                  }`}
                />
              </motion.div>
            </motion.button>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-12">
        <div className="bg-blue-50 border border-blue-200 rounded-xl p-6">
          <div className="flex items-start gap-3">
            <Lightbulb className="w-6 h-6 text-blue-600 mt-1 flex-shrink-0" />
            <div>
              <h3 className="font-semibold text-blue-900 mb-1">
                {language === 'zh-TW' ? '複雜度說明' : 'About Complexity Levels'}
              </h3>
              <p className="text-blue-800 text-sm leading-relaxed">
                {language === 'zh-TW'
                  ? '複雜度層級描述專案的結構，而非您的能力。根據您想學習和探索的內容來選擇，而不是您認為「應該」知道的內容。'
                  : 'Complexity levels describe the structure of the project, not your ability. Choose based on what you want to learn and explore, not what you think you "should" know.'}
              </p>
            </div>
          </div>
        </div>

        {goal.learning_focus && goal.learning_focus.length > 0 && (
          <section>
            <div className="flex items-center gap-3 mb-6">
              <BookOpen className="w-7 h-7 text-indigo-600" />
              <h2 className="text-2xl font-bold text-gray-900">
                {language === 'zh-TW' ? '學習重點' : 'Learning Focus'}
              </h2>
            </div>
            <Card className="p-6">
              <div className="space-y-4">
                <div>
                  <h3 className="font-semibold text-gray-900 mb-3">
                    {language === 'zh-TW' ? '你將會探索' : "You'll Explore"}
                  </h3>
                  <div className="flex flex-wrap gap-2">
                    {goal.learning_focus.map((focus, index) => (
                      <Badge key={index} className="bg-indigo-50 text-indigo-700 border-indigo-200">
                        {focus}
                      </Badge>
                    ))}
                  </div>
                </div>
                {goal.expected_skills && goal.expected_skills.length > 0 && (
                  <div>
                    <h3 className="font-semibold text-gray-900 mb-3">
                      {language === 'zh-TW' ? '預期技能' : 'Expected Skills'}
                    </h3>
                    <div className="flex flex-wrap gap-2">
                      {goal.expected_skills.map((skill, index) => (
                        <Badge key={index} className="bg-blue-50 text-blue-700 border-blue-200">
                          {skill}
                        </Badge>
                      ))}
                    </div>
                  </div>
                )}
                {outcome && (
                  <div className="pt-3 border-t border-gray-200">
                    <h3 className="font-semibold text-gray-900 mb-2">
                      {language === 'zh-TW' ? '完成後你將能夠' : 'After Completion'}
                    </h3>
                    <p className="text-gray-700">{outcome}</p>
                  </div>
                )}
              </div>
            </Card>
          </section>
        )}

        {goal.stacks && goal.stacks.length > 0 && (
          <section>
            <div className="flex items-center gap-3 mb-6">
              <Wrench className="w-7 h-7 text-blue-600" />
              <h2 className="text-2xl font-bold text-gray-900">
                {language === 'zh-TW' ? '可用的實作方式' : 'Implementation Approaches'}
              </h2>
            </div>
            <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
              <div className="border-b border-gray-200 bg-gray-50">
                <div className="flex overflow-x-auto">
                  {goal.stacks.map((stack: ToolStack, index: number) => (
                    <button
                      key={stack.id}
                      onClick={() => setActiveStackTab(index)}
                      className={`px-6 py-4 text-sm font-medium whitespace-nowrap transition-colors border-b-2 ${
                        activeStackTab === index
                          ? 'border-blue-600 text-blue-600 bg-white'
                          : 'border-transparent text-gray-600 hover:text-gray-900'
                      }`}
                    >
                      {language === 'zh-TW' ? stack.name_zh_tw : stack.name_en}
                    </button>
                  ))}
                </div>
              </div>

              {goal.stacks[activeStackTab] && (
                <div className="p-6">
                  <StackDetail stack={goal.stacks[activeStackTab]} language={language} />
                </div>
              )}
            </div>

            <div className="mt-4 bg-amber-50 border border-amber-200 rounded-lg p-4">
              <p className="text-sm text-amber-800">
                <strong>{language === 'zh-TW' ? '即將推出：' : 'Coming soon:'}</strong>
                {' '}
                {language === 'zh-TW'
                  ? '並排比較不同實作方式的功能'
                  : 'Side-by-side comparison of different approaches'}
              </p>
            </div>
          </section>
        )}

        {goal.inspirations && goal.inspirations.length > 0 && (
          <section>
            <div className="flex items-center gap-3 mb-6">
              <Star className="w-7 h-7 text-yellow-600" />
              <h2 className="text-2xl font-bold text-gray-900">
                {language === 'zh-TW' ? '實際案例' : 'Real Examples'}
              </h2>
            </div>
            <motion.div
              className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
              initial="hidden"
              animate="visible"
              variants={{
                visible: {
                  transition: {
                    staggerChildren: 0.1
                  }
                }
              }}
            >
              {goal.inspirations.map((inspiration: Inspiration) => (
                <motion.div
                  key={inspiration.id}
                  variants={{
                    hidden: { opacity: 0, y: 20 },
                    visible: { opacity: 1, y: 0 }
                  }}
                >
                  <Card
                    onClick={() => onInspirationSelect?.(inspiration.inspiration_key)}
                    className="overflow-hidden hover:shadow-xl transition-all duration-300 cursor-pointer group h-full"
                  >
                  {inspiration.visual_hint && (
                    <div className="h-48 bg-gradient-to-br from-blue-100 to-indigo-100 flex items-center justify-center">
                      <span className="text-6xl">{inspiration.visual_hint}</span>
                    </div>
                  )}
                  <div className="p-5">
                    <h3 className="text-lg font-semibold text-gray-900 mb-2 group-hover:text-blue-600 transition-colors">
                      {language === 'zh-TW' ? inspiration.title_zh_tw : inspiration.title_en}
                    </h3>
                    <p className="text-gray-600 text-sm mb-3 line-clamp-2">
                      {language === 'zh-TW' ? inspiration.description_zh_tw : inspiration.description_en}
                    </p>
                    <div className="flex items-center justify-between">
                      <ComplexityBadge level={inspiration.difficulty} language={language} />
                      <span className="text-sm text-gray-500 flex items-center gap-1">
                        <Clock className="w-4 h-4" />
                        {inspiration.estimated_time}
                      </span>
                    </div>
                  </div>
                  </Card>
                </motion.div>
              ))}
            </motion.div>
          </section>
        )}

        {goal.personas && goal.personas.length > 0 && (
          <section>
            <div className="flex items-center gap-3 mb-6">
              <Users className="w-7 h-7 text-purple-600" />
              <h2 className="text-2xl font-bold text-gray-900">
                {language === 'zh-TW' ? '誰會探索這個？' : 'Who Explores This?'}
              </h2>
            </div>
            <div className="bg-purple-50 border border-purple-200 rounded-xl p-6 mb-4">
              <p className="text-sm text-purple-800 flex items-start gap-2">
                <Lightbulb className="w-5 h-5 flex-shrink-0 mt-0.5" />
                <span>
                  {language === 'zh-TW'
                    ? '這些角色代表不同的學習起點 — 你可以從任何一個開始探索，或是定義自己的組合方式。'
                    : 'These personas represent different learning entry points — you can explore from any perspective or define your own combination.'}
                </span>
              </p>
            </div>
            <div className="flex flex-wrap gap-4">
              {goal.personas.map((persona: Persona) => (
                <button
                  key={persona.id}
                  onClick={() => onPersonaSelect?.(persona.persona_key)}
                  className="flex items-center gap-3 px-5 py-3 bg-white border border-gray-200 rounded-xl hover:shadow-md hover:border-purple-300 transition-all group"
                >
                  <span className="text-2xl">{persona.icon}</span>
                  <span className="font-medium text-gray-900 group-hover:text-purple-600 transition-colors">
                    {language === 'zh-TW' ? persona.name_zh_tw : persona.name_en}
                  </span>
                </button>
              ))}
            </div>
          </section>
        )}

        <section>
          <div className="flex items-center gap-3 mb-6">
            <ExternalLink className="w-7 h-7 text-green-600" />
            <h2 className="text-2xl font-bold text-gray-900">
              {language === 'zh-TW' ? '延伸學習資源' : 'Further Exploration'}
            </h2>
          </div>
          <Card className="p-6">
            <p className="text-gray-600 mb-4">
              {language === 'zh-TW'
                ? '以下是一些推薦的外部資源，幫助你深入了解相關概念：'
                : 'Here are some recommended external resources to deepen your understanding:'}
            </p>
            <div className="space-y-3">
              <ExternalResourceLink
                name="DeepLearning.AI"
                url="https://www.deeplearning.ai/"
                description={language === 'zh-TW' ? 'AI 和深度學習課程' : 'AI and deep learning courses'}
              />
              <ExternalResourceLink
                name="AIlogora"
                url="https://www.ailogora.com/"
                description={language === 'zh-TW' ? 'AI 工具評測與教學' : 'AI tool reviews and tutorials'}
              />
              <ExternalResourceLink
                name="Hugging Face"
                url="https://huggingface.co/learn"
                description={language === 'zh-TW' ? '機器學習資源與模型' : 'Machine learning resources and models'}
              />
            </div>
          </Card>
        </section>
      </div>
    </PageTransition>
  );
}

function StackDetail({ stack, language }: { stack: ToolStack; language: 'en' | 'zh-TW' }) {
  const name = language === 'zh-TW' ? stack.name_zh_tw : stack.name_en;
  const description = language === 'zh-TW' ? stack.description_zh_tw : stack.description_en;

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-xl font-semibold text-gray-900 mb-2">{name}</h3>
        <p className="text-gray-700">{description}</p>
      </div>

      <div className="grid md:grid-cols-3 gap-4">
        <div className="bg-gray-50 rounded-lg p-4">
          <h4 className="text-sm font-semibold text-gray-700 mb-2">
            {language === 'zh-TW' ? '複雜度' : 'Complexity'}
          </h4>
          <ComplexityBadge level={stack.difficulty} language={language} />
        </div>
        <div className="bg-gray-50 rounded-lg p-4">
          <h4 className="text-sm font-semibold text-gray-700 mb-2">
            {language === 'zh-TW' ? '設置複雜度' : 'Setup Complexity'}
          </h4>
          <Badge className={
            stack.setup_complexity === 'low' ? 'bg-green-100 text-green-800' :
            stack.setup_complexity === 'medium' ? 'bg-yellow-100 text-yellow-800' :
            'bg-red-100 text-red-800'
          }>
            {stack.setup_complexity === 'low' ? (language === 'zh-TW' ? '低' : 'Low') :
             stack.setup_complexity === 'medium' ? (language === 'zh-TW' ? '中' : 'Medium') :
             (language === 'zh-TW' ? '高' : 'High')}
          </Badge>
        </div>
        <div className="bg-gray-50 rounded-lg p-4">
          <h4 className="text-sm font-semibold text-gray-700 mb-2">
            {language === 'zh-TW' ? '預估時間' : 'Estimated Time'}
          </h4>
          <div className="flex items-center gap-2 text-gray-900">
            <Clock className="w-4 h-4" />
            <span className="font-medium">{stack.estimated_time}</span>
          </div>
        </div>
      </div>

      {stack.flow_map && (
        <div>
          <h4 className="text-sm font-semibold text-gray-700 mb-3">
            {language === 'zh-TW' ? '工作流程' : 'Workflow'}
          </h4>
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <p className="text-blue-900 font-mono text-sm">{stack.flow_map}</p>
          </div>
        </div>
      )}

      {stack.integration_method && (
        <div>
          <h4 className="text-sm font-semibold text-gray-700 mb-2">
            {language === 'zh-TW' ? '整合方式' : 'Integration Method'}
          </h4>
          <p className="text-gray-700">{stack.integration_method}</p>
        </div>
      )}
    </div>
  );
}

function ExternalResourceLink({ name, url, description }: { name: string; url: string; description: string }) {
  return (
    <a
      href={url}
      target="_blank"
      rel="noopener noreferrer"
      className="flex items-center justify-between p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors group"
    >
      <div className="flex-1">
        <h4 className="font-semibold text-gray-900 group-hover:text-green-600 transition-colors">{name}</h4>
        <p className="text-sm text-gray-600">{description}</p>
      </div>
      <ExternalLink className="w-5 h-5 text-gray-400 group-hover:text-green-600 transition-colors" />
    </a>
  );
}
