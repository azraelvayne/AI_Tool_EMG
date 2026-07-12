import { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Sparkles, ArrowRight, Lightbulb, Layers, BookOpen, Users } from 'lucide-react';
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
  'content-creator':    'from-pink-500 via-rose-500 to-orange-400',
  'developer':          'from-blue-600 via-indigo-500 to-cyan-500',
  'student':            'from-green-500 via-emerald-500 to-teal-400',
  'marketer':           'from-amber-500 via-orange-500 to-red-400',
  'entrepreneur':       'from-violet-600 via-purple-500 to-fuchsia-400',
  'educator':           'from-teal-600 via-cyan-500 to-blue-400',
  'researcher':         'from-slate-600 via-gray-500 to-zinc-400',
  'designer':           'from-rose-500 via-pink-500 to-purple-400',
  'ai-tool-designer':   'from-cyan-500 via-blue-500 to-violet-500',
  'workflow-architect': 'from-emerald-500 via-teal-500 to-cyan-500',
  'knowledge-manager':  'from-amber-400 via-yellow-400 to-lime-400',
  'data-analyst':       'from-blue-500 via-sky-400 to-teal-400',
  'business-developer': 'from-orange-500 via-amber-400 to-yellow-400',
  'creative-builder':   'from-fuchsia-500 via-pink-500 to-rose-400',
};

const defaultGradient = 'from-blue-500 via-cyan-500 to-teal-400';

const fallbackPersonas: Persona[] = [
  {
    id: '1', persona_key: 'content-creator',
    name_en: 'Content Creator', name_zh_tw: '內容創作者',
    description_en: 'Bloggers, YouTubers, and social media creators who want to streamline content production.',
    description_zh_tw: '部落客、YouTuber 和社群媒體創作者，希望用 AI 加速內容產出。',
    skill_level: 'beginner', learning_focus: [], recommended_goals: [], icon_url: '', display_order: 1
  },
  {
    id: '2', persona_key: 'developer',
    name_en: 'Developer', name_zh_tw: '開發者',
    description_en: 'Engineers looking to integrate AI tools into their development workflow.',
    description_zh_tw: '希望將 AI 工具整合到開發流程中的工程師。',
    skill_level: 'intermediate', learning_focus: [], recommended_goals: [], icon_url: '', display_order: 2
  },
  {
    id: '3', persona_key: 'student',
    name_en: 'Student / Learner', name_zh_tw: '學生 / 學習者',
    description_en: 'Students who want to learn faster and study more effectively with AI.',
    description_zh_tw: '希望利用 AI 更快學習、更有效率讀書的學生。',
    skill_level: 'beginner', learning_focus: [], recommended_goals: [], icon_url: '', display_order: 3
  },
  {
    id: '4', persona_key: 'marketer',
    name_en: 'Marketer', name_zh_tw: '行銷人員',
    description_en: 'Marketing professionals who want to leverage AI for campaigns and analytics.',
    description_zh_tw: '希望利用 AI 進行行銷活動和數據分析的行銷專業人員。',
    skill_level: 'intermediate', learning_focus: [], recommended_goals: [], icon_url: '', display_order: 4
  },
  {
    id: '5', persona_key: 'entrepreneur',
    name_en: 'Entrepreneur', name_zh_tw: '創業者',
    description_en: 'Founders and solopreneurs building products with AI-powered tools.',
    description_zh_tw: '用 AI 工具打造產品的創業者和獨立開發者。',
    skill_level: 'intermediate', learning_focus: [], recommended_goals: [], icon_url: '', display_order: 5
  },
  {
    id: '6', persona_key: 'educator',
    name_en: 'Educator', name_zh_tw: '教育工作者',
    description_en: 'Teachers and trainers using AI to enhance learning experiences.',
    description_zh_tw: '用 AI 提升教學體驗的老師和培訓師。',
    skill_level: 'intermediate', learning_focus: [], recommended_goals: [], icon_url: '', display_order: 6
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
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadData = async () => {
      setLoading(true);
      try {
        const personaData = await db.getPersonas(language);
        setPersonas(personaData.length > 0 ? personaData : fallbackPersonas);
      } catch {
        setPersonas(fallbackPersonas);
      } finally {
        setLoading(false);
      }
    };
    loadData();
  }, [language]);

  const getPersonaName = (p: Persona) => language === 'zh-TW' ? p.name_zh_tw : p.name_en;
  const getPersonaDesc = (p: Persona) => language === 'zh-TW' ? p.description_zh_tw : p.description_en;

  const navCards = [
    {
      icon: Layers,
      titleZh: '工具目錄',
      titleEn: 'Tools Directory',
      descZh: '探索 100+ 精選工具，使用多維度篩選找到最適合的解決方案',
      descEn: 'Explore 100+ curated tools with multi-dimensional filters',
      ctaZh: '開始探索',
      ctaEn: 'Explore',
      gradient: 'from-teal-400 to-emerald-500',
      onClick: () => onNavigateToTools(),
    },
    {
      icon: Sparkles,
      titleZh: '精選應用靈感',
      titleEn: 'Featured Inspirations',
      descZh: '從真實案例中學習，發現 AI 自動化的無限可能',
      descEn: 'Learn from real cases and discover what AI automation can do',
      ctaZh: '查看靈感',
      ctaEn: 'Browse',
      gradient: 'from-orange-400 to-rose-400',
      onClick: onBrowseAllInspirations,
    },
    {
      icon: Lightbulb,
      titleZh: '創意堆疊',
      titleEn: 'Creative Stacks',
      descZh: '探索跨領域創意應用場景，一鍵套用工具組合',
      descEn: 'Cross-domain creative scenarios with ready-to-use tool stacks',
      ctaZh: '查看案例',
      ctaEn: 'View cases',
      gradient: 'from-purple-300 to-blue-300',
      onClick: onNavigateToUseCases,
    },
    {
      icon: BookOpen,
      titleZh: '學習中心',
      titleEn: 'Learn',
      descZh: '深入了解平台功能、使用指南和最新更新資訊',
      descEn: 'Platform guides, tutorials and the latest updates',
      ctaZh: '前往學習',
      ctaEn: 'Start learning',
      gradient: 'from-blue-300 to-sky-200',
      onClick: onNavigateToLearn,
    },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* =====================================================================
          HERO — full-width gradient banner (matches original screenshot)
      ===================================================================== */}
      <div className="relative overflow-hidden bg-gradient-to-br from-blue-500 via-cyan-400 to-teal-400 pt-20 pb-16">
        {/* Subtle light blobs for depth */}
        <div className="absolute inset-0 pointer-events-none overflow-hidden">
          <div className="absolute -top-24 -left-24 w-96 h-96 rounded-full bg-white/10 blur-3xl" />
          <div className="absolute top-10 right-0 w-80 h-80 rounded-full bg-white/10 blur-3xl" />
          <div className="absolute bottom-0 left-1/3 w-64 h-64 rounded-full bg-teal-300/20 blur-2xl" />
        </div>

        <div className="container mx-auto px-4 max-w-4xl relative z-10 text-center">
          <motion.div
            initial={{ opacity: 0, y: 18 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.55 }}
          >
            {/* Pill tag */}
            <div className="inline-flex items-center gap-2 px-4 py-1.5 bg-white/20 backdrop-blur-sm text-white rounded-full text-sm font-medium mb-5 border border-white/30">
              <Sparkles className="w-4 h-4" />
              {language === 'zh-TW' ? 'AI 自動化學習探索平台' : 'AI Automation Learning Platform'}
            </div>

            {/* Main heading */}
            <h1 className="text-4xl md:text-5xl font-bold text-white mb-4 leading-tight drop-shadow-sm">
              {language === 'zh-TW'
                ? '從靈感出發，構建屬於你的 AI 工作流'
                : 'Start with Inspiration, Build Your AI Workflow'}
            </h1>

            {/* Subtitle */}
            <p className="text-white/85 text-lg max-w-2xl mx-auto">
              {language === 'zh-TW'
                ? '選擇你的身份，發現適合你的 AI 自動化與創意應用學習路徑'
                : 'Choose your role and discover the AI automation learning path that fits you'}
            </p>
          </motion.div>
        </div>
      </div>

      {/* =====================================================================
          4 NAVIGATION CARDS
      ===================================================================== */}
      <div className="container mx-auto px-4 max-w-6xl -mt-6 pb-10 relative z-10">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {navCards.map((card, i) => {
            const Icon = card.icon;
            return (
              <motion.button
                key={i}
                onClick={card.onClick}
                initial={{ opacity: 0, y: 24 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.4, delay: i * 0.07 }}
                whileHover={{ y: -4, scale: 1.02 }}
                className={`group relative overflow-hidden rounded-2xl p-6 text-left shadow-md hover:shadow-xl transition-all bg-gradient-to-br ${card.gradient} min-h-[200px] flex flex-col`}
              >
                {/* Decorative blobs */}
                <div className="absolute -top-6 -right-6 w-28 h-28 rounded-full bg-white/15 pointer-events-none" />
                <div className="absolute -bottom-8 -left-6 w-24 h-24 rounded-full bg-white/10 pointer-events-none" />

                {/* Icon */}
                <div className="w-12 h-12 rounded-xl bg-white/25 backdrop-blur-sm flex items-center justify-center mb-4 flex-shrink-0">
                  <Icon className="w-6 h-6 text-white" />
                </div>

                {/* Text */}
                <div className="flex-1 relative z-10">
                  <h3 className="text-lg font-bold text-white mb-2 leading-snug">
                    {language === 'zh-TW' ? card.titleZh : card.titleEn}
                  </h3>
                  <p className="text-white/80 text-sm leading-relaxed line-clamp-3">
                    {language === 'zh-TW' ? card.descZh : card.descEn}
                  </p>
                </div>

                {/* CTA */}
                <div className="flex items-center gap-1 mt-4 text-sm font-semibold text-white/90 group-hover:text-white group-hover:gap-2 transition-all relative z-10">
                  {language === 'zh-TW' ? card.ctaZh : card.ctaEn}
                  <ArrowRight className="w-4 h-4" />
                </div>
              </motion.button>
            );
          })}
        </div>
      </div>

      {/* =====================================================================
          PERSONA SELECTION
      ===================================================================== */}
      <div className="container mx-auto px-4 max-w-6xl pb-16">
        <div className="flex items-center gap-2 mb-6">
          <Users className="w-5 h-5 text-gray-400" />
          <h2 className="text-xl font-semibold text-gray-900">
            {language === 'zh-TW' ? '選擇你的角色' : 'Choose Your Role'}
          </h2>
        </div>

        {loading ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {[...Array(6)].map((_, i) => (
              <div key={i} className="h-44 bg-gray-100 rounded-2xl animate-pulse" />
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
                  className="group relative overflow-hidden rounded-2xl shadow-md hover:shadow-xl transition-all text-left bg-white border border-gray-100"
                >
                  {/* Gradient header strip */}
                  <div className={`h-24 bg-gradient-to-br ${gradient} relative overflow-hidden`}>
                    <div className="absolute inset-0 bg-black/5 group-hover:bg-black/0 transition-colors" />
                    {/* Icon badge */}
                    <div className="absolute top-3 right-3 w-9 h-9 rounded-xl bg-white/25 backdrop-blur-sm flex items-center justify-center">
                      <Sparkles className="w-4 h-4 text-white" />
                    </div>
                    {/* Decorative circles */}
                    <div className="absolute -bottom-6 -right-6 w-20 h-20 rounded-full bg-white/10" />
                    <div className="absolute -top-4 -left-4 w-14 h-14 rounded-full bg-white/10" />
                    {/* Persona image if available */}
                    {persona.icon_url && (
                      <img
                        src={persona.icon_url}
                        alt={name}
                        className="absolute bottom-0 left-4 h-20 object-contain object-bottom"
                      />
                    )}
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
    </div>
  );
}
