import { useState, useEffect } from 'react';
import { Lightbulb, Search, Filter, Sparkles } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { motion } from 'framer-motion';
import { PageTransition } from '../components/animations/PageTransition';
import { Breadcrumb } from '../components/navigation/Breadcrumb';
import { Input } from '../components/ui/Input';
import { Button } from '../components/ui/Button';
import { Badge } from '../components/ui/Badge';
import { ComplexityBadge } from '../components/ComplexityBadge';
import { CreativeUseCaseDetailModal } from '../components/CreativeUseCaseDetailModal';
import { db } from '../lib/database';

interface CreativeUseCasesPageProps {
  language: 'en' | 'zh-TW';
  onBackToHome: () => void;
  onNavigateToTools: (filters?: any) => void;
}

interface CreativeUseCase {
  id: string;
  slug: string;
  title: string;
  title_en: string;
  description: string;
  description_en: string;
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  use_case_tags: string[];
  tools: string[];
  workflow_steps?: string[];
  estimated_time?: string;
}

export function CreativeUseCasesPage({ language, onBackToHome, onNavigateToTools }: CreativeUseCasesPageProps) {
  const { t } = useTranslation();
  const [useCases, setUseCases] = useState<CreativeUseCase[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedDifficulty, setSelectedDifficulty] = useState<string>('all');
  const [selectedTag, setSelectedTag] = useState<string>('all');
  const [selectedUseCase, setSelectedUseCase] = useState<CreativeUseCase | null>(null);
  const [showDetailModal, setShowDetailModal] = useState(false);

  useEffect(() => {
    loadUseCases();
  }, [language]);

  const loadUseCases = async () => {
    try {
      setLoading(true);
      const data = await db.getCreativeUseCases();
      setUseCases(data || []);
    } catch (error) {
      console.error('Error loading use cases:', error);
      setUseCases([]);
    } finally {
      setLoading(false);
    }
  };

  const filteredUseCases = useCases.filter(useCase => {
    const matchesSearch = searchQuery === '' ||
      (language === 'zh-TW' ? useCase.title : useCase.title_en).toLowerCase().includes(searchQuery.toLowerCase());
    const matchesDifficulty = selectedDifficulty === 'all' || useCase.difficulty === selectedDifficulty;
    const matchesTag = selectedTag === 'all' || useCase.use_case_tags.includes(selectedTag);

    return matchesSearch && matchesDifficulty && matchesTag;
  });

  const allTags = Array.from(new Set(useCases.flatMap(uc => uc.use_case_tags)));

  const handleApplyStack = (tools: string[]) => {
    onNavigateToTools({ tools });
  };

  const handleViewDetails = (useCase: CreativeUseCase) => {
    setSelectedUseCase(useCase);
    setShowDetailModal(true);
  };

  const handleCloseDetail = () => {
    setShowDetailModal(false);
    setSelectedUseCase(null);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-teal-50 via-white to-green-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600 mx-auto mb-4"></div>
          <p className="text-gray-600">{language === 'zh-TW' ? '載入中...' : 'Loading...'}</p>
        </div>
      </div>
    );
  }

  return (
    <PageTransition className="min-h-screen bg-gradient-to-br from-teal-50 via-white to-green-50">
      <div className="bg-gradient-header text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              {
                label: language === 'zh-TW' ? '首頁' : 'Home',
                onClick: onBackToHome
              },
              {
                label: language === 'zh-TW' ? '創意用例' : 'Creative Use Cases',
                isCurrentPage: true
              }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="flex items-start gap-6">
            <div className="w-20 h-20 bg-white/10 backdrop-blur-sm rounded-2xl flex items-center justify-center">
              <Lightbulb className="w-10 h-10" />
            </div>
            <div className="flex-1">
              <h1 className="text-4xl font-bold mb-3">
                {language === 'zh-TW' ? '創意用例畫廊' : 'Creative Use Cases Gallery'}
              </h1>
              <p className="text-xl text-blue-100 mb-4">
                {language === 'zh-TW'
                  ? '探索跨領域創意應用，找到靈感並一鍵套用工具堆疊'
                  : 'Explore cross-domain creative applications and apply tool stacks with one click'}
              </p>
              <Badge className="bg-white/20 text-white border-white/30">
                {filteredUseCases.length} {language === 'zh-TW' ? '個用例' : 'use cases'}
              </Badge>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="mb-8 space-y-4">
          <div className="flex flex-col sm:flex-row gap-4">
            <div className="flex-1">
              <Input
                type="search"
                placeholder={language === 'zh-TW' ? '搜尋創意用例...' : 'Search use cases...'}
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                icon={Search}
              />
            </div>
            <div className="flex gap-2">
              <select
                value={selectedDifficulty}
                onChange={(e) => setSelectedDifficulty(e.target.value)}
                className="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
              >
                <option value="all">{language === 'zh-TW' ? '所有難度' : 'All Difficulties'}</option>
                <option value="beginner">{language === 'zh-TW' ? '初學者' : 'Beginner'}</option>
                <option value="intermediate">{language === 'zh-TW' ? '中級' : 'Intermediate'}</option>
                <option value="advanced">{language === 'zh-TW' ? '進階' : 'Advanced'}</option>
              </select>
              {allTags.length > 0 && (
                <select
                  value={selectedTag}
                  onChange={(e) => setSelectedTag(e.target.value)}
                  className="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                >
                  <option value="all">{language === 'zh-TW' ? '所有標籤' : 'All Tags'}</option>
                  {allTags.map(tag => (
                    <option key={tag} value={tag}>{tag}</option>
                  ))}
                </select>
              )}
            </div>
          </div>
        </div>

        {filteredUseCases.length === 0 ? (
          <div className="text-center py-16">
            <Lightbulb className="w-16 h-16 text-gray-300 mx-auto mb-4" />
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              {language === 'zh-TW' ? '沒有符合的用例' : 'No matching use cases'}
            </h3>
            <p className="text-gray-600">
              {language === 'zh-TW' ? '試試調整篩選條件' : 'Try adjusting your filters'}
            </p>
          </div>
        ) : (
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
            {filteredUseCases.map((useCase) => (
              <motion.div
                key={useCase.id}
                variants={{
                  hidden: { opacity: 0, y: 20 },
                  visible: { opacity: 1, y: 0 }
                }}
                className="bg-white rounded-xl border border-gray-200 p-6 hover:shadow-lg transition-all duration-300 cursor-pointer group"
              >
                <div className="flex items-start justify-between mb-3">
                  <h3 className="text-xl font-semibold text-gray-900 group-hover:text-primary-600 transition-colors flex-1">
                    {language === 'zh-TW' ? useCase.title : useCase.title_en}
                  </h3>
                  <ComplexityBadge level={useCase.difficulty} language={language} />
                </div>
                <p className="text-gray-600 mb-4 line-clamp-3">
                  {language === 'zh-TW' ? useCase.description : useCase.description_en}
                </p>

                {useCase.use_case_tags.length > 0 && (
                  <div className="flex flex-wrap gap-2 mb-4">
                    {useCase.use_case_tags.slice(0, 3).map((tag) => (
                      <Badge key={tag} className="bg-primary-50 text-primary-700 border-primary-200">
                        {tag}
                      </Badge>
                    ))}
                  </div>
                )}

                <div className="mb-4">
                  <p className="text-sm text-gray-600 mb-2">
                    {language === 'zh-TW' ? '使用工具：' : 'Tools used:'}
                  </p>
                  <div className="flex flex-wrap gap-1">
                    {useCase.tools.map((tool) => (
                      <span key={tool} className="text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded">
                        {tool}
                      </span>
                    ))}
                  </div>
                </div>

                <div className="flex gap-2">
                  <Button
                    size="sm"
                    variant="outline"
                    className="flex-1"
                    onClick={() => handleViewDetails(useCase)}
                  >
                    {language === 'zh-TW' ? '查看詳情' : 'View Details'}
                  </Button>
                  <Button
                    size="sm"
                    variant="primary"
                    icon={Sparkles}
                    className="flex-1"
                    onClick={() => handleApplyStack(useCase.tools)}
                  >
                    {language === 'zh-TW' ? '套用堆疊' : 'Apply Stack'}
                  </Button>
                </div>
              </motion.div>
            ))}
          </motion.div>
        )}
      </div>

      <CreativeUseCaseDetailModal
        useCase={selectedUseCase}
        isOpen={showDetailModal}
        onClose={handleCloseDetail}
        language={language}
        onApplyStack={handleApplyStack}
      />
    </PageTransition>
  );
}
