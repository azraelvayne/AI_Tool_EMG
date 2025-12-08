import { useState, useEffect } from 'react';
import { ArrowLeft, Clock, Award, Target, ExternalLink, Lightbulb, CheckCircle2, Wrench, Heart } from 'lucide-react';
import { motion } from 'framer-motion';
import { db } from '../lib/database';
import type { InspirationWithDetails, Tool } from '../types';
import { Button } from '../components/ui/Button';
import { Badge } from '../components/ui/Badge';
import { ComplexityBadge } from '../components/ComplexityBadge';
import { ToolCard } from '../components/ToolCard';
import { PageTransition } from '../components/animations/PageTransition';
import { SkeletonHeader, SkeletonSection } from '../components/animations/SkeletonBlock';
import { Breadcrumb } from '../components/navigation/Breadcrumb';
import { useFavorites } from '../hooks/useFavorites';

interface InspirationDetailPageProps {
  language: 'en' | 'zh-TW';
  inspirationKey: string;
  onBackToHome: () => void;
  onBackToBrowse?: () => void;
}

export function InspirationDetailPage({ language, inspirationKey, onBackToHome, onBackToBrowse }: InspirationDetailPageProps) {
  const [inspiration, setInspiration] = useState<InspirationWithDetails | null>(null);
  const [loading, setLoading] = useState(true);
  const { isInspirationFavorite, toggleInspirationFavorite } = useFavorites();

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        if (onBackToBrowse) {
          onBackToBrowse();
        } else {
          onBackToHome();
        }
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [onBackToHome, onBackToBrowse]);

  useEffect(() => {
    const loadInspirationData = async () => {
      try {
        setLoading(true);
        const inspirationData = await db.getInspirationByKey(inspirationKey, language);
        if (inspirationData) {
          const inspirationWithDetails = await db.getInspirationWithDetails(inspirationData.id, language);
          setInspiration(inspirationWithDetails);
        }
      } catch (error) {
        console.error('Error loading inspiration:', error);
      } finally {
        setLoading(false);
      }
    };

    loadInspirationData();
  }, [inspirationKey, language]);

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
        <SkeletonHeader />
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-10">
          <SkeletonSection cardCount={2} />
          <SkeletonSection cardCount={3} />
        </div>
      </div>
    );
  }

  if (!inspiration) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-indigo-50">
        <div className="text-center">
          <p className="text-gray-600">{language === 'zh-TW' ? '找不到此靈感案例' : 'Inspiration not found'}</p>
          <Button onClick={onBackToHome} className="mt-4">
            {language === 'zh-TW' ? '返回首頁' : 'Back to Home'}
          </Button>
        </div>
      </div>
    );
  }


  return (
    <PageTransition className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
      <div className="bg-gradient-to-r from-indigo-600 to-blue-600 text-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              {
                label: language === 'zh-TW' ? '首頁' : 'Home',
                onClick: onBackToHome
              },
              ...(onBackToBrowse ? [{
                label: language === 'zh-TW' ? '靈感瀏覽' : 'Browse Inspirations',
                onClick: onBackToBrowse
              }] : []),
              {
                label: language === 'zh-TW' ? inspiration?.title_zh_tw || '靈感案例' : inspiration?.title_en || 'Inspiration',
                isCurrentPage: true
              }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="flex items-start gap-4 mb-6">
            <div className="w-16 h-16 bg-white/10 backdrop-blur-sm rounded-2xl flex items-center justify-center">
              <Lightbulb className="w-8 h-8" />
            </div>
            <div className="flex-1">
              <h1 className="text-4xl font-bold mb-3">
                {language === 'zh-TW' ? inspiration.title_zh_tw : inspiration.title_en}
              </h1>
              <p className="text-xl text-blue-100">
                {language === 'zh-TW' ? inspiration.description_zh_tw : inspiration.description_en}
              </p>
            </div>
            <motion.button
              onClick={() => toggleInspirationFavorite(inspirationKey)}
              className="p-3 bg-white/10 backdrop-blur-sm rounded-xl hover:bg-white/20 transition-all duration-300"
              title={isInspirationFavorite(inspirationKey)
                ? (language === 'zh-TW' ? '取消收藏' : 'Remove from favorites')
                : (language === 'zh-TW' ? '加入收藏' : 'Add to favorites')
              }
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.9 }}
            >
              <motion.div
                key={isInspirationFavorite(inspirationKey) ? 'favorited' : 'not-favorited'}
                initial={{ scale: 1 }}
                animate={isInspirationFavorite(inspirationKey) ? {
                  scale: [1, 1.3, 1],
                  rotate: [0, -10, 10, 0]
                } : {}}
                transition={{ duration: 0.5 }}
              >
                <Heart
                  className={`w-6 h-6 transition-all duration-300 ${
                    isInspirationFavorite(inspirationKey) ? 'fill-pink-300 text-pink-300' : 'text-white'
                  }`}
                />
              </motion.div>
            </motion.button>
          </div>

          <div className="flex flex-wrap items-center gap-3">
            <ComplexityBadge
              level={inspiration.difficulty}
              language={language}
              showHint={true}
              className="bg-white/10 backdrop-blur-sm"
            />
            <Badge className="bg-white/20 text-white border-white/30">
              <Clock className="w-4 h-4 mr-1" />
              {inspiration.estimated_time}
            </Badge>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {((inspiration.learning_focus && inspiration.learning_focus.length > 0) ||
          (inspiration.expected_skills && inspiration.expected_skills.length > 0)) && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
            {inspiration.learning_focus && inspiration.learning_focus.length > 0 && (
              <div>
                <div className="flex items-center gap-3 mb-3">
                  <Target className="w-6 h-6 text-blue-600" />
                  <h2 className="text-xl font-bold text-gray-900">
                    {language === 'zh-TW' ? '你將學到' : 'What You Will Learn'}
                  </h2>
                </div>
                <div className="bg-white rounded-xl border border-gray-200 p-5 h-[calc(100%-3rem)]">
                  <div className="flex flex-wrap gap-2">
                    {(inspiration.learning_focus || []).map((focus, index) => (
                      <Badge key={index} className="bg-blue-50 text-blue-700 border-blue-200">
                        {focus}
                      </Badge>
                    ))}
                  </div>
                </div>
              </div>
            )}

            {inspiration.expected_skills && inspiration.expected_skills.length > 0 && (
              <div>
                <div className="flex items-center gap-3 mb-3">
                  <Wrench className="w-6 h-6 text-indigo-600" />
                  <h2 className="text-xl font-bold text-gray-900">
                    {language === 'zh-TW' ? '所需技能' : 'Required Skills'}
                  </h2>
                </div>
                <div className="bg-white rounded-xl border border-gray-200 p-5 h-[calc(100%-3rem)]">
                  <div className="flex flex-wrap gap-2">
                    {(inspiration.expected_skills || []).map((skill, index) => (
                      <Badge key={index} className="bg-indigo-50 text-indigo-700 border-indigo-200">
                        {skill}
                      </Badge>
                    ))}
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {inspiration.tools && inspiration.tools.length > 0 && (
          <div className="mb-6">
            <div className="flex items-center gap-3 mb-4">
              <Wrench className="w-6 h-6 text-purple-600" />
              <h2 className="text-2xl font-bold text-gray-900">
                {language === 'zh-TW' ? '使用工具' : 'Tools Used'}
              </h2>
            </div>
            <motion.div
              className="grid grid-cols-1 md:grid-cols-2 gap-6"
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
              {(inspiration.tools || []).map((tool: Tool) => (
                <motion.div
                  key={tool.id}
                  variants={{
                    hidden: { opacity: 0, y: 20 },
                    visible: { opacity: 1, y: 0 }
                  }}
                >
                  <ToolCard
                    tool={tool}
                    onClick={() => {}}
                  />
                </motion.div>
              ))}
            </motion.div>
          </div>
        )}

        {((inspiration.steps && inspiration.steps.length > 0) ||
          (inspiration.resource_links && inspiration.resource_links.length > 0)) && (
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
            {inspiration.steps && inspiration.steps.length > 0 && (
              <div>
                <div className="flex items-center gap-3 mb-3">
                  <CheckCircle2 className="w-6 h-6 text-green-600" />
                  <h2 className="text-xl font-bold text-gray-900">
                    {language === 'zh-TW' ? '實作步驟' : 'Implementation Steps'}
                  </h2>
                </div>
                <motion.div
                  className="space-y-2"
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
                  {(inspiration.steps || []).map((step, index) => (
                    <motion.div
                      key={index}
                      variants={{
                        hidden: { opacity: 0, x: -20 },
                        visible: { opacity: 1, x: 0 }
                      }}
                      className="bg-white rounded-xl border border-gray-200 p-4 hover:shadow-md transition-shadow"
                    >
                      <div className="flex gap-3">
                        <div className="flex-shrink-0 w-7 h-7 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-full flex items-center justify-center font-semibold text-sm">
                          {index + 1}
                        </div>
                        <p className="text-gray-700 flex-1 text-sm leading-relaxed pt-0.5">{step}</p>
                      </div>
                    </motion.div>
                  ))}
                </motion.div>
              </div>
            )}

            {inspiration.resource_links && inspiration.resource_links.length > 0 && (
              <div>
                <div className="flex items-center gap-3 mb-3">
                  <ExternalLink className="w-6 h-6 text-teal-600" />
                  <h2 className="text-xl font-bold text-gray-900">
                    {language === 'zh-TW' ? '學習資源' : 'Learning Resources'}
                  </h2>
                </div>
                <div className="bg-white rounded-xl border border-gray-200 p-5">
                  <div className="space-y-2">
                    {(inspiration.resource_links || []).map((resource, index) => (
                      <a
                        key={index}
                        href={resource.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="flex items-center gap-3 p-3 rounded-lg hover:bg-gray-50 transition-colors group"
                      >
                        <ExternalLink className="w-5 h-5 text-teal-600 flex-shrink-0" />
                        <span className="text-gray-900 group-hover:text-teal-600 transition-colors text-sm">
                          {resource.name}
                        </span>
                      </a>
                    ))}
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {inspiration.outcome_demo && (
          <div className="mb-6">
            <div className="bg-gradient-to-r from-green-50 to-teal-50 border border-green-200 rounded-xl p-6">
              <h3 className="font-semibold text-gray-900 mb-2 flex items-center gap-2">
                <CheckCircle2 className="w-5 h-5 text-green-600" />
                {language === 'zh-TW' ? '預期成果' : 'Expected Outcome'}
              </h3>
              <p className="text-gray-700">{inspiration.outcome_demo}</p>
            </div>
          </div>
        )}

        <div className="flex justify-center gap-4 pt-6 border-t border-gray-200">
          <Button onClick={onBackToBrowse || onBackToHome} variant="outline">
            {language === 'zh-TW' ? '返回瀏覽' : 'Back to Browse'}
          </Button>
          <Button onClick={onBackToHome}>
            {language === 'zh-TW' ? '返回首頁' : 'Back to Home'}
          </Button>
        </div>
      </div>
    </PageTransition>
  );
}
