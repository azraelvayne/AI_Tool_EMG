import { useState, useEffect } from 'react';
import { Heart, Target, Lightbulb, Search, Trash2, ArrowLeft } from 'lucide-react';
import { motion } from 'framer-motion';
import { db } from '../lib/database';
import { useFavorites } from '../hooks/useFavorites';
import type { Goal, Inspiration } from '../types';
import { PageTransition } from '../components/animations/PageTransition';
import { Breadcrumb } from '../components/navigation/Breadcrumb';
import { Input } from '../components/ui/Input';
import { Button } from '../components/ui/Button';
import { Badge } from '../components/ui/Badge';
import { ComplexityBadge } from '../components/ComplexityBadge';

interface FavoritesPageProps {
  language: 'en' | 'zh-TW';
  onBackToHome: () => void;
  onGoalSelect: (goalKey: string) => void;
  onInspirationSelect: (inspirationKey: string) => void;
}

type FilterType = 'all' | 'goals' | 'inspirations';

export function FavoritesPage({
  language,
  onBackToHome,
  onGoalSelect,
  onInspirationSelect
}: FavoritesPageProps) {
  const { favorites, isGoalFavorite, isInspirationFavorite, clearAllFavorites } = useFavorites();
  const [goals, setGoals] = useState<Goal[]>([]);
  const [inspirations, setInspirations] = useState<Inspiration[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [filterType, setFilterType] = useState<FilterType>('all');

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
    loadFavorites();
  }, [favorites, language]);

  const loadFavorites = async () => {
    try {
      setLoading(true);
      const [goalsData, inspirationsData] = await Promise.all([
        Promise.all(
          favorites.goals.map(async (goalKey) => {
            const goal = await db.getGoalByKey(goalKey, language);
            return goal;
          })
        ),
        Promise.all(
          favorites.inspirations.map(async (inspirationKey) => {
            const inspiration = await db.getInspirationByKey(inspirationKey, language);
            return inspiration;
          })
        )
      ]);

      setGoals(goalsData.filter((g): g is Goal => g !== null));
      setInspirations(inspirationsData.filter((i): i is Inspiration => i !== null));
    } catch (error) {
      console.error('Error loading favorites:', error);
    } finally {
      setLoading(false);
    }
  };

  const filteredGoals = goals.filter(goal => {
    const matchesSearch = searchQuery === '' ||
      (language === 'zh-TW' ? goal.title_zh_tw : goal.title_en).toLowerCase().includes(searchQuery.toLowerCase());
    return matchesSearch;
  });

  const filteredInspirations = inspirations.filter(inspiration => {
    const matchesSearch = searchQuery === '' ||
      (language === 'zh-TW' ? inspiration.title_zh_tw : inspiration.title_en).toLowerCase().includes(searchQuery.toLowerCase());
    return matchesSearch;
  });

  const showGoals = filterType === 'all' || filterType === 'goals';
  const showInspirations = filterType === 'all' || filterType === 'inspirations';

  const totalCount = favorites.goals.length + favorites.inspirations.length;

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-pink-50 via-white to-purple-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-pink-600 mx-auto mb-4"></div>
          <p className="text-gray-600">{language === 'zh-TW' ? '載入中...' : 'Loading...'}</p>
        </div>
      </div>
    );
  }

  return (
    <PageTransition className="min-h-screen bg-gradient-to-br from-pink-50 via-white to-purple-50">
      <div className="bg-gradient-to-r from-pink-600 to-purple-600 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              {
                label: language === 'zh-TW' ? '首頁' : 'Home',
                onClick: onBackToHome
              },
              {
                label: language === 'zh-TW' ? '我的收藏' : 'My Favorites',
                isCurrentPage: true
              }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="flex items-start gap-6">
            <div className="w-20 h-20 bg-white/10 backdrop-blur-sm rounded-2xl flex items-center justify-center">
              <Heart className="w-10 h-10" />
            </div>
            <div className="flex-1">
              <h1 className="text-4xl font-bold mb-3">
                {language === 'zh-TW' ? '我的收藏' : 'My Favorites'}
              </h1>
              <p className="text-xl text-pink-100 mb-4">
                {language === 'zh-TW'
                  ? '你收藏的學習目標與靈感案例'
                  : 'Your saved learning goals and inspirations'}
              </p>
              <div className="flex items-center gap-3">
                <Badge className="bg-white/20 text-white border-white/30">
                  {totalCount} {language === 'zh-TW' ? '項收藏' : 'items'}
                </Badge>
                {totalCount > 0 && (
                  <button
                    onClick={clearAllFavorites}
                    className="inline-flex items-center gap-2 text-sm text-white/90 hover:text-white transition-colors"
                  >
                    <Trash2 className="w-4 h-4" />
                    <span>{language === 'zh-TW' ? '清除全部' : 'Clear All'}</span>
                  </button>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {totalCount > 0 ? (
          <>
            <div className="mb-8 space-y-4">
              <div className="flex flex-col sm:flex-row gap-4">
                <div className="flex-1">
                  <Input
                    type="search"
                    placeholder={language === 'zh-TW' ? '搜尋收藏項目...' : 'Search favorites...'}
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    icon={Search}
                  />
                </div>
                <div className="flex gap-2">
                  <Button
                    variant={filterType === 'all' ? 'primary' : 'outline'}
                    onClick={() => setFilterType('all')}
                  >
                    {language === 'zh-TW' ? '全部' : 'All'}
                  </Button>
                  <Button
                    variant={filterType === 'goals' ? 'primary' : 'outline'}
                    onClick={() => setFilterType('goals')}
                  >
                    <Target className="w-4 h-4 mr-1" />
                    {language === 'zh-TW' ? '目標' : 'Goals'} ({favorites.goals.length})
                  </Button>
                  <Button
                    variant={filterType === 'inspirations' ? 'primary' : 'outline'}
                    onClick={() => setFilterType('inspirations')}
                  >
                    <Lightbulb className="w-4 h-4 mr-1" />
                    {language === 'zh-TW' ? '靈感' : 'Inspirations'} ({favorites.inspirations.length})
                  </Button>
                </div>
              </div>
            </div>

            {showGoals && filteredGoals.length > 0 && (
              <div className="mb-12">
                <div className="flex items-center gap-3 mb-6">
                  <Target className="w-7 h-7 text-blue-600" />
                  <h2 className="text-2xl font-bold text-gray-900">
                    {language === 'zh-TW' ? '學習目標' : 'Learning Goals'}
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
                  {filteredGoals.map((goal) => (
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
                        <h3 className="text-xl font-semibold text-gray-900 group-hover:text-blue-600 transition-colors flex-1">
                          {language === 'zh-TW' ? goal.title_zh_tw : goal.title_en}
                        </h3>
                        <ComplexityBadge level={goal.difficulty} language={language} />
                      </div>
                      <p className="text-gray-600 mb-4 line-clamp-2">
                        {language === 'zh-TW' ? goal.description_zh_tw : goal.description_en}
                      </p>
                      <div className="flex items-center justify-between">
                        <Badge className="bg-blue-50 text-blue-700 border-blue-200">
                          <Target className="w-3 h-3 mr-1" />
                          {language === 'zh-TW' ? '學習目標' : 'Goal'}
                        </Badge>
                        <Heart className="w-5 h-5 text-pink-500 fill-pink-500" />
                      </div>
                    </motion.div>
                  ))}
                </motion.div>
              </div>
            )}

            {showInspirations && filteredInspirations.length > 0 && (
              <div className="mb-12">
                <div className="flex items-center gap-3 mb-6">
                  <Lightbulb className="w-7 h-7 text-purple-600" />
                  <h2 className="text-2xl font-bold text-gray-900">
                    {language === 'zh-TW' ? '靈感案例' : 'Inspirations'}
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
                  {filteredInspirations.map((inspiration) => (
                    <motion.div
                      key={inspiration.id}
                      variants={{
                        hidden: { opacity: 0, y: 20 },
                        visible: { opacity: 1, y: 0 }
                      }}
                      onClick={() => onInspirationSelect(inspiration.inspiration_key)}
                      className="bg-white rounded-xl border border-gray-200 p-6 hover:shadow-lg transition-all duration-300 cursor-pointer group"
                    >
                      <div className="flex items-start justify-between mb-3">
                        <h3 className="text-lg font-semibold text-gray-900 group-hover:text-purple-600 transition-colors flex-1">
                          {language === 'zh-TW' ? inspiration.title_zh_tw : inspiration.title_en}
                        </h3>
                        <ComplexityBadge level={inspiration.difficulty} language={language} />
                      </div>
                      <p className="text-gray-600 mb-4 line-clamp-2 text-sm">
                        {language === 'zh-TW' ? inspiration.description_zh_tw : inspiration.description_en}
                      </p>
                      <div className="flex items-center justify-between">
                        <Badge className="bg-purple-50 text-purple-700 border-purple-200">
                          <Lightbulb className="w-3 h-3 mr-1" />
                          {language === 'zh-TW' ? '靈感' : 'Inspiration'}
                        </Badge>
                        <Heart className="w-5 h-5 text-pink-500 fill-pink-500" />
                      </div>
                    </motion.div>
                  ))}
                </motion.div>
              </div>
            )}

            {(showGoals && filteredGoals.length === 0) && (showInspirations && filteredInspirations.length === 0) && (
              <div className="text-center py-16">
                <Search className="w-16 h-16 text-gray-300 mx-auto mb-4" />
                <p className="text-xl text-gray-600 mb-2">
                  {language === 'zh-TW' ? '沒有符合的收藏項目' : 'No matching favorites found'}
                </p>
                <p className="text-gray-500">
                  {language === 'zh-TW' ? '試試其他搜尋關鍵字' : 'Try a different search term'}
                </p>
              </div>
            )}
          </>
        ) : (
          <div className="text-center py-16">
            <div className="w-24 h-24 bg-pink-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <Heart className="w-12 h-12 text-pink-400" />
            </div>
            <h2 className="text-2xl font-bold text-gray-900 mb-3">
              {language === 'zh-TW' ? '還沒有收藏項目' : 'No favorites yet'}
            </h2>
            <p className="text-gray-600 mb-8 max-w-md mx-auto">
              {language === 'zh-TW'
                ? '探索學習目標和靈感案例，點擊愛心圖示加入收藏，建立你的個人學習清單'
                : 'Explore learning goals and inspirations, click the heart icon to save your favorites and build your personal learning list'}
            </p>
            <Button onClick={onBackToHome} size="lg">
              <ArrowLeft className="w-5 h-5 mr-2" />
              {language === 'zh-TW' ? '探索內容' : 'Explore Content'}
            </Button>
          </div>
        )}
      </div>
    </PageTransition>
  );
}
