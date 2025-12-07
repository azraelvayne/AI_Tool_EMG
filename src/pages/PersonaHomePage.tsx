import { useState, useEffect } from 'react';
import { Sparkles, ArrowRight, Users, Target, Layers, BookOpen, Lightbulb } from 'lucide-react';
import { PersonaCard } from '../components/PersonaCard';
import { InspirationCard } from '../components/InspirationCard';
import { db } from '../lib/database';
import type { Persona, Inspiration } from '../types';

interface PersonaHomePageProps {
  language: 'en' | 'zh-TW';
  onPersonaSelect: (personaKey: string, personaName?: string) => void;
  onInspirationSelect: (inspirationKey: string) => void;
  onBrowseAllInspirations: () => void;
  onNavigateToTools?: () => void;
  onNavigateToUseCases?: () => void;
  onNavigateToLearn?: () => void;
}

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
  const [featuredInspirations, setFeaturedInspirations] = useState<Inspiration[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadData = async () => {
      try {
        setLoading(true);
        const [personasData, inspirationsData] = await Promise.all([
          db.getPersonas(language),
          db.getFeaturedInspirations(6, language)
        ]);
        setPersonas(personasData);
        setFeaturedInspirations(inspirationsData);
      } catch (error) {
        console.error('Error loading data:', error);
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, [language]);

  const title = language === 'zh-TW'
    ? '從靈感出發，構建屬於你的 AI 工作流'
    : 'Explore Your AI Learning Path Through Real-World Inspiration';

  const subtitle = language === 'zh-TW'
    ? '選擇你的身份，發現適合你的 AI 自動化與創意應用學習路徑'
    : 'Choose your identity and discover AI automation and creative application learning paths tailored for you';

  const personaSectionTitle = language === 'zh-TW' ? '我想成為...' : 'I Want to Become...';
  const inspirationSectionTitle = language === 'zh-TW' ? '精選應用靈感' : 'Featured Application Examples';
  const inspirationSubtitle = language === 'zh-TW'
    ? '從真實案例開始，看看別人如何用 AI 與自動化解決問題'
    : 'Start with real examples and see how others solve problems with AI and automation';

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-orange-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">{language === 'zh-TW' ? '載入中...' : 'Loading...'}</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-orange-50">
      {/* Hero Section */}
      <div className="bg-gradient-hero-cool text-white">
        <div className="max-w-7xl mx-auto px-4 py-16 sm:px-6 lg:px-8">
          <div className="text-center">
            <div className="inline-flex items-center gap-2 bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full mb-6">
              <Sparkles className="w-5 h-5" />
              <span className="text-sm font-medium">
                {language === 'zh-TW' ? 'AI 自動化學習探索平台' : 'AI Automation Learning Explorer'}
              </span>
            </div>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4 leading-tight">
              {title}
            </h1>
            <p className="text-xl text-blue-100 max-w-3xl mx-auto">
              {subtitle}
            </p>
          </div>
        </div>
      </div>

      {/* Three CTA Blocks */}
      <div className="max-w-7xl mx-auto px-4 py-12 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-16">
          {/* Tools Directory CTA */}
          <button
            onClick={onNavigateToTools}
            className="bg-gradient-cool rounded-2xl p-8 text-white text-left hover:shadow-2xl hover:scale-105 transition-all duration-300 group"
          >
            <div className="w-14 h-14 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center mb-4 group-hover:bg-white/30 transition-colors">
              <Layers className="w-8 h-8" />
            </div>
            <h3 className="text-2xl font-bold mb-3">
              {language === 'zh-TW' ? '工具目錄' : 'Tool Directory'}
            </h3>
            <p className="text-green-100 mb-4">
              {language === 'zh-TW'
                ? '探索 100+ 精選工具，使用多維度篩選找到最適合的解決方案'
                : 'Explore 100+ curated tools with multi-dimensional filtering'}
            </p>
            <div className="flex items-center gap-2 text-sm font-medium">
              <span>{language === 'zh-TW' ? '開始探索' : 'Start Exploring'}</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </button>

          {/* Creative Use Cases CTA */}
          <button
            onClick={onNavigateToUseCases}
            className="bg-gradient-warm rounded-2xl p-8 text-white text-left hover:shadow-2xl hover:scale-105 transition-all duration-300 group"
          >
            <div className="w-14 h-14 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center mb-4 group-hover:bg-white/30 transition-colors">
              <Lightbulb className="w-8 h-8" />
            </div>
            <h3 className="text-2xl font-bold mb-3">
              {language === 'zh-TW' ? '創意堆疊' : 'Creative Stacks'}
            </h3>
            <p className="text-purple-100 mb-4">
              {language === 'zh-TW'
                ? '探索跨領域創意應用場景，一鍵套用工具組合'
                : 'Discover creative cross-domain applications with one-click tool stacks'}
            </p>
            <div className="flex items-center gap-2 text-sm font-medium">
              <span>{language === 'zh-TW' ? '查看靈感' : 'View Inspirations'}</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </button>

          {/* Learn More CTA */}
          <button
            onClick={onNavigateToLearn}
            className="bg-gradient-cool-soft rounded-2xl p-8 text-white text-left hover:shadow-2xl hover:scale-105 transition-all duration-300 group"
          >
            <div className="w-14 h-14 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center mb-4 group-hover:bg-white/30 transition-colors">
              <BookOpen className="w-8 h-8" />
            </div>
            <h3 className="text-2xl font-bold mb-3">
              {language === 'zh-TW' ? '了解更多' : 'Learn More'}
            </h3>
            <p className="text-blue-100 mb-4">
              {language === 'zh-TW'
                ? '深入了解平台功能、使用指南、匯出教學與常見問題'
                : 'Platform guides, export tutorials, and frequently asked questions'}
            </p>
            <div className="flex items-center gap-2 text-sm font-medium">
              <span>{language === 'zh-TW' ? '前往學習' : 'Go to Learn'}</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </div>
          </button>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 pb-12 sm:px-6 lg:px-8">
        {/* Personas Section */}
        <div className="mb-16">
          <div className="flex items-center gap-3 mb-8">
            <Users className="w-8 h-8 text-blue-600" />
            <div>
              <h2 className="text-3xl font-bold text-gray-900">{personaSectionTitle}</h2>
              <p className="text-gray-600 mt-1">
                {language === 'zh-TW'
                  ? '選擇最符合你的身份，開始你的學習旅程'
                  : 'Choose the identity that best matches you and start your learning journey'}
              </p>
            </div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 max-w-6xl mx-auto">
            {personas.map((persona) => (
              <PersonaCard
                key={persona.id}
                persona={persona}
                language={language}
                onClick={() => onPersonaSelect(
                  persona.persona_key,
                  language === 'zh-TW' ? persona.name_zh_tw : persona.name_en
                )}
              />
            ))}
          </div>
        </div>

        {/* Featured Inspirations Section */}
        <div>
          <div className="flex items-center gap-3 mb-8">
            <Target className="w-8 h-8 text-indigo-600" />
            <div>
              <h2 className="text-3xl font-bold text-gray-900">{inspirationSectionTitle}</h2>
              <p className="text-gray-600 mt-1">{inspirationSubtitle}</p>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {featuredInspirations.map((inspiration) => (
              <InspirationCard
                key={inspiration.id}
                inspiration={inspiration}
                language={language}
                onClick={() => onInspirationSelect(inspiration.inspiration_key)}
              />
            ))}
          </div>

          <div className="mt-8 text-center">
            <button
              onClick={onBrowseAllInspirations}
              className="inline-flex items-center gap-2 px-6 py-3 bg-gradient-cool text-white rounded-lg hover:opacity-90 transition-all duration-300 font-medium shadow-lg hover:shadow-xl"
            >
              <span>{language === 'zh-TW' ? '瀏覽所有靈感' : 'Explore All Inspirations'}</span>
              <ArrowRight className="w-5 h-5" />
            </button>
          </div>
        </div>
      </div>

      {/* Footer CTA */}
      <div className="bg-gradient-to-r from-gray-900 to-gray-800 text-white mt-16">
        <div className="max-w-7xl mx-auto px-4 py-12 sm:px-6 lg:px-8 text-center">
          <h3 className="text-2xl font-bold mb-4">
            {language === 'zh-TW' ? '準備好開始你的 AI 學習之旅了嗎？' : 'Ready to Start Your AI Learning Journey?'}
          </h3>
          <p className="text-gray-300 mb-6">
            {language === 'zh-TW'
              ? '選擇一個身份，探索適合你的學習路徑，開始打造屬於你的 AI 自動化工作流'
              : 'Choose an identity, explore learning paths tailored for you, and start building your own AI automation workflows'}
          </p>
        </div>
      </div>
    </div>
  );
}
