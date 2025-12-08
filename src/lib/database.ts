import { supabase } from './supabase';
import type { Tool, CreativeUseCase } from '../types';

export const db = {
  async getTools(lang: 'en' | 'zh-TW' = 'en'): Promise<Tool[]> {
    return getToolsWithTranslations(lang);
  },

  async getCreativeUseCases(lang: 'en' | 'zh-TW' = 'en'): Promise<CreativeUseCase[]> {
    try {
      const { data, error } = await supabase
        .from('creative_use_cases')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;
      
      // 處理資料轉換
      return (data || []).map(item => ({
        ...item,
        workflow_steps: typeof item.workflow_steps === 'string' 
          ? JSON.parse(item.workflow_steps) 
          : item.workflow_steps
      }));
    } catch (error) {
      console.error('Error fetching creative use cases:', error);
      return [];
    }
  },

  async toggleFavorite(toolId: string) {
    // 實作待補，目前由前端 localStorage 處理
    return true;
  }
};

// 獨立的函式，用於取得工具並處理翻譯與資料清洗
export async function getToolsWithTranslations(lang: 'en' | 'zh-TW' = 'en'): Promise<Tool[]> {
  try {
    // 1. 取得所有工具
    const { data: tools, error: toolsError } = await supabase
      .from('tools')
      .select('*')
      .order('tool_name');

    if (toolsError) throw toolsError;
    if (!tools) return [];

    // 2. 取得翻譯 (如果是中文模式)
    let translationsMap = new Map();
    if (lang === 'zh-TW') {
      const { data: translations, error: transError } = await supabase
        .from('tool_translations')
        .select('*')
        .eq('language_code', 'zh-TW');

      if (!transError && translations) {
        translations.forEach(t => translationsMap.set(t.tool_id, t));
      }
    }

    // 3. 合併資料並進行「資料清洗 (Data Cleaning)」
    const processedTools = tools.map(tool => {
      const translation = translationsMap.get(tool.id);
      
      // 🚨 關鍵修復：如果 categories 是 null，給它一個預設安全物件
      // 這就是防止白屏的核心邏輯
      const safeCategories = tool.categories || {
        functional_role: [],
        tech_layer: [],
        application_field: [],
        purpose: [],
        difficulty: 'intermediate',
        common_pairings: []
      };

      return {
        ...tool,
        // 強制覆蓋 categories，確保它永遠不會是 null
        categories: safeCategories, 
        
        // 處理翻譯
        tool_name: translation?.name || tool.tool_name,
        tool_description: translation?.short_description || tool.tool_description,
        
        // 保留原始中文欄位供 ToolCard 備用
        tool_name_zh: translation?.name, 
        tool_description_zh: translation?.short_description
      };
    });

    return processedTools;
  } catch (error) {
    console.error('Error fetching tools:', error);
    return []; // 發生錯誤時回傳空陣列，而不是讓程式崩潰
  }
}