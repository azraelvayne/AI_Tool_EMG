/*
  # Seed Traditional Chinese Translations for Category Metadata

  ## Purpose
  Populate category_metadata_translations table with Traditional Chinese (zh-TW) translations
  for all category values, enabling bilingual display throughout the application.

  ## Categories Translated
  1. Purpose - 用途 (Learning/Application/System Oriented)
  2. Functional Role - 功能角色 (Database/API/Automation/Frontend/AI Assistant/etc.)
  3. Tech Layer - 技術層級 (Data/Processing/Frontend/AI/Integration Layer)
  4. Data Flow Role - 資料流程角色 (Input/Process/Storage/Output)
  5. Difficulty - 難度等級 (No-code/Low-code/Code)
  6. Application Field - 應用領域 (Knowledge Management/Automation/etc.)

  ## Translation Strategy
  - Maintains semantic meaning from English
  - Uses industry-standard terminology in Traditional Chinese
  - Optimized for Taiwan/Hong Kong/Macau users
*/

-- Insert Purpose translations (用途)
DO $$
DECLARE
  cat_id uuid;
BEGIN
  -- Learning Oriented
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'purpose' AND category_value = 'Learning Oriented';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '學習導向')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Application Oriented
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'purpose' AND category_value = 'Application Oriented';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '應用導向')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- System Oriented
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'purpose' AND category_value = 'System Oriented';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '系統導向')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;
END $$;

-- Insert Functional Role translations (功能角色)
DO $$
DECLARE
  cat_id uuid;
BEGIN
  -- Database
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'Database';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '資料庫')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- API
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'API';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', 'API 介面')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Automation
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'Automation';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '自動化')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Frontend
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'Frontend';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '前端介面')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- AI Assistant
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'AI Assistant';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', 'AI 助理')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Content Management
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'Content Management';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '內容管理')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Collaboration
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'Collaboration';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '協作工具')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Analytics
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'functional_role' AND category_value = 'Analytics';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '數據分析')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;
END $$;

-- Insert Tech Layer translations (技術層級)
DO $$
DECLARE
  cat_id uuid;
BEGIN
  -- Data Layer
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'tech_layer' AND category_value = 'Data Layer';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '資料層')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Processing Layer
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'tech_layer' AND category_value = 'Processing Layer';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '處理層')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Frontend Layer
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'tech_layer' AND category_value = 'Frontend Layer';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '前端層')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- AI Layer
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'tech_layer' AND category_value = 'AI Layer';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', 'AI 層')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Integration Layer
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'tech_layer' AND category_value = 'Integration Layer';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '整合層')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;
END $$;

-- Insert Data Flow Role translations (資料流程角色)
DO $$
DECLARE
  cat_id uuid;
BEGIN
  -- Input
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'data_flow_role' AND category_value = 'Input';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '輸入')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Process
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'data_flow_role' AND category_value = 'Process';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '處理')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Storage
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'data_flow_role' AND category_value = 'Storage';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '儲存')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Output
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'data_flow_role' AND category_value = 'Output';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '輸出')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;
END $$;

-- Insert Difficulty translations (難度等級)
DO $$
DECLARE
  cat_id uuid;
BEGIN
  -- No-code
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'difficulty' AND category_value = 'No-code';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '無需程式碼')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Low-code
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'difficulty' AND category_value = 'Low-code';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '低程式碼')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Code
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'difficulty' AND category_value = 'Code';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '需要編程')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;
END $$;

-- Insert Application Field translations (應用領域)
DO $$
DECLARE
  cat_id uuid;
BEGIN
  -- Knowledge Management
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'application_field' AND category_value = 'Knowledge Management';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '知識管理')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Automation
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'application_field' AND category_value = 'Automation';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '自動化')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Content Creation
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'application_field' AND category_value = 'Content Creation';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '內容創作')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Data Analysis
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'application_field' AND category_value = 'Data Analysis';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '數據分析')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Web Development
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'application_field' AND category_value = 'Web Development';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '網頁開發')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- AI Applications
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'application_field' AND category_value = 'AI Applications';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', 'AI 應用')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;

  -- Collaboration
  SELECT id INTO cat_id FROM category_metadata 
  WHERE category_type = 'application_field' AND category_value = 'Collaboration';
  IF cat_id IS NOT NULL THEN
    INSERT INTO category_metadata_translations (category_metadata_id, language_code, translated_value)
    VALUES (cat_id, 'zh-TW', '協作')
    ON CONFLICT (category_metadata_id, language_code) DO UPDATE SET translated_value = EXCLUDED.translated_value;
  END IF;
END $$;
