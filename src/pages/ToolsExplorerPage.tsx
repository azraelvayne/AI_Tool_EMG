import { useEffect } from 'react';
import { ToolsExplorerLayout } from '../components/ToolsExplorerLayout';
import { useApp } from '../contexts/AppContext';
import type { NavigationFilters } from '../types';

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
    }
  }, [initialFilters]);

  return <ToolsExplorerLayout />;
}
