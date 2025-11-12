/*
  # Seed Creative Use Cases

  ## Overview
  This migration seeds 10 curated creative use case examples demonstrating
  cross-domain applications of AI and automation tools.

  ## Use Cases Included
  1. AI Mindful Journal Generator - Mental health & self-growth
  2. Creative Content Pipeline - Content marketing & automation
  3. Smart Email Assistant - Productivity & communication
  4. Personal Knowledge Base - Knowledge management
  5. Social Media Scheduler - Social media automation
  6. AI Customer Support - Customer service automation
  7. Data Analysis Dashboard - Business intelligence
  8. Recipe Recommendation Engine - Food & lifestyle
  9. Language Learning Assistant - Education & learning
  10. Fitness Tracker Integration - Health & wellness

  ## Data Structure
  Each use case includes:
  - Bilingual titles and descriptions (English & Traditional Chinese)
  - Difficulty level
  - Use case tags for categorization
  - List of tools used
  - Step-by-step workflow instructions
  - Supported export formats
  - Estimated implementation time
*/

-- Clear existing creative use cases (if any)
TRUNCATE TABLE creative_use_cases CASCADE;

-- Insert 10 creative use case examples
INSERT INTO creative_use_cases (
  slug,
  title,
  title_en,
  title_zh_tw,
  description,
  description_en,
  description_zh_tw,
  difficulty,
  use_case_tags,
  tools,
  workflow_steps,
  export_format,
  estimated_time,
  display_order
) VALUES

-- 1. AI Mindful Journal Generator
(
  'ai-mindful-journal',
  'AI Mindful Journal Generator',
  'AI Mindful Journal Generator',
  'AI 靜心日記系統',
  'AI automatically analyzes daily text journals, generating mood summaries and reflection suggestions for mental wellness.',
  'AI automatically analyzes daily text journals, generating mood summaries and reflection suggestions for mental wellness.',
  'AI 自動分析每日文字日記，生成心情摘要與反思建議，促進心理健康。',
  'beginner',
  ARRAY['Mental Health', 'Journaling', 'Self-Growth', 'AI Analysis', '心理健康', '日記', '自我成長'],
  ARRAY['Notion', 'n8n', 'OpenAI', 'Google Sheets'],
  '[
    {"step": 1, "description": "User inputs daily journal entry in Notion", "description_zh": "使用者在 Notion 中輸入每日日記"},
    {"step": 2, "description": "n8n triggers workflow when new entry is detected", "description_zh": "n8n 偵測到新日記時觸發工作流程"},
    {"step": 3, "description": "OpenAI analyzes text for emotional sentiment and key themes", "description_zh": "OpenAI 分析文字情緒與關鍵主題"},
    {"step": 4, "description": "Generated summary is saved to Google Sheets for tracking", "description_zh": "生成的摘要儲存至 Google Sheets 追蹤"},
    {"step": 5, "description": "Weekly reflection report is automatically emailed", "description_zh": "每週自動寄送反思報告"}
  ]'::jsonb,
  ARRAY['n8n', 'notion'],
  '2-3 hours',
  1
),

-- 2. Creative Content Pipeline
(
  'creative-content-pipeline',
  'Creative Content Pipeline',
  'Creative Content Pipeline',
  '創意內容生產鏈',
  'Automate from inspiration to publishing: generate scripts, design assets, and publish to social media seamlessly.',
  'Automate from inspiration to publishing: generate scripts, design assets, and publish to social media seamlessly.',
  '自動從靈感到上架：生成腳本、設計素材、社群發布一氣呵成。',
  'intermediate',
  ARRAY['Content Marketing', 'Social Media', 'Automation', 'Design', '內容行銷', '自媒體', '自動化'],
  ARRAY['ChatGPT', 'Canva', 'n8n', 'Instagram'],
  '[
    {"step": 1, "description": "AI generates content ideas and scripts based on trends", "description_zh": "AI 根據趨勢生成內容點子與腳本"},
    {"step": 2, "description": "Canva automatically creates design templates", "description_zh": "Canva 自動生成設計模板"},
    {"step": 3, "description": "n8n connects to social media APIs for scheduling", "description_zh": "n8n 串接社群 API 進行排程"},
    {"step": 4, "description": "Content is published across multiple platforms", "description_zh": "內容發布至多個平台"},
    {"step": 5, "description": "Performance metrics are tracked and analyzed", "description_zh": "追蹤並分析成效指標"}
  ]'::jsonb,
  ARRAY['n8n', 'zapier'],
  '4-5 hours',
  2
),

-- 3. Smart Email Assistant
(
  'smart-email-assistant',
  'Smart Email Assistant',
  'Smart Email Assistant',
  '智能郵件助理',
  'Automatically categorize, prioritize, and draft responses to emails using AI, saving hours of inbox management time.',
  'Automatically categorize, prioritize, and draft responses to emails using AI, saving hours of inbox management time.',
  '使用 AI 自動分類、優先排序並草擬郵件回覆，節省大量收件匣管理時間。',
  'beginner',
  ARRAY['Productivity', 'Email', 'Communication', 'AI', '生產力', '郵件', '溝通'],
  ARRAY['Gmail', 'OpenAI', 'n8n', 'Notion'],
  '[
    {"step": 1, "description": "n8n monitors Gmail inbox for new messages", "description_zh": "n8n 監控 Gmail 收件匣新郵件"},
    {"step": 2, "description": "OpenAI categorizes emails by importance and topic", "description_zh": "OpenAI 依重要性與主題分類郵件"},
    {"step": 3, "description": "Priority emails are flagged and logged in Notion", "description_zh": "優先郵件標記並記錄至 Notion"},
    {"step": 4, "description": "AI generates draft responses for review", "description_zh": "AI 生成草稿回覆供審閱"},
    {"step": 5, "description": "User reviews and sends responses with one click", "description_zh": "使用者一鍵審閱並發送回覆"}
  ]'::jsonb,
  ARRAY['n8n'],
  '2-3 hours',
  3
),

-- 4. Personal Knowledge Base
(
  'personal-knowledge-base',
  'Personal Knowledge Base',
  'Personal Knowledge Base',
  '個人知識庫',
  'Build an AI-powered searchable knowledge base that automatically organizes notes, articles, and resources.',
  'Build an AI-powered searchable knowledge base that automatically organizes notes, articles, and resources.',
  '建立 AI 驅動的可搜尋知識庫，自動整理筆記、文章與資源。',
  'intermediate',
  ARRAY['Knowledge Management', 'Organization', 'AI Search', '知識管理', '組織', 'AI 搜尋'],
  ARRAY['Notion', 'Supabase', 'OpenAI', 'n8n'],
  '[
    {"step": 1, "description": "Content is saved to Notion or imported via API", "description_zh": "內容儲存至 Notion 或透過 API 匯入"},
    {"step": 2, "description": "n8n processes and extracts key information", "description_zh": "n8n 處理並提取關鍵資訊"},
    {"step": 3, "description": "OpenAI generates embeddings for semantic search", "description_zh": "OpenAI 生成嵌入向量供語意搜尋"},
    {"step": 4, "description": "Supabase stores vectors for fast retrieval", "description_zh": "Supabase 儲存向量以快速檢索"},
    {"step": 5, "description": "Users search using natural language queries", "description_zh": "使用者使用自然語言查詢搜尋"}
  ]'::jsonb,
  ARRAY['n8n'],
  '5-6 hours',
  4
),

-- 5. Social Media Scheduler
(
  'social-media-scheduler',
  'Social Media Scheduler',
  'Social Media Scheduler',
  '社群媒體排程器',
  'Schedule and auto-publish content across multiple social platforms with AI-optimized posting times.',
  'Schedule and auto-publish content across multiple social platforms with AI-optimized posting times.',
  '排程並自動發布內容至多個社群平台，使用 AI 優化發布時間。',
  'beginner',
  ARRAY['Social Media', 'Marketing', 'Automation', '社群媒體', '行銷', '自動化'],
  ARRAY['Airtable', 'n8n', 'Twitter', 'Facebook'],
  '[
    {"step": 1, "description": "Content is planned and stored in Airtable", "description_zh": "內容規劃並儲存於 Airtable"},
    {"step": 2, "description": "n8n reads scheduled posts based on timing", "description_zh": "n8n 依時間讀取排程貼文"},
    {"step": 3, "description": "AI suggests optimal posting times per platform", "description_zh": "AI 建議各平台最佳發布時間"},
    {"step": 4, "description": "Posts are published to Twitter, Facebook, etc.", "description_zh": "貼文發布至 Twitter、Facebook 等"},
    {"step": 5, "description": "Engagement metrics are tracked in Airtable", "description_zh": "互動指標追蹤至 Airtable"}
  ]'::jsonb,
  ARRAY['n8n', 'zapier'],
  '3-4 hours',
  5
),

-- 6. AI Customer Support
(
  'ai-customer-support',
  'AI Customer Support Bot',
  'AI Customer Support Bot',
  'AI 客戶支援機器人',
  'Automate customer inquiries with an AI chatbot that learns from past interactions and escalates complex issues.',
  'Automate customer inquiries with an AI chatbot that learns from past interactions and escalates complex issues.',
  '使用 AI 聊天機器人自動處理客戶詢問，從過往互動學習並升級複雜問題。',
  'advanced',
  ARRAY['Customer Service', 'Chatbot', 'AI', 'Support', '客戶服務', '聊天機器人', '支援'],
  ARRAY['OpenAI', 'Supabase', 'n8n', 'Slack'],
  '[
    {"step": 1, "description": "Customer submits inquiry via website or Slack", "description_zh": "客戶透過網站或 Slack 提交詢問"},
    {"step": 2, "description": "n8n routes inquiry to AI chatbot", "description_zh": "n8n 將詢問路由至 AI 聊天機器人"},
    {"step": 3, "description": "OpenAI generates response using knowledge base", "description_zh": "OpenAI 使用知識庫生成回應"},
    {"step": 4, "description": "Complex issues are escalated to human support", "description_zh": "複雜問題升級至人工支援"},
    {"step": 5, "description": "All interactions are logged in Supabase", "description_zh": "所有互動記錄至 Supabase"}
  ]'::jsonb,
  ARRAY['n8n'],
  '6-8 hours',
  6
),

-- 7. Data Analysis Dashboard
(
  'data-analysis-dashboard',
  'Automated Data Analysis Dashboard',
  'Automated Data Analysis Dashboard',
  '自動化數據分析儀表板',
  'Collect data from multiple sources, analyze with AI, and visualize insights in a real-time dashboard.',
  'Collect data from multiple sources, analyze with AI, and visualize insights in a real-time dashboard.',
  '從多個來源收集數據，使用 AI 分析並在即時儀表板中視覺化洞察。',
  'advanced',
  ARRAY['Data Analysis', 'Business Intelligence', 'Dashboard', 'AI', '數據分析', '商業智慧', '儀表板'],
  ARRAY['Supabase', 'n8n', 'Google Sheets', 'OpenAI'],
  '[
    {"step": 1, "description": "n8n collects data from APIs and databases", "description_zh": "n8n 從 API 和資料庫收集數據"},
    {"step": 2, "description": "Data is cleaned and stored in Supabase", "description_zh": "數據清理並儲存至 Supabase"},
    {"step": 3, "description": "OpenAI analyzes trends and generates insights", "description_zh": "OpenAI 分析趨勢並生成洞察"},
    {"step": 4, "description": "Results are visualized in Google Sheets dashboard", "description_zh": "結果在 Google Sheets 儀表板中視覺化"},
    {"step": 5, "description": "Automated reports are sent weekly", "description_zh": "每週自動發送報告"}
  ]'::jsonb,
  ARRAY['n8n'],
  '7-9 hours',
  7
),

-- 8. Recipe Recommendation Engine
(
  'recipe-recommendation-engine',
  'AI Recipe Recommendation Engine',
  'AI Recipe Recommendation Engine',
  'AI 食譜推薦引擎',
  'Get personalized recipe suggestions based on dietary preferences, available ingredients, and nutritional goals.',
  'Get personalized recipe suggestions based on dietary preferences, available ingredients, and nutritional goals.',
  '根據飲食偏好、可用食材與營養目標獲得個人化食譜建議。',
  'intermediate',
  ARRAY['Food', 'Lifestyle', 'Health', 'AI Recommendations', '飲食', '生活', '健康', 'AI 推薦'],
  ARRAY['Notion', 'OpenAI', 'n8n', 'Airtable'],
  '[
    {"step": 1, "description": "User inputs dietary preferences in Notion", "description_zh": "使用者在 Notion 中輸入飲食偏好"},
    {"step": 2, "description": "n8n triggers AI recommendation workflow", "description_zh": "n8n 觸發 AI 推薦工作流程"},
    {"step": 3, "description": "OpenAI suggests recipes based on preferences", "description_zh": "OpenAI 根據偏好建議食譜"},
    {"step": 4, "description": "Recipes are saved to Airtable for meal planning", "description_zh": "食譜儲存至 Airtable 供餐點規劃"},
    {"step": 5, "description": "Shopping list is automatically generated", "description_zh": "自動生成購物清單"}
  ]'::jsonb,
  ARRAY['n8n', 'notion'],
  '3-4 hours',
  8
),

-- 9. Language Learning Assistant
(
  'language-learning-assistant',
  'AI Language Learning Assistant',
  'AI Language Learning Assistant',
  'AI 語言學習助理',
  'Practice conversations with AI, get instant feedback, and track your language learning progress automatically.',
  'Practice conversations with AI, get instant feedback, and track your language learning progress automatically.',
  '與 AI 練習對話、獲得即時反饋並自動追蹤語言學習進度。',
  'beginner',
  ARRAY['Education', 'Language Learning', 'AI Tutor', '教育', '語言學習', 'AI 家教'],
  ARRAY['OpenAI', 'Notion', 'Google Sheets', 'n8n'],
  '[
    {"step": 1, "description": "User practices conversation with AI chatbot", "description_zh": "使用者與 AI 聊天機器人練習對話"},
    {"step": 2, "description": "OpenAI provides corrections and suggestions", "description_zh": "OpenAI 提供更正與建議"},
    {"step": 3, "description": "n8n logs practice sessions in Notion", "description_zh": "n8n 將練習紀錄記錄至 Notion"},
    {"step": 4, "description": "Progress is tracked in Google Sheets dashboard", "description_zh": "進度在 Google Sheets 儀表板中追蹤"},
    {"step": 5, "description": "Weekly progress report is generated", "description_zh": "生成每週進度報告"}
  ]'::jsonb,
  ARRAY['n8n', 'notion'],
  '2-3 hours',
  9
),

-- 10. Fitness Tracker Integration
(
  'fitness-tracker-integration',
  'AI Fitness Tracker Integration',
  'AI Fitness Tracker Integration',
  'AI 健身追蹤整合',
  'Sync fitness data from wearables, analyze with AI, and get personalized workout and nutrition recommendations.',
  'Sync fitness data from wearables, analyze with AI, and get personalized workout and nutrition recommendations.',
  '同步穿戴裝置健身數據，使用 AI 分析並獲得個人化運動與營養建議。',
  'intermediate',
  ARRAY['Health', 'Fitness', 'Wearables', 'AI Coach', '健康', '健身', '穿戴裝置', 'AI 教練'],
  ARRAY['Google Fit', 'Supabase', 'OpenAI', 'n8n'],
  '[
    {"step": 1, "description": "Fitness data syncs from Google Fit API", "description_zh": "健身數據從 Google Fit API 同步"},
    {"step": 2, "description": "n8n processes and stores data in Supabase", "description_zh": "n8n 處理並將數據儲存至 Supabase"},
    {"step": 3, "description": "OpenAI analyzes patterns and progress", "description_zh": "OpenAI 分析模式與進度"},
    {"step": 4, "description": "Personalized workout plan is generated", "description_zh": "生成個人化運動計劃"},
    {"step": 5, "description": "Weekly goals and nutrition tips are provided", "description_zh": "提供每週目標與營養建議"}
  ]'::jsonb,
  ARRAY['n8n'],
  '4-5 hours',
  10
);

-- Create indexes for better performance (already done in schema migration, but verifying)
CREATE INDEX IF NOT EXISTS idx_creative_use_cases_display_order ON creative_use_cases(display_order);

/*
  Seed Complete!
  --------------
  10 creative use case examples have been added covering:
  - Mental health & wellness
  - Content creation & marketing
  - Productivity & communication
  - Knowledge management
  - Social media automation
  - Customer service
  - Data analysis
  - Food & lifestyle
  - Education
  - Fitness & health

  Each use case includes bilingual content and can be filtered by:
  - Difficulty level (beginner, intermediate, advanced)
  - Use case tags
  - Tools used
  - Estimated time

  Next Steps:
  -----------
  1. Add export templates for tools used in these use cases
  2. Create tool pairings with strength scores
  3. Test the CreativeUseCasesPage to display these examples
*/
