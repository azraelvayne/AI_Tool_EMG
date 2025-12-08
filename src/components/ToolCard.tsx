import React from 'react';
import { ExternalLink, Star, Layers, Database, ArrowRight } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Badge } from './ui/Badge';
import { Card } from './ui/Card';
import type { Tool } from '../types';
import { useFavorites } from '../hooks/useFavorites';

interface ToolCardProps {
  tool: Tool;
  viewMode?: 'grid' | 'list';
  onClick?: (tool: Tool) => void;
}

export function ToolCard({ tool, viewMode = 'grid', onClick }: ToolCardProps) {
  const { t, i18n } = useTranslation();
  const { isFavorite, toggleFavorite } = useFavorites();
  const isFav = isFavorite(tool.id);

  // 🛡️ 關鍵防護：確保 categories 不為 null
  const categories = tool.categories || {
    functional_role: [],
    tech_layer: [],
    application_field: [],
    purpose: [],
    difficulty: 'intermediate'
  };

  const displayName = i18n.language === 'zh-TW' 
    ? (tool as any).tool_name_zh || tool.tool_name 
    : tool.tool_name;

  const displayDesc = i18n.language === 'zh-TW' 
    ? (tool as any).tool_description_zh || tool.tool_description 
    : tool.tool_description;

  const functionalRoles = Array.isArray(categories.functional_role) 
    ? categories.functional_role.slice(0, 2) 
    : [];

  const handleCardClick = (e: React.MouseEvent) => {
    if ((e.target as HTMLElement).closest('button') || (e.target as HTMLElement).closest('a')) {
      return;
    }
    onClick?.(tool);
  };

  if (viewMode === 'grid') {
    return (
      <Card 
        className="group hover:shadow-xl transition-all duration-300 h-full flex flex-col border-gray-200 hover:border-blue-300 bg-white cursor-pointer"
        onClick={handleCardClick}
      >
        <div className="p-6 flex flex-col h-full relative">
          <div className="flex justify-between items-start mb-4">
            <div className="flex items-center gap-4">
              <div className="w-14 h-14 rounded-xl bg-gradient-to-br from-gray-50 to-gray-100 p-2.5 border border-gray-200 shadow-sm group-hover:scale-105 transition-transform duration-300">
                {tool.logo_url ? (
                  <img 
                    src={tool.logo_url} 
                    alt={displayName} 
                    className="w-full h-full object-contain"
                    onError={(e) => {
                      (e.target as HTMLImageElement).style.display = 'none';
                      (e.target as HTMLImageElement).nextElementSibling?.classList.remove('hidden');
                    }}
                  />
                ) : null}
                <div className={`w-full h-full flex items-center justify-center ${tool.logo_url ? 'hidden' : ''}`}>
                  <Database className="w-6 h-6 text-gray-400" />
                </div>
              </div>
              <div>
                <h3 className="font-bold text-lg text-gray-900 group-hover:text-blue-600 transition-colors line-clamp-1">
                  {displayName}
                </h3>
                <div className="flex flex-wrap gap-2 mt-1.5">
                  {functionalRoles.map((role, idx) => (
                    <span key={idx} className="text-xs px-2 py-0.5 rounded-full bg-slate-100 text-slate-600 font-medium">
                      {role}
                    </span>
                  ))}
                </div>
              </div>
            </div>
            <button
              onClick={(e) => {
                e.stopPropagation();
                toggleFavorite(tool.id);
              }}
              className={`p-2 rounded-full transition-all ${isFav ? 'text-red-500 bg-red-50' : 'text-gray-300 hover:text-red-500'}`}
            >
              <Star className={`w-5 h-5 ${isFav ? 'fill-current' : ''}`} />
            </button>
          </div>
          <p className="text-gray-600 text-sm leading-relaxed mb-6 line-clamp-3 flex-grow">
            {displayDesc || t('tools.no_description')}
          </p>
          <div className="flex items-center justify-between pt-4 border-t border-gray-100 mt-auto">
            <div className="flex gap-2">
              {(categories.tech_layer || []).slice(0, 1).map((layer: string, i: number) => (
                <Badge key={i} className="bg-indigo-50 text-indigo-700 border-indigo-100 text-xs px-2 py-1">
                  <Layers className="w-3 h-3 mr-1" />
                  {layer}
                </Badge>
              ))}
            </div>
            {tool.website_url && (
              <a
                href={tool.website_url}
                target="_blank"
                rel="noopener noreferrer"
                onClick={(e) => e.stopPropagation()}
                className="text-gray-400 hover:text-blue-600 transition-colors p-1"
              >
                <ExternalLink className="w-4 h-4" />
              </a>
            )}
          </div>
        </div>
      </Card>
    );
  }

  return null; // List mode 暫略
}