import React from 'react';
import { ExternalLink, Star, GitBranch, Layers, ArrowRight, Activity, Database, Layout } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Badge } from './ui/Badge';
import { Button } from './ui/Button';
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

  // 🛡️ 防護措施：確保 categories 永遠不為 null
  // 就算資料庫漏填，這裡也會給一個安全的預設值，防止白屏
  const categories = tool.categories || {
    functional_role: [],
    tech_layer: [],
    application_field: [],
    purpose: [],
    difficulty: 'intermediate'
  };

  // 取得顯示用的名稱與描述 (處理多語言)
  const displayName = i18n.language === 'zh-TW' 
    ? (tool as any).tool_name_zh || tool.tool_name 
    : tool.tool_name;

  const displayDesc = i18n.language === 'zh-TW' 
    ? (tool as any).tool_description_zh || tool.tool_description 
    : tool.tool_description;

  // 取得功能角色 (Functional Roles) - 最多顯示 2 個
  const functionalRoles = Array.isArray(categories.functional_role) 
    ? categories.functional_role.slice(0, 2) 
    : [];

  const handleCardClick = (e: React.MouseEvent) => {
    // 避免點擊到收藏按鈕或連結時觸發 Modal
    if ((e.target as HTMLElement).closest('button') || (e.target as HTMLElement).closest('a')) {
      return;
    }
    onClick?.(tool);
  };

  // 根據分類給予顏色標籤
  const getRoleColor = (role: string) => {
    const colors: Record<string, string> = {
      'generation': 'bg-blue-100 text-blue-700 border-blue-200',
      'processing': 'bg-purple-100 text-purple-700 border-purple-200',
      'orchestration': 'bg-orange-100 text-orange-700 border-orange-200',
      'storage': 'bg-green-100 text-green-700 border-green-200',
      'interface': 'bg-pink-100 text-pink-700 border-pink-200'
    };
    return colors[role.toLowerCase()] || 'bg-gray-100 text-gray-700 border-gray-200';
  };

  // 格狀檢視 (Grid View)
  if (viewMode === 'grid') {
    return (
      <Card 
        className="group hover:shadow-xl transition-all duration-300 h-full flex flex-col border-gray-200 hover:border-blue-300 bg-white overflow-hidden cursor-pointer"
        onClick={handleCardClick}
      >
        <div className="p-6 flex flex-col h-full relative">
          {/* 頭部：圖示與標題 */}
          <div className="flex justify-between items-start mb-4">
            <div className="flex items-center gap-4">
              <div className="w-14 h-14 rounded-xl bg-gradient-to-br from-gray-50 to-gray-100 p-2.5 border border-gray-200 shadow-sm group-hover:scale-105 transition-transform duration-300">
                {tool.logo_url ? (
                  <img 
                    src={tool.logo_url} 
                    alt={displayName} 
                    className="w-full h-full object-contain"
                    onError={(e) => {
                      // 圖片載入失敗時顯示預設圖示
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
                <h3 className="font-bold text-lg text-gray-900 group-hover:text-blue-600 transition-colors line-clamp-1" title={displayName}>
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
              className={`p-2 rounded-full transition-all ${
                isFav 
                  ? 'text-red-500 bg-red-50 hover:bg-red-100' 
                  : 'text-gray-300 hover:text-red-500 hover:bg-gray-50'
              }`}
            >
              <Star className={`w-5 h-5 ${isFav ? 'fill-current' : ''}`} />
            </button>
          </div>

          {/* 描述 */}
          <p className="text-gray-600 text-sm leading-relaxed mb-6 line-clamp-3 flex-grow">
            {displayDesc || t('tools.no_description')}
          </p>

          {/* 底部資訊列 */}
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
                title={t('tools.visit_website')}
              >
                <ExternalLink className="w-4 h-4" />
              </a>
            )}
          </div>
        </div>
      </Card>
    );
  }

  // 列表檢視 (List View)
  return (
    <Card 
      className="group hover:shadow-md transition-all duration-200 border-gray-200 hover:border-blue-300 bg-white cursor-pointer"
      onClick={handleCardClick}
    >
      <div className="p-4 flex items-center gap-6">
        {/* Logo */}
        <div className="w-12 h-12 rounded-lg bg-gray-50 p-2 border border-gray-200 flex-shrink-0">
          {tool.logo_url ? (
            <img src={tool.logo_url} alt={displayName} className="w-full h-full object-contain" />
          ) : (
            <div className="w-full h-full flex items-center justify-center">
              <Database className="w-5 h-5 text-gray-400" />
            </div>
          )}
        </div>

        {/* 內容 */}
        <div className="flex-grow min-w-0 grid grid-cols-12 gap-6 items-center">
          <div className="col-span-4">
            <h3 className="font-bold text-gray-900 group-hover:text-blue-600 truncate">{displayName}</h3>
            <p className="text-xs text-gray-500 truncate mt-0.5">{displayDesc}</p>
          </div>

          <div className="col-span-3 flex gap-2">
            {functionalRoles.map((role, idx) => (
              <Badge key={idx} className="bg-slate-50 text-slate-600 border-slate-200 text-xs truncate">
                {role}
              </Badge>
            ))}
          </div>

          <div className="col-span-3 flex gap-2">
            {(categories.tech_layer || []).slice(0, 1).map((layer: string, i: number) => (
              <Badge key={i} className="bg-indigo-50 text-indigo-600 border-indigo-100 text-xs">
                {layer}
              </Badge>
            ))}
          </div>
          
          <div className="col-span-2 flex justify-end gap-2">
             <button
              onClick={(e) => {
                e.stopPropagation();
                toggleFavorite(tool.id);
              }}
              className={`p-2 rounded-full transition-all ${
                isFav ? 'text-red-500 bg-red-50' : 'text-gray-300 hover:text-red-500'
              }`}
            >
              <Star className={`w-4 h-4 ${isFav ? 'fill-current' : ''}`} />
            </button>
            {tool.website_url && (
              <a
                href={tool.website_url}
                target="_blank"
                rel="noopener noreferrer"
                onClick={(e) => e.stopPropagation()}
                className="p-2 text-gray-400 hover:text-blue-600 transition-colors"
              >
                <ExternalLink className="w-4 h-4" />
              </a>
            )}
          </div>
        </div>
      </div>
    </Card>
  );
}