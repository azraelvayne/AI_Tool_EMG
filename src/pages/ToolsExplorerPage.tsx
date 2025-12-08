import { useEffect, useCallback } from 'react';
import { ToolsExplorerLayout } from '../components/ToolsExplorerLayout';
import { useApp } from '../contexts/AppContext';
import type { NavigationFilters } from '../types';
import { ErrorBoundary } from '../components/ErrorBoundary';

interface ToolsExplorerPageProps {
  language: 'en' | 'zh-TW';
  onBackToHome: () => void;
  initialFilters?: NavigationFilters | any;
}

export function ToolsExplorerPage({ initialFilters }: ToolsExplorerPageProps) {
  const { setFilters, setToolNames } = useApp();

  const applyFilters = useCallback(() => {
    if (initialFilters) {
      if ('tools' in initialFilters && Array.isArray(initialFilters.tools)) {
        const validTools = initialFilters.tools.filter((t: any) => t && typeof t === 'string');
        setToolNames(validTools);
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
          purpose: [],
          functional_role: [],
          tech_layer: [],
          data_flow_role: [],
          difficulty: [],
          application_field: [],
          ...initialFilters.filters
        });
      } else {
        setToolNames([]);
        setFilters({
          purpose: [],
          functional_role: [],
          tech_layer: [],
          data_flow_role: [],
          difficulty: [],
          application_field: [],
          ...initialFilters
        });
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
  }, [initialFilters, setFilters, setToolNames]);

  useEffect(() => {
    applyFilters();
  }, [applyFilters]);

  // 2. 用 ErrorBoundary 包住回傳的元件
  return (
    <ErrorBoundary>
      <ToolsExplorerLayout />
    </ErrorBoundary>
  );
}