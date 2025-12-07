/*
  # 優化創意用例中文體驗

  ## 概述
  此 migration 優化 creative_use_cases 資料表，添加問題陳述與解決方案欄位，
  並確保所有繁體中文翻譯完整且正確。

  ## 變更內容

  ### 1. 新增欄位
  - `problem_statement` (text) - 英文問題陳述
  - `problem_statement_en` (text) - 明確的英文問題陳述
  - `problem_statement_zh_tw` (text) - 繁體中文問題陳述
  - `solution_statement` (text) - 英文解決方案
  - `solution_statement_en` (text) - 明確的英文解決方案
  - `solution_statement_zh_tw` (text) - 繁體中文解決方案

  ### 2. 更新現有用例
  - 為所有 10 個現有用例添加問題陳述與解決方案
  - 確保中文翻譯完整且口語化

  ## 安全性
  - 維持現有 RLS 政策
  - 公開讀取權限
*/

-- ============================================================================
-- 1. 添加新欄位
-- ============================================================================

DO $$
BEGIN
  -- Add problem_statement fields
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'creative_use_cases' AND column_name = 'problem_statement'
  ) THEN
    ALTER TABLE creative_use_cases ADD COLUMN problem_statement text DEFAULT '';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'creative_use_cases' AND column_name = 'problem_statement_en'
  ) THEN
    ALTER TABLE creative_use_cases ADD COLUMN problem_statement_en text DEFAULT '';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'creative_use_cases' AND column_name = 'problem_statement_zh_tw'
  ) THEN
    ALTER TABLE creative_use_cases ADD COLUMN problem_statement_zh_tw text DEFAULT '';
  END IF;

  -- Add solution_statement fields
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'creative_use_cases' AND column_name = 'solution_statement'
  ) THEN
    ALTER TABLE creative_use_cases ADD COLUMN solution_statement text DEFAULT '';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'creative_use_cases' AND column_name = 'solution_statement_en'
  ) THEN
    ALTER TABLE creative_use_cases ADD COLUMN solution_statement_en text DEFAULT '';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'creative_use_cases' AND column_name = 'solution_statement_zh_tw'
  ) THEN
    ALTER TABLE creative_use_cases ADD COLUMN solution_statement_zh_tw text DEFAULT '';
  END IF;
END $$;

-- ============================================================================
-- 2. 更新現有用例 - 添加問題與解決方案陳述
-- ============================================================================

-- 1. AI 靜心日記系統
UPDATE creative_use_cases
SET
  problem_statement = 'Difficult to maintain journaling habit and deeply reflect on emotional changes in busy life',
  problem_statement_en = 'Difficult to maintain journaling habit and deeply reflect on emotional changes in busy life',
  problem_statement_zh_tw = '忙碌生活中難以保持日記習慣並深度反思情緒變化',
  solution_statement = 'AI automatically analyzes journal content to provide mental health insights and weekly reflection reports',
  solution_statement_en = 'AI automatically analyzes journal content to provide mental health insights and weekly reflection reports',
  solution_statement_zh_tw = '透過 AI 自動分析日記內容，提供心理健康洞察與每週反思報告'
WHERE slug = 'ai-mindful-journal';

-- 2. 創意內容生產鏈
UPDATE creative_use_cases
SET
  problem_statement = 'Content creation workflow is fragmented, from ideation to publishing requires switching between multiple tools',
  problem_statement_en = 'Content creation workflow is fragmented, from ideation to publishing requires switching between multiple tools',
  problem_statement_zh_tw = '內容創作流程零散，從發想到上架需切換多個工具',
  solution_statement = 'Integrate AI generation, design automation, and social media scheduling into one seamless workflow',
  solution_statement_en = 'Integrate AI generation, design automation, and social media scheduling into one seamless workflow',
  solution_statement_zh_tw = '整合 AI 生成、設計自動化與社群排程，打造一站式內容生產線'
WHERE slug = 'creative-content-pipeline';

-- 3. 智能郵件助理
UPDATE creative_use_cases
SET
  problem_statement = 'Overwhelmed by email volume, spending too much time sorting and responding to messages',
  problem_statement_en = 'Overwhelmed by email volume, spending too much time sorting and responding to messages',
  problem_statement_zh_tw = '郵件量龐大難以管理，花費大量時間分類與回覆',
  solution_statement = 'AI automatically categorizes, prioritizes, and drafts responses, reducing inbox management time by 70%',
  solution_statement_en = 'AI automatically categorizes, prioritizes, and drafts responses, reducing inbox management time by 70%',
  solution_statement_zh_tw = 'AI 自動分類、排序並草擬回覆，減少 70% 收件匣管理時間'
WHERE slug = 'smart-email-assistant';

-- 4. 個人知識庫
UPDATE creative_use_cases
SET
  problem_statement = 'Information scattered across multiple platforms, difficult to connect ideas and retrieve relevant knowledge',
  problem_statement_en = 'Information scattered across multiple platforms, difficult to connect ideas and retrieve relevant knowledge',
  problem_statement_zh_tw = '資訊分散在多個平台，難以串聯想法與檢索相關知識',
  solution_statement = 'Centralized knowledge base with AI-powered semantic search and automatic note linking',
  solution_statement_en = 'Centralized knowledge base with AI-powered semantic search and automatic note linking',
  solution_statement_zh_tw = '集中式知識庫搭配 AI 語意搜尋與自動筆記連結'
WHERE slug = 'personal-knowledge-base';

-- 5. 社群媒體排程器
UPDATE creative_use_cases
SET
  problem_statement = 'Managing multiple social media accounts is time-consuming and inconsistent posting affects engagement',
  problem_statement_en = 'Managing multiple social media accounts is time-consuming and inconsistent posting affects engagement',
  problem_statement_zh_tw = '管理多個社群帳號耗時，且發文不一致影響互動率',
  solution_statement = 'Automated content scheduling across platforms with optimal timing and performance tracking',
  solution_statement_en = 'Automated content scheduling across platforms with optimal timing and performance tracking',
  solution_statement_zh_tw = '跨平台自動排程發文，選擇最佳時機並追蹤成效'
WHERE slug = 'social-media-scheduler';

-- 6. AI 客戶支援
UPDATE creative_use_cases
SET
  problem_statement = 'Customer inquiries require immediate response but support team capacity is limited',
  problem_statement_en = 'Customer inquiries require immediate response but support team capacity is limited',
  problem_statement_zh_tw = '客戶詢問需即時回應，但客服團隊人力有限',
  solution_statement = 'AI-powered chatbot handles common queries 24/7, escalating complex issues to human agents',
  solution_statement_en = 'AI-powered chatbot handles common queries 24/7, escalating complex issues to human agents',
  solution_statement_zh_tw = 'AI 聊天機器人 24/7 處理常見問題，複雜問題轉交人工客服'
WHERE slug = 'ai-customer-support';

-- 7. 資料分析儀表板
UPDATE creative_use_cases
SET
  problem_statement = 'Business data scattered across tools, difficult to gain unified insights for decision-making',
  problem_statement_en = 'Business data scattered across tools, difficult to gain unified insights for decision-making',
  problem_statement_zh_tw = '業務數據散落各工具，難以統一洞察並做出決策',
  solution_statement = 'Automated data aggregation and visualization with real-time dashboards and AI-generated insights',
  solution_statement_en = 'Automated data aggregation and visualization with real-time dashboards and AI-generated insights',
  solution_statement_zh_tw = '自動化數據匯整與視覺化，提供即時儀表板與 AI 生成洞察'
WHERE slug = 'data-analysis-dashboard';

-- 8. 食譜推薦引擎
UPDATE creative_use_cases
SET
  problem_statement = 'Meal planning is tedious, and finding recipes that match dietary preferences and available ingredients is challenging',
  problem_statement_en = 'Meal planning is tedious, and finding recipes that match dietary preferences and available ingredients is challenging',
  problem_statement_zh_tw = '規劃餐點繁瑣，且難以找到符合飲食偏好與現有食材的食譜',
  solution_statement = 'AI recommends personalized recipes based on preferences, dietary restrictions, and pantry inventory',
  solution_statement_en = 'AI recommends personalized recipes based on preferences, dietary restrictions, and pantry inventory',
  solution_statement_zh_tw = 'AI 根據偏好、飲食限制與庫存食材推薦個人化食譜'
WHERE slug = 'recipe-recommendation-engine';

-- 9. 語言學習助理
UPDATE creative_use_cases
SET
  problem_statement = 'Traditional language learning lacks personalization and real-world conversational practice',
  problem_statement_en = 'Traditional language learning lacks personalization and real-world conversational practice',
  problem_statement_zh_tw = '傳統語言學習缺乏個人化與真實對話練習',
  solution_statement = 'AI conversation partner with personalized lessons, pronunciation feedback, and adaptive difficulty',
  solution_statement_en = 'AI conversation partner with personalized lessons, pronunciation feedback, and adaptive difficulty',
  solution_statement_zh_tw = 'AI 對話夥伴提供個人化課程、發音回饋與自適應難度'
WHERE slug = 'language-learning-assistant';

-- 10. 健身追蹤整合
UPDATE creative_use_cases
SET
  problem_statement = 'Fitness data from multiple devices and apps cannot be unified, making progress tracking difficult',
  problem_statement_en = 'Fitness data from multiple devices and apps cannot be unified, making progress tracking difficult',
  problem_statement_zh_tw = '多裝置與 App 的健身數據無法統一，難以追蹤進度',
  solution_statement = 'Centralized fitness dashboard aggregating data from all sources with AI-powered insights and recommendations',
  solution_statement_en = 'Centralized fitness dashboard aggregating data from all sources with AI-powered insights and recommendations',
  solution_statement_zh_tw = '集中式健身儀表板匯整所有數據，提供 AI 洞察與建議'
WHERE slug = 'fitness-tracker-integration';
