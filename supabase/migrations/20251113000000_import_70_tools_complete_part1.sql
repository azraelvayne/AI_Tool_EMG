/*
  # Import 70 Tools - Complete Collection (Part 1 of 2)

  ## Overview
  This migration imports the first 35 tools from the complete 70-tool collection.
  All tools are marked as curated with bilingual support.

  ## Import Strategy
  - Clear existing curated tools from previous incomplete imports
  - Generate source_slug from tool ID (from CSV)
  - Insert tools with Chinese and English metadata
  - Set is_curated=true, curation_batch="v1.2-complete-70"
  - Map categories to 4D classification system

  ## Tools Included (1-35)
  AI Models, LLM Orchestration, Automation, APIs, Databases,
  Design, Cloud, and more

  ## Data Source
  Based on user-provided CSV with 70 unique tools
*/

-- Clear previous incomplete imports (optional - only if needed)
-- DELETE FROM tools WHERE curation_batch = 'v1.1-core-70';

-- Function to generate slug from tool ID
CREATE OR REPLACE FUNCTION generate_tool_slug(tool_id TEXT) RETURNS TEXT AS $$
BEGIN
  RETURN lower(regexp_replace(tool_id, '[^a-zA-Z0-9]+', '-', 'g'));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Insert 70 tools (Part 1: Tools 1-35)
INSERT INTO tools (
  tool_name,
  summary,
  url,
  source_slug,
  is_curated,
  curation_batch,
  categories,
  description_styles,
  popularity_score,
  display_priority,
  is_verified,
  generation_source,
  tags
) VALUES

-- 1. OpenAI
(
  'OpenAI',
  '生成式語言模型與聊天 API',
  'https://openai.com/',
  'openai',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Learning Oriented'),
    'functional_role', jsonb_build_array('AI Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('AI Applications')
  ),
  jsonb_build_object(
    'encyclopedia', '生成式語言模型與聊天 API',
    'guide', 'Generative language model and chat API',
    'strategy', 'Use for text generation, conversation, and AI-powered applications',
    'inspiration', jsonb_build_array()
  ),
  90,
  100,
  true,
  'curated_v1.2',
  ARRAY['AI', 'LLM', 'Chat', 'Text Generation']
),

-- 2. Anthropic Claude
(
  'Anthropic Claude',
  '注重安全的語言模型助手',
  'https://www.anthropic.com/',
  'anthropic',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Learning Oriented'),
    'functional_role', jsonb_build_array('AI Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('AI Applications')
  ),
  jsonb_build_object(
    'encyclopedia', '注重安全的語言模型助手',
    'guide', 'Safe and helpful AI assistant',
    'strategy', 'Use for safe AI conversations with emphasis on ethics',
    'inspiration', jsonb_build_array()
  ),
  85,
  95,
  true,
  'curated_v1.2',
  ARRAY['LLM', 'Safety', 'AI Assistant']
),

-- 3. Google Gemini
(
  'Google Gemini',
  '支援文本與圖像的多模態模型',
  'https://gemini.google.com/',
  'gemini',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Learning Oriented'),
    'functional_role', jsonb_build_array('AI Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('AI Applications', 'Multimodal')
  ),
  jsonb_build_object(
    'encyclopedia', '支援文本與圖像的多模態模型',
    'guide', 'Multimodal AI model by Google',
    'strategy', 'Use for text and image understanding',
    'inspiration', jsonb_build_array()
  ),
  80,
  90,
  true,
  'curated_v1.2',
  ARRAY['Multimodal', 'AI', 'Google']
),

-- 4. Cohere
(
  'Cohere',
  '語意生成與檢索 API',
  'https://cohere.ai/',
  'cohere',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('AI Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('AI Applications', 'Search')
  ),
  jsonb_build_object(
    'encyclopedia', '語意生成與檢索 API',
    'guide', 'Semantic text generation and retrieval API',
    'strategy', 'Use for embedding generation and semantic search',
    'inspiration', jsonb_build_array()
  ),
  70,
  85,
  true,
  'curated_v1.2',
  ARRAY['LLM', 'Embedding', 'Search']
),

-- 5. Mistral AI
(
  'Mistral AI',
  '高效輕量語言模型',
  'https://mistral.ai/',
  'mistral',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Learning Oriented'),
    'functional_role', jsonb_build_array('AI Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('AI Applications')
  ),
  jsonb_build_object(
    'encyclopedia', '高效輕量語言模型',
    'guide', 'Efficient lightweight language models',
    'strategy', 'Use for fast, efficient AI inference',
    'inspiration', jsonb_build_array()
  ),
  75,
  80,
  true,
  'curated_v1.2',
  ARRAY['Open Source', 'LLM', 'Lightweight']
),

-- 6. Hugging Face
(
  'Hugging Face',
  '開放模型與 API 平台',
  'https://huggingface.co/',
  'huggingface',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Platform'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('AI Applications', 'Model Hub')
  ),
  jsonb_build_object(
    'encyclopedia', '開放模型與 API 平台',
    'guide', 'Hub for AI models and APIs',
    'strategy', 'Use for accessing and deploying AI models',
    'inspiration', jsonb_build_array()
  ),
  88,
  92,
  true,
  'curated_v1.2',
  ARRAY['Models', 'AI Hub', 'Transformers']
),

-- 7. Perplexity AI
(
  'Perplexity AI',
  '搜尋驅動的對話式 AI',
  'https://www.perplexity.ai/',
  'perplexity',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('AI Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Search', 'Chat')
  ),
  jsonb_build_object(
    'encyclopedia', '搜尋驅動的對話式 AI',
    'guide', 'Search-based conversational AI',
    'strategy', 'Use for search-augmented question answering',
    'inspiration', jsonb_build_array()
  ),
  72,
  78,
  true,
  'curated_v1.2',
  ARRAY['Search', 'Chat', 'AI']
),

-- 8. LlamaIndex
(
  'LlamaIndex',
  '檢索增強生成框架',
  'https://www.llamaindex.ai/',
  'llamaindex',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Framework'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('RAG', 'Data Indexing')
  ),
  jsonb_build_object(
    'encyclopedia', '檢索增強生成框架',
    'guide', 'Framework for retrieval-augmented generation',
    'strategy', 'Use for building RAG applications with custom data',
    'inspiration', jsonb_build_array()
  ),
  82,
  87,
  true,
  'curated_v1.2',
  ARRAY['RAG', 'Framework', 'Indexing']
),

-- 9. Ollama
(
  'Ollama',
  '本地運行輕量 LLM',
  'https://ollama.ai/',
  'ollama',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Learning Oriented'),
    'functional_role', jsonb_build_array('Local Runtime'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Local AI', 'Offline')
  ),
  jsonb_build_object(
    'encyclopedia', '本地運行輕量 LLM',
    'guide', 'Run local lightweight LLMs',
    'strategy', 'Use for offline or private AI inference',
    'inspiration', jsonb_build_array()
  ),
  78,
  83,
  true,
  'curated_v1.2',
  ARRAY['Local', 'LLM', 'Offline']
),

-- 10. Flowise
(
  'Flowise',
  '低程式化 AI 流程與代理',
  'https://flowiseai.com/',
  'flowise',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Workflow Builder'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('LLM Orchestration', 'Automation')
  ),
  jsonb_build_object(
    'encyclopedia', '低程式化 AI 流程與代理',
    'guide', 'No-code AI flow builder',
    'strategy', 'Use for building AI workflows visually',
    'inspiration', jsonb_build_array()
  ),
  80,
  85,
  true,
  'curated_v1.2',
  ARRAY['LLM', 'Flow', 'No-code']
),

-- 11. Langflow
(
  'Langflow',
  '拖放式 AI 工作流程框架',
  'https://langflow.org/',
  'langflow',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Workflow Builder'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('LLM Orchestration')
  ),
  jsonb_build_object(
    'encyclopedia', '拖放式 AI 工作流程框架',
    'guide', 'Drag-and-drop LLM workflow builder',
    'strategy', 'Use for visually building LLM chains',
    'inspiration', jsonb_build_array()
  ),
  76,
  81,
  true,
  'curated_v1.2',
  ARRAY['LLM', 'Workflow', 'Visual']
),

-- 12. Dify.ai
(
  'Dify.ai',
  '管理 AI 代理與知識庫',
  'https://dify.ai/',
  'dify',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Platform'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('AI Platform', 'Agent Management')
  ),
  jsonb_build_object(
    'encyclopedia', '管理 AI 代理與知識庫',
    'guide', 'AI agent and knowledge base manager',
    'strategy', 'Use for managing AI agents and knowledge bases',
    'inspiration', jsonb_build_array()
  ),
  74,
  79,
  true,
  'curated_v1.2',
  ARRAY['AI Platform', 'Agents', 'Knowledge Base']
),

-- 13. Pipedream
(
  'Pipedream',
  '無伺服器 API 整合平台',
  'https://pipedream.com/',
  'pipedream',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Automation'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Automation', 'API Integration')
  ),
  jsonb_build_object(
    'encyclopedia', '無伺服器 API 整合平台',
    'guide', 'Serverless API integration platform',
    'strategy', 'Use for building serverless workflows',
    'inspiration', jsonb_build_array()
  ),
  73,
  77,
  true,
  'curated_v1.2',
  ARRAY['Automation', 'Serverless', 'API']
),

-- 14. n8n
(
  'n8n',
  '開源可視化自動化平台',
  'https://n8n.io/',
  'n8n',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Automation'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Workflow Automation')
  ),
  jsonb_build_object(
    'encyclopedia', '開源可視化自動化平台',
    'guide', 'Open-source workflow automation',
    'strategy', 'Use for building automated workflows',
    'inspiration', jsonb_build_array()
  ),
  86,
  91,
  true,
  'curated_v1.2',
  ARRAY['Automation', 'Workflow', 'Open Source']
),

-- 15. Make (Integromat)
(
  'Make (Integromat)',
  '視覺化 API 與資料流程',
  'https://www.make.com/',
  'make',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Automation'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Automation', 'API Integration')
  ),
  jsonb_build_object(
    'encyclopedia', '視覺化 API 與資料流程',
    'guide', 'Visual API and data flow automation',
    'strategy', 'Use for visual workflow automation',
    'inspiration', jsonb_build_array()
  ),
  84,
  89,
  true,
  'curated_v1.2',
  ARRAY['Automation', 'Visual', 'Integration']
),

-- 16. Zapier
(
  'Zapier',
  '串接不同 App 的雲端自動化',
  'https://zapier.com/',
  'zapier',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Automation'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Automation')
  ),
  jsonb_build_object(
    'encyclopedia', '串接不同 App 的雲端自動化',
    'guide', 'Cloud automation connector',
    'strategy', 'Use for connecting apps without code',
    'inspiration', jsonb_build_array()
  ),
  92,
  97,
  true,
  'curated_v1.2',
  ARRAY['Automation', 'Integration', 'No-code']
),

-- 17. Apidog
(
  'Apidog',
  'API 設計與測試協作',
  'https://apidog.com/',
  'apidog',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('API Tools'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('API Development')
  ),
  jsonb_build_object(
    'encyclopedia', 'API 設計與測試協作',
    'guide', 'API design and testing tool',
    'strategy', 'Use for API design, testing, and collaboration',
    'inspiration', jsonb_build_array()
  ),
  68,
  73,
  true,
  'curated_v1.2',
  ARRAY['API', 'Testing', 'Design']
),

-- 18. Postman
(
  'Postman',
  'API 測試與協作平台',
  'https://www.postman.com/',
  'postman',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('API Tools'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('API Development', 'Testing')
  ),
  jsonb_build_object(
    'encyclopedia', 'API 測試與協作平台',
    'guide', 'API collaboration and testing platform',
    'strategy', 'Use for API testing and documentation',
    'inspiration', jsonb_build_array()
  ),
  90,
  94,
  true,
  'curated_v1.2',
  ARRAY['API', 'Testing', 'Collaboration']
),

-- 19. Swagger.io
(
  'Swagger.io',
  'REST API 文件生成工具',
  'https://swagger.io/',
  'swagger',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Documentation'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('API Documentation')
  ),
  jsonb_build_object(
    'encyclopedia', 'REST API 文件生成工具',
    'guide', 'REST API documentation tool',
    'strategy', 'Use for generating API documentation',
    'inspiration', jsonb_build_array()
  ),
  82,
  86,
  true,
  'curated_v1.2',
  ARRAY['API', 'Documentation', 'REST']
),

-- 20. AWS Lambda
(
  'AWS Lambda',
  '無伺服器運行程式碼平台',
  'https://aws.amazon.com/lambda/',
  'awslambda',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Compute'),
    'tech_layer', jsonb_build_array('Processing Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Serverless', 'Cloud Computing')
  ),
  jsonb_build_object(
    'encyclopedia', '無伺服器運行程式碼平台',
    'guide', 'Serverless compute platform',
    'strategy', 'Use for running code without managing servers',
    'inspiration', jsonb_build_array()
  ),
  88,
  92,
  true,
  'curated_v1.2',
  ARRAY['Serverless', 'AWS', 'Compute']
),

-- 21. Supabase
(
  'Supabase',
  '開源 Firebase 替代方案',
  'https://supabase.com/',
  'supabase',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Database'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Database', 'Backend')
  ),
  jsonb_build_object(
    'encyclopedia', '開源 Firebase 替代方案',
    'guide', 'Open-source Firebase alternative',
    'strategy', 'Use for building apps with Postgres database',
    'inspiration', jsonb_build_array()
  ),
  91,
  96,
  true,
  'curated_v1.2',
  ARRAY['Database', 'Backend', 'Open Source']
),

-- 22. Airtable
(
  'Airtable',
  '結合試算表與資料庫功能',
  'https://airtable.com/',
  'airtable',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Database'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Database', 'Content Management')
  ),
  jsonb_build_object(
    'encyclopedia', '結合試算表與資料庫功能',
    'guide', 'Spreadsheet-database hybrid',
    'strategy', 'Use for organizing data with spreadsheet interface',
    'inspiration', jsonb_build_array()
  ),
  87,
  90,
  true,
  'curated_v1.2',
  ARRAY['Database', 'Spreadsheet', 'Collaboration']
),

-- 23. Notion
(
  'Notion',
  '筆記與資料庫整合平台',
  'https://notion.so/',
  'notion',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Productivity'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Knowledge Management', 'Collaboration')
  ),
  jsonb_build_object(
    'encyclopedia', '筆記與資料庫整合平台',
    'guide', 'Notes and database workspace',
    'strategy', 'Use for team knowledge management',
    'inspiration', jsonb_build_array()
  ),
  93,
  98,
  true,
  'curated_v1.2',
  ARRAY['Notes', 'Database', 'Workspace']
),

-- 24. Retool
(
  'Retool',
  '拖放式內部應用構建',
  'https://retool.com/',
  'retool',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('App Builder'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Internal Tools')
  ),
  jsonb_build_object(
    'encyclopedia', '拖放式內部應用構建',
    'guide', 'Drag-and-drop internal app builder',
    'strategy', 'Use for building internal tools quickly',
    'inspiration', jsonb_build_array()
  ),
  79,
  84,
  true,
  'curated_v1.2',
  ARRAY['Internal Tools', 'Low-code', 'Dashboard']
),

-- 25. Replit
(
  'Replit',
  '雲端即時 IDE 與部署',
  'https://replit.com/',
  'replit',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Development Environment'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Development', 'Education')
  ),
  jsonb_build_object(
    'encyclopedia', '雲端即時 IDE 與部署',
    'guide', 'Cloud IDE and hosting',
    'strategy', 'Use for coding and deploying apps in browser',
    'inspiration', jsonb_build_array()
  ),
  81,
  86,
  true,
  'curated_v1.2',
  ARRAY['IDE', 'Cloud', 'Development']
),

-- 26. Bubble.io
(
  'Bubble.io',
  '構建 Web 應用與 SaaS',
  'https://bubble.io/',
  'bubble',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('App Builder'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Web Development', 'No-code')
  ),
  jsonb_build_object(
    'encyclopedia', '構建 Web 應用與 SaaS',
    'guide', 'No-code web app builder',
    'strategy', 'Use for building SaaS without code',
    'inspiration', jsonb_build_array()
  ),
  85,
  89,
  true,
  'curated_v1.2',
  ARRAY['No-code', 'Web App', 'SaaS']
),

-- 27. Softr
(
  'Softr',
  '將 Airtable/Sheets 轉網站',
  'https://softr.io/',
  'softr',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Website Builder'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Website', 'No-code')
  ),
  jsonb_build_object(
    'encyclopedia', '將 Airtable/Sheets 轉網站',
    'guide', 'Build websites from Airtable or Sheets',
    'strategy', 'Use for creating websites from data',
    'inspiration', jsonb_build_array()
  ),
  73,
  78,
  true,
  'curated_v1.2',
  ARRAY['No-code', 'Website', 'Airtable']
),

-- 28. Glide
(
  'Glide',
  '用試算表製作行動應用',
  'https://glideapps.com/',
  'glide',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('App Builder'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Mobile Apps', 'No-code')
  ),
  jsonb_build_object(
    'encyclopedia', '用試算表製作行動應用',
    'guide', 'Create mobile apps from spreadsheets',
    'strategy', 'Use for building mobile apps without code',
    'inspiration', jsonb_build_array()
  ),
  76,
  81,
  true,
  'curated_v1.2',
  ARRAY['No-code', 'Mobile', 'Spreadsheet']
),

-- 29. Webflow
(
  'Webflow',
  '視覺化網站設計與 CMS',
  'https://webflow.com/',
  'webflow',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Website Builder'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Web Design', 'CMS')
  ),
  jsonb_build_object(
    'encyclopedia', '視覺化網站設計與 CMS',
    'guide', 'Visual web design and CMS',
    'strategy', 'Use for designing professional websites',
    'inspiration', jsonb_build_array()
  ),
  89,
  93,
  true,
  'curated_v1.2',
  ARRAY['Web Design', 'No-code', 'CMS']
),

-- 30. Figma
(
  'Figma',
  '協作式介面設計平台',
  'https://figma.com/',
  'figma',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Design Tool'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('UI/UX Design')
  ),
  jsonb_build_object(
    'encyclopedia', '協作式介面設計平台',
    'guide', 'Collaborative interface design tool',
    'strategy', 'Use for designing user interfaces',
    'inspiration', jsonb_build_array()
  ),
  94,
  99,
  true,
  'curated_v1.2',
  ARRAY['Design', 'UI/UX', 'Collaboration']
),

-- 31. Canva
(
  'Canva',
  '線上圖像與影片設計',
  'https://canva.com/',
  'canva',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Design Tool'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Graphic Design', 'Marketing')
  ),
  jsonb_build_object(
    'encyclopedia', '線上圖像與影片設計',
    'guide', 'Online design for visuals and videos',
    'strategy', 'Use for creating marketing materials',
    'inspiration', jsonb_build_array()
  ),
  91,
  95,
  true,
  'curated_v1.2',
  ARRAY['Design', 'Graphics', 'Marketing']
),

-- 32. Midjourney
(
  'Midjourney',
  '藝術風格 AI 繪圖',
  'https://midjourney.com/',
  'midjourney',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('AI Generator'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Image Generation', 'Art')
  ),
  jsonb_build_object(
    'encyclopedia', '藝術風格 AI 繪圖',
    'guide', 'AI art and image generation',
    'strategy', 'Use for creating artistic images',
    'inspiration', jsonb_build_array()
  ),
  92,
  97,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Image Generation', 'Art']
),

-- 33. Runway
(
  'Runway',
  'AI 視頻生成與編輯',
  'https://runwayml.com/',
  'runway',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('AI Generator'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Video Generation', 'Editing')
  ),
  jsonb_build_object(
    'encyclopedia', 'AI 視頻生成與編輯',
    'guide', 'AI video generation platform',
    'strategy', 'Use for generating and editing videos with AI',
    'inspiration', jsonb_build_array()
  ),
  84,
  88,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Video', 'Generation']
),

-- 34. Stability AI
(
  'Stability AI',
  '開源圖像合成模型',
  'https://stability.ai/',
  'stability',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Learning Oriented'),
    'functional_role', jsonb_build_array('AI Generator'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Image Generation', 'Open Source')
  ),
  jsonb_build_object(
    'encyclopedia', '開源圖像合成模型',
    'guide', 'Open-source image synthesis models',
    'strategy', 'Use for open-source image generation',
    'inspiration', jsonb_build_array()
  ),
  86,
  90,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Image Generation', 'Open Source']
),

-- 35. Leonardo.ai
(
  'Leonardo.ai',
  '創意藝術生成平台',
  'https://leonardo.ai/',
  'leonardo',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('AI Generator'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Image Generation', 'Art')
  ),
  jsonb_build_object(
    'encyclopedia', '創意藝術生成平台',
    'guide', 'Creative image generation platform',
    'strategy', 'Use for generating creative artwork',
    'inspiration', jsonb_build_array()
  ),
  78,
  83,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Image Generation', 'Art']
)

ON CONFLICT (tool_name) DO UPDATE SET
  summary = EXCLUDED.summary,
  url = EXCLUDED.url,
  source_slug = EXCLUDED.source_slug,
  is_curated = EXCLUDED.is_curated,
  curation_batch = EXCLUDED.curation_batch,
  categories = EXCLUDED.categories,
  description_styles = EXCLUDED.description_styles,
  popularity_score = EXCLUDED.popularity_score,
  display_priority = EXCLUDED.display_priority,
  is_verified = EXCLUDED.is_verified,
  generation_source = EXCLUDED.generation_source,
  tags = EXCLUDED.tags,
  updated_at = now();

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_tools_curated ON tools(is_curated) WHERE is_curated = true;
CREATE INDEX IF NOT EXISTS idx_tools_batch ON tools(curation_batch) WHERE curation_batch IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_tools_source_slug_unique ON tools(source_slug);

-- Drop helper function
DROP FUNCTION IF EXISTS generate_tool_slug(TEXT);

/*
  Import Summary (Part 1):
  ------------------------
  - 35 tools added/updated (Tools 1-35)
  - All marked with is_curated=true
  - Batch identifier: "v1.2-complete-70"
  - Upsert logic: updates existing or inserts new
  - Bilingual support included
  - Categories mapped to 4D classification

  Tools included (1-35):
  - AI Models: OpenAI, Anthropic Claude, Google Gemini, Cohere, Mistral AI, Hugging Face, Perplexity AI
  - LLM Orchestration: LlamaIndex, Ollama, Flowise, Langflow, Dify.ai
  - Automation: Pipedream, n8n, Make, Zapier
  - API Tools: Apidog, Postman, Swagger.io
  - Cloud/Compute: AWS Lambda
  - Databases: Supabase, Airtable, Notion
  - No-code Builders: Retool, Replit, Bubble.io, Softr, Glide, Webflow
  - Design: Figma, Canva
  - AI Image Generation: Midjourney, Runway, Stability AI, Leonardo.ai

  Next Steps:
  -----------
  - Part 2 migration will add the remaining 35 tools (36-70)
  - Add tool translations for bilingual support
  - Create tool pairings
*/
