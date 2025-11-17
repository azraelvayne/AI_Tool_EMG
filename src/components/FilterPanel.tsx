import { X } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Button } from './ui/Button';
import type { FilterType } from '../types';
import { useApp } from '../contexts/AppContext';
import * as Icons from 'lucide-react';

interface FilterPanelProps {
  onClose?: () => void;
  mobile?: boolean;
}

export function FilterPanel({ onClose, mobile = false }: FilterPanelProps) {
  const { t } = useTranslation();
  const { filters, setFilters, categories, getTranslatedCategoryValue } = useApp();

  const getIcon = (iconName: string) => {
    if (!iconName) return Icons.Box;
    const IconComponent = (Icons as any)[iconName.split('-').map((word: string, i: number) =>
      i === 0 ? word : word.charAt(0).toUpperCase() + word.slice(1)
    ).join('')];
    return IconComponent || Icons.Box;
  };

  const toggleFilter = (type: FilterType, value: string) => {
    setFilters({
      ...filters,
      [type]: filters[type].includes(value)
        ? filters[type].filter(v => v !== value)
        : [...filters[type], value]
    });
  };

  const clearAllFilters = () => {
    setFilters({
      purpose: [],
      functional_role: [],
      tech_layer: [],
      data_flow_role: [],
      difficulty: [],
      application_field: []
    });
  };

  const hasActiveFilters = Object.values(filters).some(f =>
    Array.isArray(f) ? f.length > 0 : f !== ''
  );

  const renderFilterSection = (title: string, type: FilterType) => {
    const sectionCategories = categories
      .filter(c => c.category_type === type)
      .sort((a, b) => a.display_order - b.display_order);

    if (sectionCategories.length === 0) return null;

    return (
      <div className="mb-6">
        <h3 className="text-sm font-semibold text-gray-900 mb-3">{title}</h3>
        <div className="flex flex-wrap gap-2">
          {sectionCategories.map((category) => {
            const Icon = getIcon(category.icon_name);
            const isActive = filters[type].includes(category.category_value);
            return (
              <button
                key={category.id}
                onClick={() => toggleFilter(type, category.category_value)}
                className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-sm font-medium transition-all ${
                  isActive
                    ? 'shadow-sm scale-105'
                    : 'opacity-70 hover:opacity-100'
                }`}
                style={{
                  backgroundColor: isActive ? category.color_hex : category.color_hex + '20',
                  color: isActive ? 'white' : category.color_hex,
                  border: `1px solid ${category.color_hex}`
                }}
              >
                <Icon size={14} />
                {getTranslatedCategoryValue(category.category_value)}
              </button>
            );
          })}
        </div>
      </div>
    );
  };

  return (
    <div className={`bg-white ${mobile ? '' : 'border-r border-gray-200'} h-full overflow-y-auto`}>
      <div className="p-6">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-lg font-bold text-gray-900">{t('filter.title')}</h2>
          {mobile && onClose && (
            <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg">
              <X size={20} />
            </button>
          )}
        </div>

        {hasActiveFilters && (
          <Button
            variant="outline"
            size="sm"
            onClick={clearAllFilters}
            className="w-full mb-6"
          >
            {t('filter.clear_all')}
          </Button>
        )}

        {renderFilterSection(t('filter.purpose'), 'purpose')}
        {renderFilterSection(t('filter.functional_role'), 'functional_role')}
        {renderFilterSection(t('filter.tech_layer'), 'tech_layer')}
        {renderFilterSection(t('filter.data_flow'), 'data_flow_role')}
        {renderFilterSection(t('filter.difficulty'), 'difficulty')}
        {renderFilterSection(t('filter.application_field'), 'application_field')}
      </div>
    </div>
  );
}
