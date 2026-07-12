import { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Sparkles, ArrowRight, Lightbulb, Wrench, BookOpen, Users } from 'lucide-react';
import { db } from '../lib/database';
import type { Persona } from '../types';

interface PersonaHomePageProps {
  language: 'en' | 'zh-TW';
  onPersonaSelect: (personaKey: string, personaName?: string) => void;
  onInspirationSelect: (inspirationKey: string) => void;
  onBrowseAllInspirations: () => void;
  onNavigateToTools: (filters?: any) => void;
  onNavigateToUseCases: () => void;
  onNavigateToLearn: () => void;
}

const personaGradients: Record<string, string> = {
  'content-creator': 'from-pink-500 via-rose-500 to-orange-400',
  'developer': 'from-blue-600 via-indigo-500 to-cyan-500',
  'student': 'from-green-500 via-emerald-500 to-teal-400',
  'marketer': 'from-amber-500 via-orange-500 to-red-400',
  'entrepreneur': 'from-violet-600 via-purple-500 to-fuchsia-400',
  'educator': 'from-teal-600 via-cyan-500 to-blue-400',
  'researcher': 'from-slate-600 via-gray-500 to-zinc-400',
  'designer': 'from-rose-500 via-pink-500 to-purple-400',
};

const defaultGradient = 'from-blue-500 via-cyan-500 to-teal-400';

const fallbackPersonas: Persona[] = [
  {
    id: '1',
    persona_key: 'content-creator',
    name_en: 'Content Creator',
    name_zh_tw: '內容創作者',
    description_en: 'Bloggers, YouTubers, and social media creators who want to streamline content production.',
    description_zh_tw: '部落客、YouTuber 和社群媒體創作者，希望用 AI 加速內容產出。',
    skill_level: 'beginner',
    learning_focus: ['content-planning', 'visual-design', 'automation'],
    recommended_goals: ['create-blog-post', 'social-media-content'],
    icon_url: '',
    display_order: 1
  },
  {
    id: '2',
    persona_key: 'developer',
    name_en: 'Developer',
    name_zh_tw: '開發者',
    description_en: 'Engineers looking to integrate AI tools into their development workflow.',
    description_zh_tw: '希望將 AI 工具整合到開發流程中的工程師。',
    skill_level: 'intermediate',
    learning_focus: ['api-integration', 'workflow-automation', 'devops'],
    recommended_goals: ['build-ai-app', 'automate-workflow'],
    icon_url: '',
    display_order: 2
  },
  {
    id: '3',
    persona_key: 'student',
    name_en: 'Student / Learner',
    name_zh_tw: '學生 / 學習者',
    description_en: 'Students who want to learn faster and study more effectively with AI.',
    description_zh_tw: '希望利用 AI 更快學習、更有效率讀書的學生。',
    skill_level: 'beginner',
    learning_focus: ['study-aids', 'research', 'note-taking'],
    recommended_goals: ['smart-study', 'research-papers'],
    icon_url: '',
    display_order: 3
  },
  {
    id: '4',
    persona_key: 'marketer',
    name_en: 'Marketer',
    name_zh_tw: '行銷人員',
    description_en: 'Marketing professionals who want to leverage AI for campaigns and analytics.',
    description_zh_tw: '希望利用 AI 進行行銷活動和數據分析的行銷專業人員。',
    skill_level: 'intermediate',
    learning_focus: ['campaign-automation', 'content-generation', 'analytics'],
    recommended_goals: ['marketing-automation', 'content-strategy'],
    icon_url: '',
    display_order: 4
  },
  {
    id: '5',
    persona_key: 'entrepreneur',
    name_en: 'Entrepreneur',
    name_zh_tw: '創業者',
    description_en: 'Founders and solopreneurs building products with AI-powered tools.',
    description_zh_tw: '用 AI 工具打造產品的創業者和獨立開發者。',
    skill_level: 'intermediate',
    learning_focus: ['product-development', 'automation', 'growth'],
    recommended_goals: ['launch-mvp', 'automate-business'],
    icon_url: '',
    display_order: 5
  },
  {
    id: '6',
    persona_key: 'educator',
    name_en: 'Educator',
    name_zh_tw: '教育工作者',
    description_en: 'Teachers and trainers using AI to enhance learning experiences.',
    description_zh_tw: '用 AI 提升教學體驗的老師和培訓師。',
    skill_level: 'intermediate',
    learning_focus: ['course-creation', 'student-engagement', 'assessment'],
    recommended_goals: ['create-course', 'interactive-learning'],
    icon_url: '',
    display_order: 6
  }
];

export function PersonaHomePage({
  language,
  onPersonaSelect,
  onInspirationSelect,
  onBrowseAllInspirations,
  onNavigateToTools,
  onNavigateToUseCases,
  onNavigateToLearn
}: PersonaHomePageProps) {
  const [personas, setPersonas] = useState<Persona[]>([]);
  const [inspirations, setInspirations] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadData = async () => {
      setLoading(true);
      try {
        const [personaData, inspirationData] = await Promise.all([
          db.getPersonas(language),
          db.getFeaturedInspirations(3, language)
        ]);
        setPersonas(personaData.length > 0 ? personaData : fallbackPersonas);
        setInspirations(inspirationData);
      } catch (error) {
        console.error('Failed to load home data:', error);
        setPersonas(fallbackPersonas);
      } finally {
        setLoading(false);
      }
    };
    loadData();
  }, [language]);

  const getPersonaName = (p: Persona) => language === 'zh-TW' ? p.name_zh_tw : p.name_en;
  const getPersonaDesc = (p: Persona) => language === 'zh-TW' ? p.description_zh_tw : p.description_en;

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 via-white to-blue-50/30">
      {/* Hero Section */}
      <div className="relative overflow-hidden pt-20 pb-12">
        <div className="absolute inset-0 overflow-hidden pointer-events-none">
          <div className="absolute top-0 left-1/4 w-72 h-72 bg-blue-400/10 rounded-full blur-3xl" />
          <div className="absolute top-20 right-1/4 w-96 h-96 bg-cyan-400/10 rounded-full blur-3xl" />
          <div className="absolute bottom-0 left-1/3 w-64 h-64 bg-teal-400/10 rounded-full blur-3xl" />
        </div>

        <div className="container mx-auto px-4 max-w-5xl relative z-10 text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
          >
            <div className="inline-flex items-center gap-2 px-4 py-1.5 bg-blue-50 text-blue-600 rounded-full text-sm font-medium mb-4 border border-blue-100">
              <Sparkles className="w-4 h-4" />
              {language === 'zh-TW' ? 'AI 工具生態導航' : 'AI Tool Ecosystem Navigator'}
            </div>
            <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4 leading-tight">
              {language === 'zh-TW' ? (
                <>找到適合你的 <span className="bg-gradient-to-r from-blue-600 to-cyan-500 bg-clip-text text-transparent">AI 工具組合</span></>
              ) : (
                <>Find Your Perfect <span className="bg-gradient-to-r from-blue-600 to-cyan-500 bg-clip-text text-transparent">AI Tool Stack</span></>
              )}
            </h1>
            <p className="text-lg text-gray-500 max-w-2xl mx-auto mb-8">
              {language === 'zh-TW'
                ? '根據你的角色和目標，探索最適合的 AI 工具搭配與實戰靈感'
                : 'Explore the best AI tool combinations tailored to your role and goals'}
            </p>
          </motion.div>
        </div>
      </div>

      {/* Persona Selection */}
      <div className="container mx-auto px-4 max-w-5xl pb-12">
        <div className="flex items-center gap-2 mb-6">
          <Users className="w-5 h-5 text-gray-400" />
          <h2 className="text-xl font-semibold text-gray-900">
            {language === 'zh-TW' ? '選擇你的角色' : 'Choose Your Role'}
          </h2>
        </div>

        {loading ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {[...Array(6)].map((_, i) => (
              <div key={i} className="h-40 bg-gray-100 rounded-2xl animate-pulse" />
            ))}
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {personas.map((persona, index) => {
              const gradient = personaGradients[persona.persona_key] || defaultGradient;
              const name = getPersonaName(persona);
              const desc = getPersonaDesc(persona);

              return (
                <motion.button
                  key={persona.id}
                  onClick={() => onPersonaSelect(persona.persona_key, name)}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.4, delay: index * 0.05 }}
                  whileHover={{ y: -4 }}
                  className="group relative overflow-hidden rounded-2xl shadow-md hover:shadow-xl transition-shadow text-left bg-white border border-gray-100"
                >
                  {/* Gradient Header */}
                  <div className={`h-28 bg-gradient-to-br ${gradient} relative overflow-hidden`}>
                    <div className="absolute inset-0 bg-black/5 group-hover:bg-black/0 transition-colors" />
                    <div className="absolute top-3 right-3 w-10 h-10 rounded-xl bg-white/20 backdrop-blur-sm flex items-center justify-center">
                      <Sparkles className="w-5 h-5 text-white" />
                    </div>
                    {/* Decorative circles */}
                    <div className="absolute -bottom-8 -right-8 w-24 h-24 rounded-full bg-white/10" />
                    <div className="absolute -top-4 -left-4 w-16 h-16 rounded-full bg-white/10" />
                  </div>

                  {/* Content */}
                  <div className="p-5">
                    <h3 className="font-bold text-lg text-gray-900 group-hover:text-blue-600 transition-colors mb-1">
                      {name}
                    </h3>
                    <p className="text-sm text-gray-500 line-clamp-2 leading-relaxed">
                      {desc}
                    </p>
                    <div className="flex items-center gap-1 mt-3 text-sm font-medium text-blue-600 opacity-0 group-hover:opacity-100 transition-opacity">
                      {language === 'zh-TW' ? '探索目標' : 'Explore goals'}
                      <ArrowRight className="w-4 h-4" />
                    </div>
                  </div>
                </motion.button>
              );
            })}
          </div>
        )}
      </div>

      {/* Quick Access Cards */}
      <div className="container mx-auto px-4 max-w-5xl pb-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <QuickAccessCard
            icon={Lightbulb}
            title={language === 'zh-TW' ? '瀏覽靈感案例' : 'Browse Inspirations'}
            desc={language === 'zh-TW' ? '看看別人怎麼用 AI 工具組合' : 'See how others combine AI tools'}
            onClick={onBrowseAllInspirations}
            gradient="from-amber-400 to-orange-500"
          />
          <QuickAccessCard
            icon={Wrench}
            title={language === 'zh-TW' ? '工具探索器' : 'Tools Explorer'}
            desc={language === 'zh-TW' ? '搜尋和篩選所有 AI 工具' : 'Search and filter all AI tools'}
            onClick={() => onNavigateToTools()}
            gradient="from-blue-500 to-cyan-500"
          />
          <QuickAccessCard
            icon={BookOpen}
            title={language === 'zh-TW' ? '學習中心' : 'Learn'}
            desc={language === 'zh-TW' ? '從基礎到進階的 AI 教學' : 'From basics to advanced AI tutorials'}
            onClick={onNavigateToLearn}
            gradient="from-green-500 to-emerald-500"
          />
        </div>
      </div>

      {/* Featured Inspirations */}
      {inspirations.length > 0 && (
        <div className="container mx-auto px-4 max-w-5xl pb-16">
          <div className="flex items-center justify-between mb-6">
            <div className="flex items-center gap-2">
              <Lightbulb className="w-5 h-5 text-amber-500" />
              <h2 className="text-xl font-semibold text-gray-900">
                {language === 'zh-TW' ? '精選靈感' : 'Featured Inspirations'}
              </h2>
            </div>
            <button
              onClick={onBrowseAllInspirations}
              className="text-sm text-blue-600 hover:text-blue-700 font-medium flex items-center gap-1"
            >
              {language === 'zh-TW' ? '查看全部' : 'View all'}
              <ArrowRight className="w-4 h-4" />
            </button>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {inspirations.map((insp, i) => (
              <motion.div
                key={insp.id || i}
                onClick={() => onInspirationSelect(insp.inspiration_key)}
                className="bg-white rounded-xl shadow-sm border border-gray-100 p-5 cursor-pointer hover:shadow-md transition-shadow group"
                whileHover={{ y: -2 }}
              >
                <div className="w-10 h-10 rounded-lg bg-amber-50 flex items-center justify-center mb-3">
                  <Lightbulb className="w-5 h-5 text-amber-500" />
                </div>
                <h3 className="font-semibold text-gray-900 group-hover:text-blue-600 transition-colors mb-1">
                  {language === 'zh-TW' ? insp.title_zh_tw : insp.title_en}
                </h3>
                <p className="text-sm text-gray-500 line-clamp-2">
                  {language === 'zh-TW' ? insp.description_zh_tw : insp.description_en}
                </p>
              </motion.div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

function QuickAccessCard({ icon: Icon, title, desc, onClick, gradient }: {
  icon: any; title: string; desc: string; onClick: () => void; gradient: string;
}) {
  return (
    <motion.button
      onClick={onClick}
      whileHover={{ y: -2 }}
      className="bg-white rounded-xl shadow-sm border border-gray-100 p-5 text-left hover:shadow-md transition-shadow group"
    >
      <div className={`w-12 h-12 rounded-xl bg-gradient-to-br ${gradient} flex items-center justify-center mb-3 shadow-md`}>
        <Icon className="w-6 h-6 text-white" />
      </div>
      <h3 className="font-semibold text-gray-900 group-hover:text-blue-600 transition-colors mb-1">{title}</h3>
      <p className="text-sm text-gray-500">{desc}</p>
    </motion.button>
  );
}
