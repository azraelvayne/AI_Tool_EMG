/*
  # Seed Traditional Chinese Translations for Tools

  ## Purpose
  Populate tool_translations table with Traditional Chinese (zh-TW) translations
  for all existing tools in the database.

  ## Tools Translated
  1. Notion - 全能工作空間
  2. Supabase - 開源後端服務
  3. n8n - 工作流程自動化
  4. OpenAI - AI 語言模型
  5. Claude - AI 助理
  6. Airtable - 雲端資料庫

  ## Translation Quality
  - Professional, industry-standard terminology
  - Maintains technical accuracy
  - Natural Traditional Chinese expression
*/

-- Notion Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Notion';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '集筆記、資料庫、維基和專案管理於一身的全能工作空間，具備 AI 功能。',
      '{
        "encyclopedia": "Notion 是一個多功能的工作空間平台，整合了筆記、資料庫、維基和專案管理工具，並內建 AI 助理功能，可作為知識管理和應用程式開發的基礎。",
        "guide": "在 AI 系統中，Notion 扮演知識記憶層的角色，儲存對話歷史、任務清單和知識摘要。它可以透過 API 連接到 n8n 或 Make 等自動化平台，建立智慧工作流程。",
        "strategy": "當您需要一個直觀的介面來組織複雜資訊和關聯式資料庫時，可選擇 Notion。非常適合建立 AI 研究系統、個人知識助理或內容管理工作流程。最佳搭配自動化工具進行動態更新。",
        "inspiration": [
          "建立一個 AI 驅動的研究助理，自動分類和摘要文章到 Notion 資料庫中",
          "創建個人知識圖譜，使用 AI 連結相關筆記並建議關聯",
          "設計自動化會議記錄系統，轉錄、摘要並整理討論內容到 Notion"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code) 
    DO UPDATE SET 
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- Supabase Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Supabase';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '開源的 Firebase 替代方案，提供資料庫、身份驗證、儲存和即時訂閱功能。',
      '{
        "encyclopedia": "Supabase 是一個基於 PostgreSQL 建構的開源後端即服務平台，提供資料庫、身份驗證、檔案儲存和即時功能，配備開發者友善的 API。",
        "guide": "Supabase 作為現代應用程式的資料骨幹，為您的 PostgreSQL 資料庫提供即時 API。非常適合建立全端應用程式，無需管理基礎架構。使用行級安全性進行精細的存取控制。",
        "strategy": "當您需要一個強大的關聯式資料庫，配備即時功能和內建身份驗證時，可選擇 Supabase。非常適合需要結構化資料儲存、使用者管理和向量嵌入語義搜尋的 AI 應用程式。",
        "inspiration": [
          "建立多使用者 AI 聊天應用程式，對話歷史儲存在 Supabase 中",
          "使用 pgvector 建立文件知識庫，實現語義搜尋功能",
          "設計協作工作空間，讓團隊成員可以分享和標註 AI 生成的內容"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code) 
    DO UPDATE SET 
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- n8n Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'n8n';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '公平授權的工作流程自動化平台，擁有 300 多個整合，可建立複雜的自動化序列。',
      '{
        "encyclopedia": "n8n 是一個基於節點的工作流程自動化平台，讓使用者透過視覺化程式設計連接不同的服務和 API，並廣泛支援 AI 模型整合。",
        "guide": "n8n 在 AI 系統中扮演協調層的角色，連接資料來源、AI 模型和輸出目的地。使用它建立複雜的工作流程，可根據事件觸發、透過多個步驟處理資料，並與外部服務整合。",
        "strategy": "當您需要靈活的自主託管自動化，配備複雜的條件邏輯時，可選擇 n8n。非常適合建立 AI 代理，從多個來源提取資料，透過語言模型處理，並在多個平台上分發結果。",
        "inspiration": [
          "創建自動化內容管道，監控 RSS 摘要，使用 AI 摘要文章，並發布到社交媒體",
          "建立客戶支援機器人，分類電子郵件，生成 AI 回覆，並將複雜問題轉給人工處理",
          "設計資料豐富工作流程，透過多個 AI 服務處理 CRM 條目"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code) 
    DO UPDATE SET 
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- OpenAI Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'OpenAI';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '領先的 AI 研究公司，提供 GPT 語言模型、DALL-E 圖像生成和 Whisper 語音識別。',
      '{
        "encyclopedia": "OpenAI 提供最先進的 AI 模型，包括用於文字生成的 GPT-4、用於圖像創建的 DALL-E 和用於語音轉錄的 Whisper，可透過開發者友善的 API 存取。",
        "guide": "OpenAI 在 AI 應用程式中作為智慧層。使用 GPT 模型進行文字生成、分析和轉換。與自動化平台整合或使用 API 建立自訂應用程式，配備結構化輸出。",
        "strategy": "當您需要最先進的 AI 功能，具備強大的推理和生成品質時，可選擇 OpenAI。最適合需要自然語言理解、創意內容生成或複雜問題解決的應用程式。考慮大量使用情況的成本管理。",
        "inspiration": [
          "建立程式碼文件生成器，分析程式碼庫並創建全面的 API 文件",
          "創建智慧電子郵件助理，根據對話上下文和語氣草擬回覆",
          "設計創意寫作工具，幫助作家發展角色背景和情節大綱"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code) 
    DO UPDATE SET 
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- Claude Translation (if exists)
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Claude';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      'Anthropic 的 AI 助理，專注於有用、無害和誠實的對話。',
      '{
        "encyclopedia": "Claude 是 Anthropic 開發的 AI 助理，以其在複雜推理、程式設計和創意任務方面的強大能力而聞名，並注重安全性和可靠性。",
        "guide": "Claude 擅長處理長篇內容、複雜分析和需要深入推理的任務。可透過 API 整合到應用程式中，或在 Claude.ai 介面中直接使用。",
        "strategy": "當您需要進行深度分析、程式碼審查或需要仔細推理的複雜任務時，可選擇 Claude。特別適合文件分析、技術寫作和需要高度準確性的任務。",
        "inspiration": [
          "建立技術文件審查系統，提供詳細的改進建議",
          "創建程式碼重構助理，分析並建議架構改進",
          "設計研究助理，分析學術論文並生成文獻綜述"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code) 
    DO UPDATE SET 
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- Airtable Translation (if exists)
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Airtable';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '結合試算表的熟悉性與資料庫的強大功能，提供靈活的平台來組織資訊。',
      '{
        "encyclopedia": "Airtable 結合了試算表的易用性和資料庫的強大功能，提供靈活的平台來組織資訊，配備豐富的欄位類型、檢視和整合功能。",
        "guide": "Airtable 作為視覺化資料庫層，具備直觀的介面。可用於內容管理、專案追蹤，或作為應用程式的資料來源。API 可實現程式化存取，進行自動化和整合。",
        "strategy": "當您需要一個非技術團隊成員也能管理的使用者友善資料庫時，可選擇 Airtable。非常適合內容日曆、CRM 系統，或作為簡單應用程式的輕量級後端。",
        "inspiration": [
          "建立內容發布管道，自動化從撰寫到發布的整個流程",
          "創建客戶關係管理系統，整合 AI 進行潛在客戶評分",
          "設計產品路線圖追蹤器，連接開發工具並自動更新狀態"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code) 
    DO UPDATE SET 
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;
