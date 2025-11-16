/*
  # Update Tool Pairings with Comprehensive Data (v1.1)

  ## Overview
  This migration populates/updates the tool_pairings table with comprehensive data.
  Strength scale: 1-10 (where 10 is strongest integration)
  
  ## Changes
  - Maps tool slugs to IDs safely
  - Inserts new pairings with detailed rationale
  - Updates existing pairings to add rationale where missing
  - Uses proper strength scale (1-10)

  ## Data Coverage
  - AI Models + Automation (strongest: 9-10)
  - AI Models + LLM Orchestration (8-10)
  - Database + No-Code (7-10)
  - Design + Complementary (6-9)
  - Alternative tools (6-8)
*/

-- Temporary function to safely get tool ID by slug
CREATE OR REPLACE FUNCTION get_tool_id_by_slug(slug_param text)
RETURNS uuid AS $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE source_slug = slug_param LIMIT 1;
  RETURN tool_uuid;
END;
$$ LANGUAGE plpgsql;

-- Insert AI Models + Automation Platform pairings
DO $$
BEGIN
  -- OpenAI + n8n
  IF get_tool_id_by_slug('openai') IS NOT NULL AND get_tool_id_by_slug('n8n') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('openai'),
      get_tool_id_by_slug('n8n'),
      'integrates_with',
      10,
      'n8n 提供 OpenAI 官方節點，支援所有 GPT 模型（GPT-4、GPT-3.5）和功能（文字生成、嵌入向量、圖像生成）。完整支援串流回應和函數呼叫，是最常用的自動化整合方案之一。',
      'very_high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength,
        pairing_frequency = EXCLUDED.pairing_frequency;
  END IF;

  -- OpenAI + Zapier
  IF get_tool_id_by_slug('openai') IS NOT NULL AND get_tool_id_by_slug('zapier') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('openai'),
      get_tool_id_by_slug('zapier'),
      'integrates_with',
      9,
      'Zapier 提供 OpenAI 整合，可在 5000+ 個應用中使用 GPT 模型。常見場景包括自動回覆郵件、生成社群媒體內容、分析客戶回饋等，無需程式碼即可快速建立。',
      'very_high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- OpenAI + Make
  IF get_tool_id_by_slug('openai') IS NOT NULL AND get_tool_id_by_slug('make') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('openai'),
      get_tool_id_by_slug('make'),
      'integrates_with',
      9,
      'Make (Integromat) 提供視覺化的 OpenAI 整合模組，支援文字生成、語音轉文字、圖像生成等功能。視覺化流程設計讓複雜的 AI 工作流程更容易理解和維護。',
      'high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- Anthropic + n8n  
  IF get_tool_id_by_slug('anthropic') IS NOT NULL AND get_tool_id_by_slug('n8n') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('anthropic'),
      get_tool_id_by_slug('n8n'),
      'integrates_with',
      9,
      'n8n 支援 Anthropic Claude 整合，可使用 Claude 3 系列模型。Claude 以長上下文處理和安全性著稱，適合處理大量文件分析和複雜推理任務。',
      'high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- OpenAI + Langflow
  IF get_tool_id_by_slug('openai') IS NOT NULL AND get_tool_id_by_slug('langflow') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('openai'),
      get_tool_id_by_slug('langflow'),
      'integrates_with',
      10,
      'Langflow 原生支援 OpenAI 模型，提供拖放式介面建立 LLM 工作流程。可視覺化設計 prompt chain、記憶體管理和工具呼叫，是建立複雜 AI 代理的最佳選擇。',
      'very_high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- OpenAI + Flowise
  IF get_tool_id_by_slug('openai') IS NOT NULL AND get_tool_id_by_slug('flowise') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('openai'),
      get_tool_id_by_slug('flowise'),
      'integrates_with',
      9,
      'Flowise 完整支援 OpenAI 所有模型和功能，包括 GPT-4 Vision、函數呼叫、助理 API。低程式碼介面讓非技術人員也能建立進階 AI 應用。',
      'very_high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- Supabase + n8n
  IF get_tool_id_by_slug('supabase') IS NOT NULL AND get_tool_id_by_slug('n8n') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('supabase'),
      get_tool_id_by_slug('n8n'),
      'integrates_with',
      9,
      'n8n 提供 Supabase 官方節點，支援資料庫操作、即時訂閱和認證功能。可建立完整的後端自動化流程，包括資料同步、觸發器和 webhook 整合。',
      'very_high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- Supabase + Bubble
  IF get_tool_id_by_slug('supabase') IS NOT NULL AND get_tool_id_by_slug('bubble') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('supabase'),
      get_tool_id_by_slug('bubble'),
      'integrates_with',
      9,
      'Bubble.io 可透過 API 連接器整合 Supabase，作為強大的後端資料庫。Supabase 的即時功能和 Bubble 的前端設計能力結合，可快速建立全端應用。',
      'high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- Airtable + Softr
  IF get_tool_id_by_slug('airtable') IS NOT NULL AND get_tool_id_by_slug('softr') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('airtable'),
      get_tool_id_by_slug('softr'),
      'integrates_with',
      10,
      'Softr 原生整合 Airtable，可直接將 Airtable 資料庫轉換為精美網站或應用。無需程式碼即可建立客戶入口、內部工具或內容管理系統。',
      'very_high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- Airtable + Glide
  IF get_tool_id_by_slug('airtable') IS NOT NULL AND get_tool_id_by_slug('glide') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('airtable'),
      get_tool_id_by_slug('glide'),
      'integrates_with',
      9,
      'Glide 完整支援 Airtable 作為資料來源，可快速建立行動應用。即時雙向同步確保資料一致性，適合團隊協作和行動化場景。',
      'very_high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- Retool + Supabase
  IF get_tool_id_by_slug('retool') IS NOT NULL AND get_tool_id_by_slug('supabase') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('retool'),
      get_tool_id_by_slug('supabase'),
      'integrates_with',
      9,
      'Retool 原生支援 Supabase 整合，可快速建立內部管理工具。Supabase 提供後端資料庫和認證，Retool 提供前端介面，是建立內部工具的黃金組合。',
      'high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        strength = EXCLUDED.strength;
  END IF;

  -- Alternative relationships
  -- Langflow vs Flowise
  IF get_tool_id_by_slug('langflow') IS NOT NULL AND get_tool_id_by_slug('flowise') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('langflow'),
      get_tool_id_by_slug('flowise'),
      'alternative_to',
      7,
      'Langflow 和 Flowise 都是低程式碼 LLM 編排工具，功能相似。Langflow 更適合開發者，提供更多自訂選項；Flowise 介面更友善，適合非技術使用者。',
      'medium'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        relationship_type = EXCLUDED.relationship_type,
        strength = EXCLUDED.strength;
  END IF;

  -- n8n vs Zapier
  IF get_tool_id_by_slug('n8n') IS NOT NULL AND get_tool_id_by_slug('zapier') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('n8n'),
      get_tool_id_by_slug('zapier'),
      'alternative_to',
      8,
      'n8n 和 Zapier 都是自動化平台。n8n 開源且可自主託管，提供更多彈性和隱私控制；Zapier 更易用且整合更多，但成本較高。',
      'high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        relationship_type = EXCLUDED.relationship_type,
        strength = EXCLUDED.strength;
  END IF;

  -- OpenAI vs Claude
  IF get_tool_id_by_slug('openai') IS NOT NULL AND get_tool_id_by_slug('anthropic') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('openai'),
      get_tool_id_by_slug('anthropic'),
      'alternative_to',
      9,
      'OpenAI GPT 和 Anthropic Claude 都是頂尖語言模型。GPT-4 功能更全面且生態系統豐富；Claude 在安全性、長上下文處理和推理能力上有優勢。',
      'high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        relationship_type = EXCLUDED.relationship_type,
        strength = EXCLUDED.strength;
  END IF;

  -- Complementary relationships
  -- Figma + Webflow
  IF get_tool_id_by_slug('figma') IS NOT NULL AND get_tool_id_by_slug('webflow') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('figma'),
      get_tool_id_by_slug('webflow'),
      'complements',
      9,
      'Figma 設計可透過插件或手動轉換到 Webflow。雖非完全自動化，但設計系統和元件可在兩平台間共享，加速網站開發流程。',
      'high'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        relationship_type = EXCLUDED.relationship_type,
        strength = EXCLUDED.strength;
  END IF;

  -- Canva + Notion
  IF get_tool_id_by_slug('canva') IS NOT NULL AND get_tool_id_by_slug('notion') IS NOT NULL THEN
    INSERT INTO tool_pairings (tool_id_1, tool_id_2, relationship_type, strength, rationale, pairing_frequency)
    VALUES (
      get_tool_id_by_slug('canva'),
      get_tool_id_by_slug('notion'),
      'complements',
      7,
      'Canva 設計可嵌入 Notion 頁面，增強文件視覺呈現。適合建立美觀的團隊文件、簡報和知識庫。',
      'medium'
    )
    ON CONFLICT (tool_id_1, tool_id_2) DO UPDATE
    SET rationale = EXCLUDED.rationale,
        relationship_type = EXCLUDED.relationship_type,
        strength = EXCLUDED.strength;
  END IF;

END $$;

-- Clean up
DROP FUNCTION IF EXISTS get_tool_id_by_slug(text);

/*
  Migration Summary
  -----------------
  Updated tool_pairings with comprehensive rationale and proper strength scores (1-10 scale).
  
  - 15+ pairings updated/inserted
  - All include detailed Chinese rationale
  - Proper relationship types assigned
  - Strength scores calibrated to 1-10 scale
  
  Next: Verify pairings display correctly in UI and add export templates.
*/
