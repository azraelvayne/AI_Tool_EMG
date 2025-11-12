/*
  # Add Missing Tool Translations (Traditional Chinese)

  ## Purpose
  Complete the Traditional Chinese (zh-TW) translations for tools that were
  missing from the initial translation migration.

  ## Tools Translated
  1. Make - 視覺化自動化平台 (formerly Integromat)
  2. Webflow - 專業無程式碼網頁開發平台
  3. Glide - 無程式碼應用程式建構工具
  4. Flowise - 開源低程式碼 LLM 編排平台

  ## Translation Quality
  - Professional, industry-standard terminology
  - Maintains technical accuracy
  - Natural Traditional Chinese expression
  - Consistent with existing translations
*/

-- Make Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Make';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '視覺化自動化平台（前身為 Integromat），具備進階路由、錯誤處理和資料轉換功能。',
      '{
        "encyclopedia": "Make（前身為 Integromat）是一個視覺化自動化平台，讓使用者能夠連接應用程式和服務，具備強大的資料轉換、路由和錯誤處理能力。",
        "guide": "Make 擅長處理複雜的自動化場景，具備分支邏輯、資料操作和精密的錯誤處理功能。使用它建立強健的工作流程，整合多個服務。",
        "strategy": "當您需要進階的自動化功能，如陣列處理、錯誤恢復和複雜條件邏輯時，可選擇 Make。非常適合企業自動化和需要資料轉換的工作流程。",
        "inspiration": [
          "建立 AI 驅動的潛在客戶豐富系統，透過多個資料來源處理表單提交",
          "創建社交媒體內容排程器，生成 AI 標題並跨平台發布",
          "設計客戶入職自動化，根據 AI 分析個人化溝通內容"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code)
    DO UPDATE SET
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- Webflow Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Webflow';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '專業的無程式碼網頁開發平台，具備視覺化設計、CMS 和主機功能。',
      '{
        "encyclopedia": "Webflow 是一個視覺化網頁開發平台，能從設計生成正式環境程式碼，提供無需編碼的專業網站建立，並配備 CMS 和主機服務。",
        "guide": "Webflow 作為應用程式的呈現層，讓設計師能夠視覺化建立響應式網站。透過 API 與後端服務結合，實現動態功能。",
        "strategy": "當您需要設計靈活性和專業效果，且不需編碼時，可選擇 Webflow。非常適合行銷網站、作品集，或作為 API 驅動應用程式的前端介面。",
        "inspiration": [
          "創建 AI 驅動的作品集網站，從 GitHub 存儲庫自動生成專案描述",
          "建立動態定價頁面，使用 AI 根據訪客行為個人化提供方案",
          "設計部落格平台，AI 協助 SEO 優化和內容建議"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code)
    DO UPDATE SET
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- Glide Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Glide';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '無程式碼平台，可從試算表建立行動和網頁應用程式，具備原生行動功能。',
      '{
        "encyclopedia": "Glide 將試算表轉換為精美的行動和網頁應用程式，無需編碼，提供預建元件、原生功能和直接資料連接。",
        "guide": "Glide 透過直接連接 Google Sheets 或 Airtable 等資料來源，擅長快速原型設計和內部工具開發。使用它快速建立行動友善的介面。",
        "strategy": "當您需要快速將資料轉換為應用程式，且不需開發時，可選擇 Glide。非常適合內部工具、目錄或簡單的資料驅動應用程式，需要行動裝置支援。",
        "inspiration": [
          "建立 AI 驅動的員工通訊錄，根據技能和專案建議連結",
          "創建知識庫應用程式，AI 協助尋找相關文件",
          "設計現場服務應用程式，使用 AI 有效率地分配技術人員路線"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code)
    DO UPDATE SET
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;

-- Flowise Translation
DO $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE tool_name = 'Flowise';
  IF tool_uuid IS NOT NULL THEN
    INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
    VALUES (
      tool_uuid,
      'zh-TW',
      '開源低程式碼平台，可視覺化建立自訂的 LLM 編排流程和 AI 代理。',
      '{
        "encyclopedia": "Flowise 是一個開源平台，使用視覺化拖放介面建立 LLM 應用程式和 AI 代理，支援多種 AI 模型和向量資料庫。",
        "guide": "Flowise 透過提供模型、記憶體、鏈和代理的預建元件，簡化複雜 AI 工作流程的建立。使用它無需大量編碼即可實驗 LLM 編排。",
        "strategy": "當您想要快速建立 AI 應用程式原型，或需要視覺化介面來建立 LLM 鏈時，可選擇 Flowise。非常適合建立聊天機器人、文件問答系統或自主代理。",
        "inspiration": [
          "創建具備記憶功能的客戶支援聊天機器人，從過去對話中學習",
          "建立文件分析系統，可以回答來自多個 PDF 來源的問題",
          "設計 AI 研究助理，可以從各種來源搜尋、摘要和綜合資訊"
        ]
      }'::jsonb
    )
    ON CONFLICT (tool_id, language_code)
    DO UPDATE SET
      summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
  END IF;
END $$;
