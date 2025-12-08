import { Star, Sparkles, ArrowRight } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Card, CardHeader, CardBody } from './ui/Card';
import { Badge } from './ui/Badge';
import type { Tool, CategoryMetadata } from '../types';
import { useApp } from '../contexts/AppContext';
import { storage } from '../lib/localStorage';
import { db } from '../lib/database';
import * as Icons from 'lucide-react';

interface ToolCardProps {
  tool: Tool;
  categories: CategoryMetadata[];
  onClick?: () => void;
}

export function ToolCard({ tool, categories, onClick }: ToolCardProps) {
  const { t } = useTranslation();
  const { favorites, toggleFavorite, getTranslatedCategoryValue } = useApp();
  const isFavorited = favorites.includes(tool.id || '');

  const handleClick = async () => {
    if (tool.id) {
      const sessionId = storage.generateSessionId();
      await db.trackView(tool.id, sessionId);
    }
    onClick?.();
  };

  const handleFavoriteClick = async (e: React.MouseEvent) => {
    e.stopPropagation();
    if (tool.id) {
      const sessionId = storage.generateSessionId();
      await db.trackFavoriteAction(tool.id, sessionId);
    }
    toggleFavorite(tool.id || '');
  };

  const getCategoryMetadata = (categoryType: string, value: string) => {
    return categories.find(c => c.category_type === categoryType && c.category_value === value);
  };

  const getIcon = (iconName: string) => {
    const IconComponent = (Icons as any)[iconName.split('-').map((word: string, i: number) =>
      i === 0 ? word : word.charAt(0).toUpperCase() + word.slice(1)
    ).join('')];
    return IconComponent || Icons.Box;
  };

  const toolCategories = tool.categories || {
    functional_role: [],
    tech_layer: [],
    difficulty: null,
    common_pairings: []
  };
  const primaryRole = (toolCategories as any).functional_role?.[0];
  const roleMetadata = primaryRole ? getCategoryMetadata('functional_role', primaryRole) : null;
  const RoleIcon = roleMetadata ? getIcon(roleMetadata.icon_name) : Icons.Box;

  return (
    <Card hover onClick={handleClick} className="relative overflow-hidden">
      <CardHeader className="flex items-start justify-between">
        <div className="flex-1">
          <div className="flex items-center gap-3 mb-2">
            <div
              className="w-12 h-12 rounded-lg flex items-center justify-center bg-white border border-gray-200 p-2"
            >
              {tool.icon_url ? (
                <img
                  src={tool.icon_url}
                  alt={`${tool.tool_name} icon`}
                  className="w-full h-full object-contain"
                  onError={(e) => {
                    e.currentTarget.style.display = 'none';
                    e.currentTarget.nextElementSibling?.classList.remove('hidden');
                  }}
                />
              ) : null}
              <RoleIcon
                size={24}
                style={{ color: roleMetadata?.color_hex }}
                className={tool.icon_url ? 'hidden' : ''}
              />
            </div>
            <div className="flex-1">
              <h3 className="text-lg font-bold text-gray-900 mb-1">{tool.tool_name}</h3>
              {tool.is_verified && (
                <Badge color="#10B981" icon={Sparkles} size="sm">
                  {t('tool.verified')}
                </Badge>
              )}
            </div>
          </div>
          <p className="text-sm text-gray-600 line-clamp-2">{tool.summary}</p>
        </div>
        <button
          onClick={handleFavoriteClick}
          className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
        >
          <Star
            size={20}
            className={isFavorited ? 'fill-yellow-400 text-yellow-400' : 'text-gray-400'}
          />
        </button>
      </CardHeader>

      <CardBody>
        <div className="flex flex-wrap gap-2 mb-3">
          {((toolCategories as any).functional_role || []).slice(0, 2).map((role: string) => {
            const metadata = getCategoryMetadata('functional_role', role);
            const Icon = metadata ? getIcon(metadata.icon_name) : undefined;
            return (
              <Badge key={role} color={metadata?.color_hex} icon={Icon} size="sm">
                {getTranslatedCategoryValue(role)}
              </Badge>
            );
          })}
          {((toolCategories as any).tech_layer || [])[0] && (() => {
            const metadata = getCategoryMetadata('tech_layer', (toolCategories as any).tech_layer[0]);
            const Icon = metadata ? getIcon(metadata.icon_name) : undefined;
            return (
              <Badge color={metadata?.color_hex} icon={Icon} size="sm">
                {getTranslatedCategoryValue((toolCategories as any).tech_layer[0])}
              </Badge>
            );
          })()}
          {(toolCategories as any).difficulty && (() => {
            const metadata = getCategoryMetadata('difficulty', (toolCategories as any).difficulty);
            const Icon = metadata ? getIcon(metadata.icon_name) : undefined;
            return (
              <Badge color={metadata?.color_hex} icon={Icon} size="sm">
                {getTranslatedCategoryValue((toolCategories as any).difficulty)}
              </Badge>
            );
          })()}
        </div>

        {((toolCategories as any).common_pairings || []).length > 0 && (
          <div className="text-xs text-gray-500 mt-2">
            {t('tool.pairs_with')}: {(toolCategories as any).common_pairings.slice(0, 3).join(', ')}
          </div>
        )}
      </CardBody>

      <div className="absolute bottom-4 right-4 text-blue-600 opacity-0 group-hover:opacity-100 transition-opacity">
        <ArrowRight size={20} />
      </div>
    </Card>
  );
}
