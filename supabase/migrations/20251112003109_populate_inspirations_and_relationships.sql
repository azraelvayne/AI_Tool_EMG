/*
  # Populate Inspirations and Relationships

  ## Overview
  This migration adds:
  - 12 detailed inspiration cases with steps and resources
  - Persona-Goal relationships
  - Goal-Stack relationships
  - Goal-Inspiration relationships

  ## Inspirations
  Real-world application examples showing what can be built with different tool stacks
*/

-- First, get stack IDs for reference (we'll use keys to link)
-- Insert 12 Inspiration Cases
INSERT INTO inspirations (
  inspiration_key,
  title_en,
  title_zh_tw,
  description_en,
  description_zh_tw,
  steps,
  stack_id,
  difficulty,
  estimated_time,
  learning_focus,
  expected_skills,
  resource_links,
  visual_hint,
  display_order
)
SELECT
  'multi_platform_publisher',
  'Multi-Platform Content Publisher',
  '多平台內容發布器',
  'Automatically publish and adapt content across Twitter, Medium, and LinkedIn with AI rewriting.',
  '自動發布並改寫內容至 Twitter、Medium 與 LinkedIn，使用 AI 改寫。',
  '["Write content in Notion", "n8n triggers on new entries", "OpenAI rewrites for each platform", "Auto-post to social platforms", "Track engagement metrics"]'::jsonb,
  ts.id,
  'intermediate',
  '2-3 hours',
  '["Workflow Automation", "API Integration", "Content Strategy"]'::jsonb,
  '["Webhook Configuration", "API Key Management", "Content Adaptation"]'::jsonb,
  '[{"name": "n8n Content Workflow", "url": "https://n8n.io/workflows"}, {"name": "OpenAI API Docs", "url": "https://platform.openai.com/docs"}]'::jsonb,
  'Multi-card content flow',
  1
FROM tool_stacks ts WHERE ts.stack_key = 'ai_content_stack'
UNION ALL
SELECT
  'ai_support_bot',
  'AI Customer Support Bot',
  'AI 客戶支援機器人',
  'Build an intelligent support bot that answers questions and routes complex issues to humans.',
  '建立智能支援機器人，回答問題並將複雜問題路由給人工。',
  '["Set up Voiceflow project", "Design conversation flows", "Connect to knowledge base", "Integrate with Zapier", "Deploy to website"]'::jsonb,
  ts.id,
  'beginner',
  '2-3 hours',
  '["Conversational Design", "No-Code Tools", "Customer Experience"]'::jsonb,
  '["Dialog Design", "Intent Mapping", "Escalation Logic"]'::jsonb,
  '[{"name": "Voiceflow Templates", "url": "https://www.voiceflow.com/templates"}, {"name": "Zapier Integration Guide", "url": "https://zapier.com/apps"}]'::jsonb,
  'Chatbot interface mockup',
  2
FROM tool_stacks ts WHERE ts.stack_key = 'chatbot_stack'
UNION ALL
SELECT
  'automated_data_pipeline',
  'Automated Analytics Pipeline',
  '自動化分析管道',
  'Collect data from multiple sources, transform it, and store in Supabase for analytics.',
  '從多個來源收集資料、轉換並儲存至 Supabase 進行分析。',
  '["Identify data sources", "Configure n8n workflows", "Set up data transformations", "Create Supabase tables", "Schedule automated runs"]'::jsonb,
  ts.id,
  'advanced',
  '4-5 hours',
  '["Data Engineering", "ETL Processes", "Database Design"]'::jsonb,
  '["API Pagination", "Data Cleaning", "SQL Operations"]'::jsonb,
  '[{"name": "n8n Data Workflows", "url": "https://n8n.io"}, {"name": "Supabase Database Guide", "url": "https://supabase.com/docs"}]'::jsonb,
  'Data flow diagram',
  3
FROM tool_stacks ts WHERE ts.stack_key = 'data_automation_stack'
UNION ALL
SELECT
  'smart_knowledge_search',
  'Smart Knowledge Search System',
  '智能知識搜尋系統',
  'Create an AI-powered search that understands natural language questions about your docs.',
  '創建 AI 驅動的搜尋系統，理解關於文件的自然語言問題。',
  '["Organize content in Notion", "Set up Flowise project", "Configure embeddings", "Connect to OpenAI", "Create search interface"]'::jsonb,
  ts.id,
  'intermediate',
  '3-4 hours',
  '["Vector Search", "AI Integration", "Knowledge Architecture"]'::jsonb,
  '["Embedding Generation", "Semantic Search", "Prompt Design"]'::jsonb,
  '[{"name": "Flowise Documentation", "url": "https://docs.flowiseai.com"}, {"name": "OpenAI Embeddings Guide", "url": "https://platform.openai.com"}]'::jsonb,
  'Search interface with results',
  4
FROM tool_stacks ts WHERE ts.stack_key = 'knowledge_assistant_stack'
UNION ALL
SELECT
  'email_campaign_automation',
  'Automated Email Campaign System',
  '自動化電子郵件活動系統',
  'Trigger personalized email campaigns based on customer behavior and segmentation.',
  '根據客戶行為與分群觸發個人化電子郵件活動。',
  '["Set up CRM integration", "Define customer segments", "Create email templates", "Configure Make workflows", "Monitor campaign performance"]'::jsonb,
  ts.id,
  'beginner',
  '2 hours',
  '["Email Marketing", "Customer Segmentation", "Automation Logic"]'::jsonb,
  '["Campaign Design", "Trigger Configuration", "A/B Testing"]'::jsonb,
  '[{"name": "Make Email Automation", "url": "https://www.make.com"}, {"name": "Email Best Practices", "url": "https://mailchimp.com/resources"}]'::jsonb,
  'Email campaign dashboard',
  5
FROM tool_stacks ts WHERE ts.stack_key = 'marketing_automation_stack'
UNION ALL
SELECT
  'ai_image_generator',
  'Automated AI Image Generator',
  '自動化 AI 圖像生成器',
  'Generate branded images automatically based on content using MidJourney or Runway.',
  '基於內容使用 MidJourney 或 Runway 自動生成品牌圖像。',
  '["Define visual style guide", "Create prompt templates", "Set up generation workflow", "Automate storage", "Integrate with content system"]'::jsonb,
  ts.id,
  'beginner',
  '1-2 hours',
  '["AI Art Direction", "Prompt Engineering", "Brand Consistency"]'::jsonb,
  '["Visual Prompting", "Style Consistency", "Asset Management"]'::jsonb,
  '[{"name": "MidJourney Guide", "url": "https://docs.midjourney.com"}, {"name": "Runway Tutorials", "url": "https://runwayml.com/tutorials"}]'::jsonb,
  'Image generation interface',
  6
FROM tool_stacks ts WHERE ts.stack_key = 'visual_generation_stack'
UNION ALL
SELECT
  'approval_workflow',
  'Automated Approval Workflow',
  '自動化審批工作流程',
  'Route requests through approval chains with automatic notifications and tracking.',
  '透過審批鏈路由請求，具有自動通知與追蹤功能。',
  '["Design approval process", "Create form for requests", "Set up n8n workflow", "Configure notification rules", "Add tracking database"]'::jsonb,
  ts.id,
  'beginner',
  '1-2 hours',
  '["Process Mapping", "Business Logic", "Notification Systems"]'::jsonb,
  '["Workflow Design", "Conditional Logic", "Status Tracking"]'::jsonb,
  '[{"name": "n8n Workflow Templates", "url": "https://n8n.io/workflows"}, {"name": "Business Process Automation", "url": "https://n8n.io/blog"}]'::jsonb,
  'Workflow diagram with states',
  7
FROM tool_stacks ts WHERE ts.stack_key = 'workflow_automation_stack'
UNION ALL
SELECT
  'advanced_support_bot',
  'Enterprise AI Support Bot',
  '企業 AI 支援機器人',
  'Build a sophisticated multi-channel support bot with Botpress and custom integrations.',
  '使用 Botpress 與自訂整合建立複雜的多通道支援機器人。',
  '["Design conversation architecture", "Build Botpress flows", "Integrate with CRM", "Connect multiple channels", "Add analytics tracking"]'::jsonb,
  ts.id,
  'advanced',
  '5-6 hours',
  '["Advanced Conversational AI", "System Integration", "Analytics"]'::jsonb,
  '["Complex Dialog Management", "API Integration", "Multi-Channel Deployment"]'::jsonb,
  '[{"name": "Botpress Documentation", "url": "https://botpress.com/docs"}, {"name": "Advanced NLU", "url": "https://botpress.com/blog"}]'::jsonb,
  'Multi-channel bot dashboard',
  8
FROM tool_stacks ts WHERE ts.stack_key = 'advanced_chatbot_stack'
UNION ALL
SELECT
  'document_extractor',
  'Intelligent Document Processor',
  '智能文件處理器',
  'Extract structured data from PDFs and images using AI vision and text analysis.',
  '使用 AI 視覺與文字分析從 PDF 與圖像中提取結構化資料。',
  '["Set up document upload", "Configure OpenAI Vision API", "Design extraction logic", "Structure output data", "Store in database"]'::jsonb,
  ts.id,
  'advanced',
  '4-5 hours',
  '["Document Understanding", "Data Extraction", "Structured Output"]'::jsonb,
  '["OCR Integration", "Pattern Matching", "Data Validation"]'::jsonb,
  '[{"name": "OpenAI Vision API", "url": "https://platform.openai.com/docs/guides/vision"}, {"name": "Document AI Patterns", "url": "https://openai.com/blog"}]'::jsonb,
  'Document processing flow',
  9
FROM tool_stacks ts WHERE ts.stack_key = 'document_ai_stack'
UNION ALL
SELECT
  'personal_productivity_ai',
  'Personal Productivity Assistant',
  '個人生產力助理',
  'Create a custom AI assistant that helps with daily tasks, scheduling, and information lookup.',
  '創建自訂 AI 助理，協助日常任務、排程與資訊查詢。',
  '["Define personal use cases", "Set up MindStudio project", "Connect personal data sources", "Design custom commands", "Deploy and test"]'::jsonb,
  ts.id,
  'intermediate',
  '3 hours',
  '["Personal AI", "Tool Integration", "Productivity Systems"]'::jsonb,
  '["Custom AI Configuration", "Personal Data Management", "Workflow Optimization"]'::jsonb,
  '[{"name": "MindStudio Tutorials", "url": "https://mindstudio.ai"}, {"name": "Personal AI Guide", "url": "https://mindstudio.ai/blog"}]'::jsonb,
  'Personal assistant interface',
  10
FROM tool_stacks ts WHERE ts.stack_key = 'personal_assistant_stack'
UNION ALL
SELECT
  'voice_image_ai',
  'Multimodal AI Application',
  '多模態 AI 應用',
  'Build an app that processes text, images, and voice inputs using multiple AI models.',
  '建立處理文字、圖像與語音輸入的應用程式，使用多個 AI 模型。',
  '["Design multimodal interface", "Configure GPT-4 Vision", "Add audio processing", "Combine outputs with n8n", "Deploy integrated system"]'::jsonb,
  ts.id,
  'advanced',
  '6 hours',
  '["Multimodal AI", "Advanced Integration", "Complex Workflows"]'::jsonb,
  '["Multiple API Management", "Data Format Conversion", "Unified Interface Design"]'::jsonb,
  '[{"name": "GPT-4 Vision Docs", "url": "https://platform.openai.com"}, {"name": "Audio API Guide", "url": "https://platform.openai.com/docs/guides/speech-to-text"}]'::jsonb,
  'Multimodal interface mockup',
  11
FROM tool_stacks ts WHERE ts.stack_key = 'multimodal_ai_stack'
UNION ALL
SELECT
  'quick_automation',
  'Quick Email-to-Spreadsheet Automation',
  '快速電子郵件到試算表自動化',
  'Automatically save email attachments to Google Sheets using Zapier.',
  '使用 Zapier 自動將電子郵件附件儲存至 Google Sheets。',
  '["Connect Gmail to Zapier", "Set up trigger for new emails", "Extract attachment data", "Format for spreadsheet", "Append to Google Sheets"]'::jsonb,
  ts.id,
  'beginner',
  '30 minutes',
  '["Basic Automation", "Tool Connections", "Quick Wins"]'::jsonb,
  '["Trigger Setup", "Data Mapping", "Testing Workflows"]'::jsonb,
  '[{"name": "Zapier Getting Started", "url": "https://zapier.com/learn"}, {"name": "Gmail Integration", "url": "https://zapier.com/apps/gmail"}]'::jsonb,
  'Simple trigger-action flow',
  12
FROM tool_stacks ts WHERE ts.stack_key = 'simple_automation_stack';

-- Create Persona-Goal relationships
INSERT INTO persona_goals (persona_id, goal_id, display_order)
SELECT p.id, g.id, 1
FROM personas p, goals g
WHERE p.persona_key = 'creative_builder' AND g.goal_key = 'auto_content_publish'
UNION ALL
SELECT p.id, g.id, 2
FROM personas p, goals g
WHERE p.persona_key = 'creative_builder' AND g.goal_key = 'visual_content_generation'
UNION ALL
SELECT p.id, g.id, 3
FROM personas p, goals g
WHERE p.persona_key = 'creative_builder' AND g.goal_key = 'workflow_automation'
UNION ALL
SELECT p.id, g.id, 1
FROM personas p, goals g
WHERE p.persona_key = 'data_analyst' AND g.goal_key = 'data_pipeline_automation'
UNION ALL
SELECT p.id, g.id, 2
FROM personas p, goals g
WHERE p.persona_key = 'data_analyst' AND g.goal_key = 'document_processing'
UNION ALL
SELECT p.id, g.id, 3
FROM personas p, goals g
WHERE p.persona_key = 'data_analyst' AND g.goal_key = 'workflow_automation'
UNION ALL
SELECT p.id, g.id, 1
FROM personas p, goals g
WHERE p.persona_key = 'ai_tool_designer' AND g.goal_key = 'chatbot_development'
UNION ALL
SELECT p.id, g.id, 2
FROM personas p, goals g
WHERE p.persona_key = 'ai_tool_designer' AND g.goal_key = 'knowledge_base_assistant'
UNION ALL
SELECT p.id, g.id, 3
FROM personas p, goals g
WHERE p.persona_key = 'ai_tool_designer' AND g.goal_key = 'personal_ai_assistant'
UNION ALL
SELECT p.id, g.id, 1
FROM personas p, goals g
WHERE p.persona_key = 'knowledge_manager' AND g.goal_key = 'knowledge_base_assistant'
UNION ALL
SELECT p.id, g.id, 2
FROM personas p, goals g
WHERE p.persona_key = 'knowledge_manager' AND g.goal_key = 'document_processing'
UNION ALL
SELECT p.id, g.id, 3
FROM personas p, goals g
WHERE p.persona_key = 'knowledge_manager' AND g.goal_key = 'auto_content_publish'
UNION ALL
SELECT p.id, g.id, 1
FROM personas p, goals g
WHERE p.persona_key = 'business_developer' AND g.goal_key = 'marketing_automation'
UNION ALL
SELECT p.id, g.id, 2
FROM personas p, goals g
WHERE p.persona_key = 'business_developer' AND g.goal_key = 'ai_customer_service'
UNION ALL
SELECT p.id, g.id, 3
FROM personas p, goals g
WHERE p.persona_key = 'business_developer' AND g.goal_key = 'workflow_automation';

-- Create Goal-Stack relationships
INSERT INTO goal_stacks (goal_id, stack_id, implementation_type, display_order)
SELECT g.id, ts.id, 'standard', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'auto_content_publish' AND ts.stack_key = 'ai_content_stack'
UNION ALL
SELECT g.id, ts.id, 'no-code', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'ai_customer_service' AND ts.stack_key = 'chatbot_stack'
UNION ALL
SELECT g.id, ts.id, 'developer', 2
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'ai_customer_service' AND ts.stack_key = 'advanced_chatbot_stack'
UNION ALL
SELECT g.id, ts.id, 'standard', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'data_pipeline_automation' AND ts.stack_key = 'data_automation_stack'
UNION ALL
SELECT g.id, ts.id, 'standard', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'knowledge_base_assistant' AND ts.stack_key = 'knowledge_assistant_stack'
UNION ALL
SELECT g.id, ts.id, 'no-code', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'marketing_automation' AND ts.stack_key = 'marketing_automation_stack'
UNION ALL
SELECT g.id, ts.id, 'no-code', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'visual_content_generation' AND ts.stack_key = 'visual_generation_stack'
UNION ALL
SELECT g.id, ts.id, 'no-code', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'workflow_automation' AND ts.stack_key = 'workflow_automation_stack'
UNION ALL
SELECT g.id, ts.id, 'standard', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'chatbot_development' AND ts.stack_key = 'chatbot_stack'
UNION ALL
SELECT g.id, ts.id, 'developer', 2
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'chatbot_development' AND ts.stack_key = 'advanced_chatbot_stack'
UNION ALL
SELECT g.id, ts.id, 'standard', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'document_processing' AND ts.stack_key = 'document_ai_stack'
UNION ALL
SELECT g.id, ts.id, 'standard', 1
FROM goals g, tool_stacks ts
WHERE g.goal_key = 'personal_ai_assistant' AND ts.stack_key = 'personal_assistant_stack';

-- Create Goal-Inspiration relationships
INSERT INTO goal_inspirations (goal_id, inspiration_id, display_order)
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'auto_content_publish' AND i.inspiration_key = 'multi_platform_publisher'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'ai_customer_service' AND i.inspiration_key = 'ai_support_bot'
UNION ALL
SELECT g.id, i.id, 2
FROM goals g, inspirations i
WHERE g.goal_key = 'ai_customer_service' AND i.inspiration_key = 'advanced_support_bot'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'data_pipeline_automation' AND i.inspiration_key = 'automated_data_pipeline'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'knowledge_base_assistant' AND i.inspiration_key = 'smart_knowledge_search'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'marketing_automation' AND i.inspiration_key = 'email_campaign_automation'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'visual_content_generation' AND i.inspiration_key = 'ai_image_generator'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'workflow_automation' AND i.inspiration_key = 'approval_workflow'
UNION ALL
SELECT g.id, i.id, 2
FROM goals g, inspirations i
WHERE g.goal_key = 'workflow_automation' AND i.inspiration_key = 'quick_automation'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'chatbot_development' AND i.inspiration_key = 'ai_support_bot'
UNION ALL
SELECT g.id, i.id, 2
FROM goals g, inspirations i
WHERE g.goal_key = 'chatbot_development' AND i.inspiration_key = 'advanced_support_bot'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'document_processing' AND i.inspiration_key = 'document_extractor'
UNION ALL
SELECT g.id, i.id, 1
FROM goals g, inspirations i
WHERE g.goal_key = 'personal_ai_assistant' AND i.inspiration_key = 'personal_productivity_ai';