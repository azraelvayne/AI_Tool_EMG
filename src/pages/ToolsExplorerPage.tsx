import { useEffect } from 'react';
import { ToolsExplorerLayout } from '../components/ToolsExplorerLayout';
import { useApp } from '../contexts/AppContext';

interface ToolsExplorerPageProps {
  language: 'en' | 'zh-TW';
  onBackToHome: () => void;
  initialFilters?: any;
}

export function ToolsExplorerPage({ initialFilters }: ToolsExplorerPageProps) {
  const { setFilters } = useApp();

  useEffect(() => {
    if (initialFilters) {
      setFilters(initialFilters);
    }
  }, [initialFilters, setFilters]);

  return <ToolsExplorerLayout />;
}
