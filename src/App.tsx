import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AppProvider } from './contexts/AppContext';
import { PersonaHomePage } from './pages/PersonaHomePage';
import { PersonaDetailPage } from './pages/PersonaDetailPage';
import { GoalDetailPage } from './pages/GoalDetailPage';
import { InspirationBrowsePage } from './pages/InspirationBrowsePage';
import { InspirationDetailPage } from './pages/InspirationDetailPage';
import { FavoritesPage } from './pages/FavoritesPage';
import { ToolsExplorerPage } from './pages/ToolsExplorerPage';
import { CreativeUseCasesPage } from './pages/CreativeUseCasesPage';
import { LearnPage } from './pages/LearnPage';
import { LanguageSwitch } from './components/LanguageSwitch';
import { useScrollRestoration } from './hooks/useScrollRestoration';
import { useFavorites } from './hooks/useFavorites';
import { Home, Heart } from 'lucide-react';

type ViewMode = 'persona-home' | 'persona-detail' | 'inspiration-browse' | 'inspiration-detail' | 'goal-detail' | 'favorites' | 'tools-explorer' | 'creative-use-cases' | 'learn';

function AppContent() {
  const { i18n } = useTranslation();
  const [viewMode, setViewMode] = useState<ViewMode>('persona-home');
  const [selectedPersona, setSelectedPersona] = useState<string | null>(null);
  const [selectedPersonaName, setSelectedPersonaName] = useState<string | null>(null);
  const [selectedGoal, setSelectedGoal] = useState<string | null>(null);
  const [selectedInspiration, setSelectedInspiration] = useState<string | null>(null);
  const [pendingFilters, setPendingFilters] = useState<any>(null);
  const { getFavoriteCount } = useFavorites();

  const language = i18n.language as 'en' | 'zh-TW';

  useScrollRestoration(`app-${viewMode}-${selectedPersona || ''}-${selectedGoal || ''}-${selectedInspiration || ''}`);

  const handlePersonaSelect = (personaKey: string, personaName?: string) => {
    setSelectedPersona(personaKey);
    if (personaName) {
      setSelectedPersonaName(personaName);
    }
    setViewMode('persona-detail');
  };

  const handleInspirationSelect = (inspirationKey: string) => {
    setSelectedInspiration(inspirationKey);
    setViewMode('inspiration-detail');
  };

  const handleBrowseAllInspirations = () => {
    setViewMode('inspiration-browse');
  };

  const handleBackToHome = () => {
    window.scrollTo(0, 0);
    setViewMode('persona-home');
    setSelectedPersona(null);
    setSelectedPersonaName(null);
    setSelectedGoal(null);
    setSelectedInspiration(null);
  };

  const handleBackToPersona = () => {
    if (selectedPersona) {
      setViewMode('persona-detail');
      setSelectedGoal(null);
    } else {
      handleBackToHome();
    }
  };

  const handleGoalSelect = (goalKey: string) => {
    setSelectedGoal(goalKey);
    setViewMode('goal-detail');
  };

  const handleFavoritesClick = () => {
    setViewMode('favorites');
  };

  const handleNavigateToTools = (filters?: any) => {
    setPendingFilters(filters || null);
    setViewMode('tools-explorer');
  };

  const handleNavigateToUseCases = () => {
    setViewMode('creative-use-cases');
  };

  const handleNavigateToLearn = () => {
    setViewMode('learn');
  };

  return (
    <div className="min-h-screen">
      <div className="fixed top-4 right-4 z-50 flex items-center gap-2">
        {viewMode !== 'persona-home' && (
          <button
            onClick={handleBackToHome}
            className="p-2 bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow text-gray-700 hover:text-blue-600"
            title={language === 'zh-TW' ? '返回首頁' : 'Back to Home'}
          >
            <Home className="w-5 h-5" />
          </button>
        )}
        <button
          onClick={handleFavoritesClick}
          className="p-2 bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow text-gray-700 hover:text-pink-600 relative"
          title={language === 'zh-TW' ? '我的收藏' : 'My Favorites'}
        >
          <Heart className={`w-5 h-5 ${
            getFavoriteCount() > 0 ? 'fill-pink-500 text-pink-500' : ''
          }`} />
          {getFavoriteCount() > 0 && (
            <span className="absolute -top-1 -right-1 bg-pink-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center font-semibold">
              {getFavoriteCount()}
            </span>
          )}
        </button>
        <LanguageSwitch />
      </div>

      {viewMode === 'persona-home' && (
        <PersonaHomePage
          language={language}
          onPersonaSelect={handlePersonaSelect}
          onInspirationSelect={handleInspirationSelect}
          onBrowseAllInspirations={handleBrowseAllInspirations}
          onNavigateToTools={handleNavigateToTools}
          onNavigateToUseCases={handleNavigateToUseCases}
          onNavigateToLearn={handleNavigateToLearn}
        />
      )}

      {viewMode === 'persona-detail' && selectedPersona && (
        <PersonaDetailPage
          language={language}
          personaKey={selectedPersona}
          onBackToHome={handleBackToHome}
          onGoalSelect={handleGoalSelect}
        />
      )}

      {viewMode === 'inspiration-browse' && (
        <InspirationBrowsePage
          language={language}
          onInspirationSelect={handleInspirationSelect}
          onBackToHome={handleBackToHome}
        />
      )}

      {viewMode === 'inspiration-detail' && selectedInspiration && (
        <InspirationDetailPage
          language={language}
          inspirationKey={selectedInspiration}
          onBackToHome={handleBackToHome}
          onBackToBrowse={() => setViewMode('inspiration-browse')}
        />
      )}

      {viewMode === 'goal-detail' && selectedGoal && (
        <GoalDetailPage
          language={language}
          goalKey={selectedGoal}
          onBackToHome={handleBackToHome}
          onBackToPersona={selectedPersona ? handleBackToPersona : undefined}
          onInspirationSelect={handleInspirationSelect}
          onPersonaSelect={handlePersonaSelect}
          selectedPersonaName={selectedPersonaName || undefined}
        />
      )}

      {viewMode === 'favorites' && (
        <FavoritesPage
          language={language}
          onBackToHome={handleBackToHome}
          onGoalSelect={handleGoalSelect}
          onInspirationSelect={handleInspirationSelect}
        />
      )}

      {viewMode === 'tools-explorer' && (
        <ToolsExplorerPage
          language={language}
          onBackToHome={handleBackToHome}
          initialFilters={pendingFilters}
        />
      )}

      {viewMode === 'creative-use-cases' && (
        <CreativeUseCasesPage
          language={language}
          onBackToHome={handleBackToHome}
          onNavigateToTools={handleNavigateToTools}
        />
      )}

      {viewMode === 'learn' && (
        <LearnPage
          language={language}
          onBackToHome={handleBackToHome}
        />
      )}
    </div>
  );
}

function App() {
  return (
    <AppProvider>
      <AppContent />
    </AppProvider>
  );
}

export default App;
