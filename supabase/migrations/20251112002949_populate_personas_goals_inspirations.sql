/*
  # Populate Persona-Driven Learning Platform Content

  ## Overview
  This migration populates the learning platform with initial content:
  - 5 AI Learning Personas
  - 10 Learning Goals
  - 12 Tool Stacks
  - 12 Inspiration Cases
  - Junction table relationships

  ## Content Summary

  ### Personas
  1. Creative Builder - Content creators and designers
  2. Data Analyst - Data professionals and analysts
  3. AI Tool Designer - AI application builders
  4. Knowledge Manager - Information organizers
  5. Business Developer - Marketing and operations professionals

  ### Goals
  1. Auto Content Publishing - Automated multi-platform content distribution
  2. AI Customer Service - Intelligent customer support automation
  3. Data Pipeline Automation - Automated data collection and processing
  4. Knowledge Base Assistant - AI-powered knowledge search
  5. Marketing Automation - Campaign and email automation
  6. Visual Content Generation - AI-powered design and media
  7. Workflow Automation - Business process automation
  8. Chatbot Development - Conversational AI interfaces
  9. Document Processing - Automated document analysis
  10. Personal AI Assistant - Custom AI helper tools

  ### Tool Stacks
  12 curated stacks combining automation platforms, AI tools, and services

  ### Inspirations
  12 detailed real-world application examples
*/

-- Insert 5 AI Learning Personas
INSERT INTO personas (persona_key, name_en, name_zh_tw, description_en, description_zh_tw, skill_level, learning_focus, icon, display_order)
VALUES
  (
    'creative_builder',
    'Creative Builder',
    '創意開發者',
    'Content creators, designers, and artists who want to enhance creativity and efficiency with AI and automation.',
    '內容創作者、設計師和藝術家，希望用 AI 與自動化增強創造力與效率。',
    'beginner',
    '["Content Generation", "Visual Design", "Automation Workflows"]'::jsonb,
    '🎨',
    1
  ),
  (
    'data_analyst',
    'Data Analyst',
    '資料分析師',
    'Data professionals who want to automate data collection, analysis, and visualization workflows.',
    '資料專業人士，希望自動化資料收集、分析與視覺化工作流程。',
    'intermediate',
    '["Data Processing", "Analytics", "API Integration"]'::jsonb,
    '📊',
    2
  ),
  (
    'ai_tool_designer',
    'AI Tool Designer',
    'AI 工具設計師',
    'Developers and builders creating AI-powered applications and intelligent systems.',
    '開發者與建構者，創建 AI 驅動的應用程式與智能系統。',
    'advanced',
    '["AI Integration", "LLM Applications", "Tool Chaining"]'::jsonb,
    '🤖',
    3
  ),
  (
    'knowledge_manager',
    'Knowledge Manager',
    '知識管理者',
    'Information organizers who want to build intelligent knowledge bases and search systems.',
    '資訊組織者，希望建立智能知識庫與搜尋系統。',
    'intermediate',
    '["Knowledge Organization", "AI Search", "Content Management"]'::jsonb,
    '📚',
    4
  ),
  (
    'business_developer',
    'Business Developer',
    '商業開發者',
    'Marketing and operations professionals automating campaigns, customer engagement, and business processes.',
    '行銷與營運專業人士，自動化活動、客戶互動與商業流程。',
    'beginner',
    '["Marketing Automation", "CRM Integration", "Email Campaigns"]'::jsonb,
    '💼',
    5
  );

-- Insert 10 Learning Goals
INSERT INTO goals (goal_key, title_en, title_zh_tw, description_en, description_zh_tw, difficulty, learning_focus, expected_skills, outcome_en, outcome_zh_tw, display_order)
VALUES
  (
    'auto_content_publish',
    'Automated Content Publishing',
    '自動化內容發布',
    'Automatically adapt and publish content across multiple platforms with AI-powered rewriting.',
    '自動改寫並發布內容至多個平台，使用 AI 驅動的內容改寫。',
    'intermediate',
    '["Workflow Design", "API Integration", "Content Management"]'::jsonb,
    '["Webhook Setup", "API Authentication", "Multi-Platform Publishing"]'::jsonb,
    'Automated multi-platform content distribution system',
    '自動化多平台內容分發系統',
    1
  ),
  (
    'ai_customer_service',
    'AI Customer Service',
    'AI 客服系統',
    'Build an intelligent customer service system with AI-powered responses and ticket routing.',
    '建立智能客服系統，使用 AI 驅動的回覆與工單路由。',
    'intermediate',
    '["Conversational AI", "Integration", "Automation"]'::jsonb,
    '["Chatbot Logic", "API Integration", "Response Templates"]'::jsonb,
    'Intelligent automated customer support',
    '智能自動化客戶支援',
    2
  ),
  (
    'data_pipeline_automation',
    'Data Pipeline Automation',
    '資料管道自動化',
    'Automate data collection, transformation, and storage from multiple sources.',
    '自動化從多個來源收集、轉換與儲存資料。',
    'advanced',
    '["Data Processing", "ETL", "API Integration"]'::jsonb,
    '["Data Transformation", "Scheduled Jobs", "Database Operations"]'::jsonb,
    'Automated data pipeline system',
    '自動化資料管道系統',
    3
  ),
  (
    'knowledge_base_assistant',
    'Knowledge Base AI Assistant',
    '知識庫 AI 助理',
    'Create an AI assistant that can search and answer questions from your knowledge base.',
    '創建可從知識庫搜尋並回答問題的 AI 助理。',
    'intermediate',
    '["AI Integration", "Search", "Knowledge Management"]'::jsonb,
    '["Vector Search", "LLM Prompting", "Content Indexing"]'::jsonb,
    'Intelligent knowledge search assistant',
    '智能知識搜尋助理',
    4
  ),
  (
    'marketing_automation',
    'Marketing Campaign Automation',
    '行銷活動自動化',
    'Automate email campaigns, social media posts, and customer engagement workflows.',
    '自動化電子郵件活動、社群媒體貼文與客戶互動工作流程。',
    'beginner',
    '["Email Marketing", "Social Media", "CRM Integration"]'::jsonb,
    '["Campaign Design", "Segmentation", "Analytics Tracking"]'::jsonb,
    'Automated marketing campaign system',
    '自動化行銷活動系統',
    5
  ),
  (
    'visual_content_generation',
    'AI Visual Content Generation',
    'AI 視覺內容生成',
    'Generate images, graphics, and visual content using AI tools and automation.',
    '使用 AI 工具與自動化生成圖像、圖形與視覺內容。',
    'beginner',
    '["AI Image Generation", "Creative Tools", "Workflow"]'::jsonb,
    '["Prompt Engineering", "Tool Selection", "Creative Direction"]'::jsonb,
    'Automated visual content creation system',
    '自動化視覺內容創作系統',
    6
  ),
  (
    'workflow_automation',
    'Business Workflow Automation',
    '商業工作流程自動化',
    'Automate repetitive business processes, approvals, and notifications.',
    '自動化重複的商業流程、審批與通知。',
    'beginner',
    '["Process Design", "Integration", "Automation"]'::jsonb,
    '["Workflow Mapping", "Trigger Setup", "Notification Systems"]'::jsonb,
    'Automated business process system',
    '自動化商業流程系統',
    7
  ),
  (
    'chatbot_development',
    'Conversational Chatbot Development',
    '對話機器人開發',
    'Build intelligent chatbots for websites, messaging apps, and customer interaction.',
    '為網站、訊息應用程式與客戶互動建立智能聊天機器人。',
    'intermediate',
    '["Conversational Design", "AI Integration", "Deployment"]'::jsonb,
    '["Dialog Flow", "Intent Recognition", "Multi-Platform Deployment"]'::jsonb,
    'Intelligent conversational chatbot',
    '智能對話聊天機器人',
    8
  ),
  (
    'document_processing',
    'Automated Document Processing',
    '自動化文件處理',
    'Extract, analyze, and process information from documents using AI.',
    '使用 AI 從文件中提取、分析與處理資訊。',
    'advanced',
    '["Document Analysis", "OCR", "Data Extraction"]'::jsonb,
    '["Text Extraction", "Pattern Recognition", "Structured Output"]'::jsonb,
    'Automated document processing system',
    '自動化文件處理系統',
    9
  ),
  (
    'personal_ai_assistant',
    'Personal AI Assistant',
    '個人 AI 助理',
    'Create a custom AI assistant tailored to your specific needs and workflows.',
    '創建針對您特定需求與工作流程的自訂 AI 助理。',
    'intermediate',
    '["AI Customization", "Tool Integration", "Personal Productivity"]'::jsonb,
    '["AI Configuration", "Custom Commands", "Integration Setup"]'::jsonb,
    'Custom personal AI assistant',
    '自訂個人 AI 助理',
    10
  );

-- Insert Tool Stacks (to be continued in next part due to size)
INSERT INTO tool_stacks (stack_key, name_en, name_zh_tw, description_en, description_zh_tw, tool_ids, flow_map, difficulty, integration_method, setup_complexity, estimated_time)
VALUES
  (
    'ai_content_stack',
    'AI Content Generation Stack',
    'AI 內容生成堆疊',
    'Combine GPT with automation tools for content creation and distribution.',
    '結合 GPT 與自動化工具進行內容創作與分發。',
    '[]'::jsonb,
    'Notion → n8n → OpenAI → Twitter/Medium',
    'intermediate',
    'API + Webhooks',
    'medium',
    '1-2 hours'
  ),
  (
    'chatbot_stack',
    'No-Code Chatbot Stack',
    '無程式碼聊天機器人堆疊',
    'Build conversational AI without coding using Voiceflow and integration platforms.',
    '使用 Voiceflow 與整合平台建立對話式 AI，無需編程。',
    '[]'::jsonb,
    'Voiceflow → Zapier → Customer Data',
    'beginner',
    'Native Integration',
    'low',
    '2-3 hours'
  ),
  (
    'data_automation_stack',
    'Data Pipeline Stack',
    '資料管道堆疊',
    'Automate data collection, transformation, and storage workflows.',
    '自動化資料收集、轉換與儲存工作流程。',
    '[]'::jsonb,
    'API Sources → n8n → Supabase → Analytics',
    'advanced',
    'API + Database',
    'high',
    '3-4 hours'
  ),
  (
    'knowledge_assistant_stack',
    'Knowledge AI Stack',
    '知識 AI 堆疊',
    'Build an intelligent knowledge base with search and Q&A capabilities.',
    '建立具有搜尋與問答功能的智能知識庫。',
    '[]'::jsonb,
    'Notion → Flowise → OpenAI → Web Interface',
    'intermediate',
    'API + Embeddings',
    'medium',
    '2-3 hours'
  ),
  (
    'marketing_automation_stack',
    'Marketing Automation Stack',
    '行銷自動化堆疊',
    'Automate email campaigns and social media posts.',
    '自動化電子郵件活動與社群媒體貼文。',
    '[]'::jsonb,
    'CRM → Make → Email Service → Social Platforms',
    'beginner',
    'Native + Webhooks',
    'low',
    '1-2 hours'
  ),
  (
    'visual_generation_stack',
    'AI Visual Creation Stack',
    'AI 視覺創作堆疊',
    'Generate and manage visual content with AI tools.',
    '使用 AI 工具生成與管理視覺內容。',
    '[]'::jsonb,
    'Prompt → MidJourney/Runway → Storage → Distribution',
    'beginner',
    'API + Manual',
    'low',
    '1 hour'
  ),
  (
    'workflow_automation_stack',
    'Business Workflow Stack',
    '商業工作流程堆疊',
    'Automate business processes and approvals.',
    '自動化商業流程與審批。',
    '[]'::jsonb,
    'Form → n8n → Database → Notification',
    'beginner',
    'Webhooks',
    'low',
    '1-2 hours'
  ),
  (
    'advanced_chatbot_stack',
    'Advanced AI Chatbot Stack',
    '進階 AI 聊天機器人堆疊',
    'Build sophisticated chatbots with Botpress and custom logic.',
    '使用 Botpress 與自訂邏輯建立複雜的聊天機器人。',
    '[]'::jsonb,
    'Botpress → n8n → Database → Multiple Channels',
    'advanced',
    'API + Custom Code',
    'high',
    '4-6 hours'
  ),
  (
    'document_ai_stack',
    'Document Processing Stack',
    '文件處理堆疊',
    'Extract and analyze document information with AI.',
    '使用 AI 提取與分析文件資訊。',
    '[]'::jsonb,
    'Upload → OpenAI Vision → n8n → Structured Database',
    'advanced',
    'API + OCR',
    'high',
    '3-4 hours'
  ),
  (
    'personal_assistant_stack',
    'Personal AI Assistant Stack',
    '個人 AI 助理堆疊',
    'Create a custom AI assistant with MindStudio or Flowise.',
    '使用 MindStudio 或 Flowise 創建自訂 AI 助理。',
    '[]'::jsonb,
    'MindStudio → Custom Tools → Personal Data',
    'intermediate',
    'Visual Builder',
    'medium',
    '2-3 hours'
  ),
  (
    'multimodal_ai_stack',
    'Multimodal AI Stack',
    '多模態 AI 堆疊',
    'Combine text, image, and voice AI capabilities.',
    '結合文字、圖像與語音 AI 功能。',
    '[]'::jsonb,
    'Input → GPT-4 Vision → Audio API → n8n → Output',
    'advanced',
    'Multiple APIs',
    'high',
    '4-5 hours'
  ),
  (
    'simple_automation_stack',
    'Simple Automation Stack',
    '簡易自動化堆疊',
    'Get started with basic automation using Zapier.',
    '使用 Zapier 開始基礎自動化。',
    '[]'::jsonb,
    'Trigger → Zapier → Action',
    'beginner',
    'Native Connectors',
    'low',
    '30 minutes'
  );

-- Note: Tool IDs will be populated after tools are created
-- Inspirations will be added in the next migration after we have stack IDs