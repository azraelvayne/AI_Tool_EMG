import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Button } from '../components/ui/Button';
import { LanguageSwitch } from '../components/LanguageSwitch';
import { AboutModal } from '../components/AboutModal';
import { AIRecommendationModal } from '../components/AIRecommendationModal';
import { ToolsExplorerLayout } from '../components/ToolsExplorerLayout';
import { useApp } from '../contexts/AppContext';

export function HomePage() {
  const { t } = useTranslation();
  const { tools } = useApp();
  const [showAbout, setShowAbout] = useState(false);
  const [showAIRecommendation, setShowAIRecommendation] = useState(false);

  return (
    <>
      <ToolsExplorerLayout
        title={t('home.title')}
        subtitle={t('home.subtitle')}
        showAIButton={true}
        onAIClick={() => setShowAIRecommendation(true)}
        headerActions={
          <div className="flex gap-3">
            <Button
              variant="ghost"
              size="sm"
              className="text-white hover:bg-white/10"
              onClick={() => setShowAbout(true)}
            >
              {t('home.learn_more')}
            </Button>
            <LanguageSwitch />
          </div>
        }
      />

      <AboutModal
        isOpen={showAbout}
        onClose={() => setShowAbout(false)}
      />

      <AIRecommendationModal
        isOpen={showAIRecommendation}
        onClose={() => setShowAIRecommendation(false)}
        allTools={tools}
        onApplyStack={() => {
          setShowAIRecommendation(false);
        }}
      />
    </>
  );
}
