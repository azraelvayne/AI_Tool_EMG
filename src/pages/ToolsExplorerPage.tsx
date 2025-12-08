import { useEffect } from 'react';
import { ToolsExplorerLayout } from '../components/ToolsExplorerLayout';
import { useApp } from '../contexts/AppContext';
import type { NavigationFilters } from '../types';
import { ErrorBoundary } from '../components/ErrorBoundary'; // 1. 引入錯誤邊界元件

interface ToolsExplorerPageProps {
  language: 'en' | 'zh-TW';
  onBackToHome: () => void;
  initialFilters?: NavigationFilters | any;
}

export function ToolsExplorerPage({ initialFilters }: ToolsExplorerPageProps) {
  const { setFilters, setToolNames, filters } = useApp();

  useEffect(() => {
    if (initialFilters) {
      if ('tools' in initialFilters && Array.isArray(initialFilters.tools)) {
        setToolNames(initialFilters.tools);
        setFilters({
          purpose: [],
          functional_role: [],
          tech_layer: [],
          data_flow_role: [],
          difficulty: [],
          application_field: []
        });
      } else if ('filters' in initialFilters) {
        setToolNames([]);
        setFilters({
          ...filters,
          ...initialFilters.filters
        });
      } else {
        setToolNames([]);
        setFilters(initialFilters);
      }
    } else {
      setToolNames([]);
      setFilters({
        purpose: [],
        functional_role: [],
        tech_layer: [],
        data_flow_role: [],
        difficulty: [],
        application_field: []
      });
    }
  }, [initialFilters]);

  // 2. 用 ErrorBoundary 包住回傳的元件
  return (
    <ErrorBoundary>
      <ToolsExplorerLayout />
    </ErrorBoundary>
  );
}