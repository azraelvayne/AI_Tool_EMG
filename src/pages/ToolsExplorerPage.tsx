import { useTranslation } from 'react-i18next';
import { ToolsExplorerLayout } from '../components/ToolsExplorerLayout';
import { PageTransition } from '../components/animations/PageTransition';

interface ToolsExplorerPageProps {
  language: 'en' | 'zh-TW';
  onBackToHome: () => void;
}

export function ToolsExplorerPage({ language, onBackToHome }: ToolsExplorerPageProps) {
  const { t } = useTranslation();

  return (
    <PageTransition>
      <ToolsExplorerLayout
        title={t('tools.explorer_title')}
        subtitle={t('tools.explorer_subtitle')}
        showAIButton={true}
        onAIClick={() => {}}
      />
    </PageTransition>
  );
}
