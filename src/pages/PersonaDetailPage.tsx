import { useState, useEffect } from 'react';
import { ArrowLeft, Target, Sparkles, Award, BookOpen } from 'lucide-react';
import { motion } from 'framer-motion';
import { db } from '../lib/database';
import type { PersonaWithGoals, Goal } from '../types';
import { Button } from '../components/ui/Button';
import { Badge } from '../components/ui/Badge';
import { ComplexityBadge } from '../components/ComplexityBadge';
import { PageTransition } from '../components/animations/PageTransition';
import { SkeletonHeader, SkeletonSection } from '../components/animations/SkeletonBlock';
import { Breadcrumb } from '../components/navigation/Breadcrumb';

interface PersonaDetailPageProps {
  language: 'en' | 'zh-TW';
  personaKey: string;
  onBackToHome: () => void;
  onGoalSelect: (goalKey: string) => void;
}

export function PersonaDetailPage({ language, personaKey, onBackToHome, onGoalSelect }: PersonaDetailPageProps) {
  const [persona, setPersona] = useState<PersonaWithGoals | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onBackToHome();
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [onBackToHome]);

  useEffect(() => {
    const loadPersonaData = async () => {
      try {
        setLoading(true);
        const personaData = await db.getPersonaByKey(personaKey, language);
        if (personaData) {
          const personaWithGoals = await db.getPersonaWithGoals(personaData.id, language);
          setPersona(personaWithGoals);
        }
      } catch (error) {
        console.error('Error loading persona:', error);
      } finally {
        setLoading(false);
      }
    };

    loadPersonaData();
  }, [personaKey, language]);

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
        <SkeletonHeader />
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-12">
          <SkeletonSection cardCount={2} />
        </div>
      </div>
    );
  }

  if (!persona) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-indigo-50">
        <div className="text-center">
          <p className="text-gray-600">{language === 'zh-TW' ? '找不到此身份' : 'Persona not found'}</p>
          <Button onClick={onBackToHome} className="mt-4">
            {language === 'zh-TW' ? '返回首頁' : 'Back to Home'}
          </Button>
        </div>
      </div>
    );
  }

  const skillLevelLabels = {
    beginner: { en: 'Foundation', zh: '入門體驗' },
    intermediate: { en: 'Integrated', zh: '流程整合' },
    advanced: { en: 'Systemic', zh: '系統設計' }
  };

  return (
    <PageTransition className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
      <div className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              {
                label: language === 'zh-TW' ? '首頁' : 'Home',
                onClick: onBackToHome
              },
              {
                label: language === 'zh-TW' ? persona?.name_zh_tw || '角色' : persona?.name_en || 'Persona',
                isCurrentPage: true
              }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="flex items-start gap-6">
            <div className="w-20 h-20 bg-white/10 backdrop-blur-sm rounded-2xl flex items-center justify-center text-4xl">
              {persona.icon}
            </div>
            <div className="flex-1">
              <h1 className="text-4xl font-bold mb-3">
                {language === 'zh-TW' ? persona.name_zh_tw : persona.name_en}
              </h1>
              <p className="text-xl text-blue-100 mb-4">
                {language === 'zh-TW' ? persona.description_zh_tw : persona.description_en}
              </p>
              <div className="flex items-center gap-3">
                <Badge className="bg-white/20 text-white border-white/30">
                  <Award className="w-4 h-4 mr-1" />
                  {language === 'zh-TW'
                    ? skillLevelLabels[persona.skill_level].zh
                    : skillLevelLabels[persona.skill_level].en}
                </Badge>
              </div>
            </div>
          </div>

          <button
            onClick={onBackToHome}
            className="inline-flex items-center gap-2 text-white/90 hover:text-white mt-6 transition-colors"
          >
            <ArrowLeft className="w-5 h-5" />
            <span>{language === 'zh-TW' ? '返回首頁' : 'Back to Home'}</span>
          </button>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {persona.learning_focus && persona.learning_focus.length > 0 && (
          <div className="mb-12">
            <div className="flex items-center gap-3 mb-6">
              <BookOpen className="w-7 h-7 text-blue-600" />
              <h2 className="text-2xl font-bold text-gray-900">
                {language === 'zh-TW' ? '學習重點' : 'Learning Focus'}
              </h2>
            </div>
            <div className="bg-white rounded-xl border border-gray-200 p-6">
              <div className="flex flex-wrap gap-2">
                {persona.learning_focus.map((focus, index) => (
                  <Badge key={index} className="bg-blue-50 text-blue-700 border-blue-200">
                    {focus}
                  </Badge>
                ))}
              </div>
            </div>
          </div>
        )}

        <div>
          <div className="flex items-center gap-3 mb-6">
            <Target className="w-7 h-7 text-indigo-600" />
            <h2 className="text-2xl font-bold text-gray-900">
              {language === 'zh-TW' ? '推薦學習目標' : 'Recommended Learning Goals'}
            </h2>
          </div>

          {persona.goals && persona.goals.length > 0 ? (
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
              {persona.goals.map((goal: Goal, index: number) => (
                <motion.div
                  key={goal.id}
                  variants={{
                    hidden: { opacity: 0, y: 20 },
                    visible: { opacity: 1, y: 0 }
                  }}
                  onClick={() => onGoalSelect(goal.goal_key)}
                  className="bg-white rounded-xl border border-gray-200 p-6 hover:shadow-lg transition-all duration-300 cursor-pointer group"
                >
                  <div className="flex items-start justify-between mb-3">
                    <h3 className="text-xl font-semibold text-gray-900 group-hover:text-blue-600 transition-colors">
                      {language === 'zh-TW' ? goal.title_zh_tw : goal.title_en}
                    </h3>
                    <ComplexityBadge level={goal.difficulty} language={language} />
                  </div>
                  <p className="text-gray-600 mb-4 line-clamp-2">
                    {language === 'zh-TW' ? goal.description_zh_tw : goal.description_en}
                  </p>
                  <div className="flex items-center gap-2 text-sm text-indigo-600 font-medium group-hover:gap-3 transition-all">
                    <span>{language === 'zh-TW' ? '了解更多' : 'Learn More'}</span>
                    <Sparkles className="w-4 h-4" />
                  </div>
                </motion.div>
              ))}
            </motion.div>
          ) : (
            <div className="bg-white rounded-xl border border-gray-200 p-12 text-center">
              <Target className="w-16 h-16 text-gray-300 mx-auto mb-4" />
              <p className="text-gray-600">
                {language === 'zh-TW' ? '目前沒有推薦的學習目標' : 'No recommended goals available yet'}
              </p>
            </div>
          )}
        </div>
      </div>
    </PageTransition>
  );
}
