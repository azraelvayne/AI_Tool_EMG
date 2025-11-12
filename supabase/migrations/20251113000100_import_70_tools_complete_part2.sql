/*
  # Import 70 Tools - Complete Collection (Part 2 of 2)

  ## Overview
  This migration imports the remaining 35 tools (36-70) from the complete collection.
  All tools are marked as curated with bilingual support.

  ## Tools Included (36-70)
  AI Writing, Document QA, Voice Generation, Voice Recognition,
  Sales, CRM, Project Management, Analytics, Database Management,
  ORM, Real-time Communication, LLM Apps, Data Science, Code Assistance

  ## Data Source
  Based on user-provided CSV with 70 unique tools
*/

-- Insert remaining 35 tools (Part 2: Tools 36-70)
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

-- 36. Jasper
(
  'Jasper',
  '行銷與內容生成助手',
  'https://jasper.ai/',
  'jasper',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('AI Writing'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Marketing', 'Writing')
  ),
  jsonb_build_object(
    'encyclopedia', '行銷與內容生成助手',
    'guide', 'Marketing copy and writing AI',
    'strategy', 'Use for generating marketing content',
    'inspiration', jsonb_build_array()
  ),
  79,
  84,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Writing', 'Marketing']
),

-- 37. Grammarly
(
  'Grammarly',
  '文法與風格校正工具',
  'https://grammarly.com/',
  'grammarly',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Writing Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Writing', 'Editing')
  ),
  jsonb_build_object(
    'encyclopedia', '文法與風格校正工具',
    'guide', 'Grammar and style checker',
    'strategy', 'Use for improving writing quality',
    'inspiration', jsonb_build_array()
  ),
  88,
  92,
  true,
  'curated_v1.2',
  ARRAY['Writing', 'Grammar', 'Editing']
),

-- 38. ChatPDF
(
  'ChatPDF',
  '對 PDF 提問與摘要',
  'https://chatpdf.com/',
  'chatpdf',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Document QA'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Document Analysis', 'QA')
  ),
  jsonb_build_object(
    'encyclopedia', '對 PDF 提問與摘要',
    'guide', 'Ask and summarize PDF content',
    'strategy', 'Use for extracting insights from PDFs',
    'inspiration', jsonb_build_array()
  ),
  77,
  82,
  true,
  'curated_v1.2',
  ARRAY['PDF', 'QA', 'Document']
),

-- 39. DocGPT
(
  'DocGPT',
  '從文件中提取答案',
  'https://docgpt.ai/',
  'docgpt',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Document QA'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Document Analysis')
  ),
  jsonb_build_object(
    'encyclopedia', '從文件中提取答案',
    'guide', 'Extract answers from documents',
    'strategy', 'Use for document question answering',
    'inspiration', jsonb_build_array()
  ),
  72,
  77,
  true,
  'curated_v1.2',
  ARRAY['Document', 'QA', 'AI']
),

-- 40. Voiceflow
(
  'Voiceflow',
  '設計與原型語音機器人',
  'https://voiceflow.com/',
  'voiceflow',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Voice Design'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Voice Bots', 'Chatbots')
  ),
  jsonb_build_object(
    'encyclopedia', '設計與原型語音機器人',
    'guide', 'Voice and chatbot design tool',
    'strategy', 'Use for designing conversational interfaces',
    'inspiration', jsonb_build_array()
  ),
  75,
  80,
  true,
  'curated_v1.2',
  ARRAY['Voice', 'Chatbot', 'Design']
),

-- 41. Retell AI
(
  'Retell AI',
  'AI 智能電話客服',
  'https://retellai.com/',
  'retell',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Voice AI'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Voice', 'Customer Service')
  ),
  jsonb_build_object(
    'encyclopedia', 'AI 智能電話客服',
    'guide', 'AI voice call automation',
    'strategy', 'Use for AI-powered phone support',
    'inspiration', jsonb_build_array()
  ),
  71,
  76,
  true,
  'curated_v1.2',
  ARRAY['Voice', 'AI', 'Customer Service']
),

-- 42. ElevenLabs
(
  'ElevenLabs',
  '高品質語音合成',
  'https://elevenlabs.io/',
  'elevenlabs',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Voice Generation'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Voice Synthesis', 'TTS')
  ),
  jsonb_build_object(
    'encyclopedia', '高品質語音合成',
    'guide', 'High-quality voice synthesis',
    'strategy', 'Use for text-to-speech with natural voices',
    'inspiration', jsonb_build_array()
  ),
  83,
  87,
  true,
  'curated_v1.2',
  ARRAY['Voice', 'TTS', 'AI']
),

-- 43. Vapi.ai
(
  'Vapi.ai',
  '語音 AI 助手 API',
  'https://vapi.ai/',
  'vapi',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Voice API'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Voice Agents', 'API')
  ),
  jsonb_build_object(
    'encyclopedia', '語音 AI 助手 API',
    'guide', 'Voice agent API',
    'strategy', 'Use for building voice AI applications',
    'inspiration', jsonb_build_array()
  ),
  74,
  79,
  true,
  'curated_v1.2',
  ARRAY['Voice', 'API', 'AI']
),

-- 44. Notta.ai
(
  'Notta.ai',
  '語音轉錄與摘要',
  'https://notta.ai/',
  'notta',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Transcription'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Transcription', 'Voice')
  ),
  jsonb_build_object(
    'encyclopedia', '語音轉錄與摘要',
    'guide', 'Audio transcription and summarization',
    'strategy', 'Use for transcribing audio to text',
    'inspiration', jsonb_build_array()
  ),
  76,
  81,
  true,
  'curated_v1.2',
  ARRAY['Transcription', 'Voice', 'AI']
),

-- 45. AssemblyAI
(
  'AssemblyAI',
  '語音辨識與分析 API',
  'https://www.assemblyai.com/',
  'assemblyai',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Voice Recognition'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Speech-to-Text', 'API')
  ),
  jsonb_build_object(
    'encyclopedia', '語音辨識與分析 API',
    'guide', 'Speech-to-text and analysis API',
    'strategy', 'Use for speech recognition in applications',
    'inspiration', jsonb_build_array()
  ),
  80,
  85,
  true,
  'curated_v1.2',
  ARRAY['Speech-to-Text', 'API', 'AI']
),

-- 46. Inkeep
(
  'Inkeep',
  '嵌入知識庫的 AI 搜尋',
  'https://inkeep.com/',
  'inkeep',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('AI Search'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Search', 'Knowledge Base')
  ),
  jsonb_build_object(
    'encyclopedia', '嵌入知識庫的 AI 搜尋',
    'guide', 'Embedded AI search for docs',
    'strategy', 'Use for AI-powered documentation search',
    'inspiration', jsonb_build_array()
  ),
  70,
  75,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Search', 'Knowledge Base']
),

-- 47. Stack Overflow
(
  'Stack Overflow',
  '程式開發問答平台',
  'https://stackoverflow.com/',
  'stackoverflow',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Community'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Developer Community', 'Q&A')
  ),
  jsonb_build_object(
    'encyclopedia', '程式開發問答平台',
    'guide', 'Developer Q&A platform',
    'strategy', 'Use for finding coding solutions',
    'inspiration', jsonb_build_array()
  ),
  95,
  100,
  true,
  'curated_v1.2',
  ARRAY['Developer', 'Q&A', 'Community']
),

-- 48. Kluster.ai
(
  'Kluster.ai',
  '自動化客戶研究',
  'https://kluster.ai/',
  'kluster',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Sales AI'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Sales', 'Research')
  ),
  jsonb_build_object(
    'encyclopedia', '自動化客戶研究',
    'guide', 'Sales prospect research automation',
    'strategy', 'Use for automated lead research',
    'inspiration', jsonb_build_array()
  ),
  68,
  73,
  true,
  'curated_v1.2',
  ARRAY['Sales', 'AI', 'Research']
),

-- 49. Apollo.io
(
  'Apollo.io',
  '潛在客戶推廣與 CRM 整合',
  'https://apollo.io/',
  'apollo',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Sales Automation'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Sales', 'CRM')
  ),
  jsonb_build_object(
    'encyclopedia', '潛在客戶推廣與 CRM 整合',
    'guide', 'Lead generation and CRM automation',
    'strategy', 'Use for sales outreach and prospecting',
    'inspiration', jsonb_build_array()
  ),
  81,
  86,
  true,
  'curated_v1.2',
  ARRAY['Sales', 'CRM', 'Lead Generation']
),

-- 50. Salesforce CRM
(
  'Salesforce CRM',
  '客戶關係管理與自動化',
  'https://www.salesforce.com/',
  'salesforce',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('CRM'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('CRM', 'Sales')
  ),
  jsonb_build_object(
    'encyclopedia', '客戶關係管理與自動化',
    'guide', 'Customer relationship management',
    'strategy', 'Use for managing customer relationships',
    'inspiration', jsonb_build_array()
  ),
  93,
  98,
  true,
  'curated_v1.2',
  ARRAY['CRM', 'Sales', 'Enterprise']
),

-- 51. Monday.com
(
  'Monday.com',
  '團隊任務與流程管理',
  'https://monday.com/',
  'monday',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Project Management'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Project Management', 'Collaboration')
  ),
  jsonb_build_object(
    'encyclopedia', '團隊任務與流程管理',
    'guide', 'Team and project management',
    'strategy', 'Use for managing team workflows',
    'inspiration', jsonb_build_array()
  ),
  85,
  89,
  true,
  'curated_v1.2',
  ARRAY['Project Management', 'Collaboration', 'Workflow']
),

-- 52. ClickUp
(
  'ClickUp',
  '整合任務與生產力工具',
  'https://clickup.com/',
  'clickup',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Project Management'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Project Management', 'Productivity')
  ),
  jsonb_build_object(
    'encyclopedia', '整合任務與生產力工具',
    'guide', 'All-in-one productivity platform',
    'strategy', 'Use for comprehensive project management',
    'inspiration', jsonb_build_array()
  ),
  87,
  91,
  true,
  'curated_v1.2',
  ARRAY['Project Management', 'Productivity', 'Tasks']
),

-- 53. Trello
(
  'Trello',
  '看板式任務管理',
  'https://trello.com/',
  'trello',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Project Management'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Project Management', 'Kanban')
  ),
  jsonb_build_object(
    'encyclopedia', '看板式任務管理',
    'guide', 'Kanban-style task management',
    'strategy', 'Use for visual project tracking',
    'inspiration', jsonb_build_array()
  ),
  89,
  93,
  true,
  'curated_v1.2',
  ARRAY['Project Management', 'Kanban', 'Tasks']
),

-- 54. Linear
(
  'Linear',
  '軟體專案與議題追蹤',
  'https://linear.app/',
  'linear',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Project Management'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'No-code',
    'application_field', jsonb_build_array('Project Management', 'Issue Tracking')
  ),
  jsonb_build_object(
    'encyclopedia', '軟體專案與議題追蹤',
    'guide', 'Software project tracking',
    'strategy', 'Use for agile software development',
    'inspiration', jsonb_build_array()
  ),
  82,
  86,
  true,
  'curated_v1.2',
  ARRAY['Project Management', 'Agile', 'Software']
),

-- 55. Jira
(
  'Jira',
  '敏捷專案追蹤工具',
  'https://www.atlassian.com/software/jira',
  'jira',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Project Management'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Project Management', 'Agile')
  ),
  jsonb_build_object(
    'encyclopedia', '敏捷專案追蹤工具',
    'guide', 'Agile project management',
    'strategy', 'Use for managing software development projects',
    'inspiration', jsonb_build_array()
  ),
  90,
  94,
  true,
  'curated_v1.2',
  ARRAY['Project Management', 'Agile', 'Jira']
),

-- 56. Metabase
(
  'Metabase',
  '開源數據分析與 BI',
  'https://www.metabase.com/',
  'metabase',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Analytics'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Analytics', 'BI')
  ),
  jsonb_build_object(
    'encyclopedia', '開源數據分析與 BI',
    'guide', 'Open-source data analytics and BI',
    'strategy', 'Use for building data dashboards',
    'inspiration', jsonb_build_array()
  ),
  79,
  84,
  true,
  'curated_v1.2',
  ARRAY['Analytics', 'BI', 'Open Source']
),

-- 57. Apache Superset
(
  'Apache Superset',
  '數據探索與儀表板',
  'https://superset.apache.org/',
  'superset',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Analytics'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Analytics', 'Dashboards')
  ),
  jsonb_build_object(
    'encyclopedia', '數據探索與儀表板',
    'guide', 'Data exploration and dashboards',
    'strategy', 'Use for enterprise data visualization',
    'inspiration', jsonb_build_array()
  ),
  77,
  82,
  true,
  'curated_v1.2',
  ARRAY['Analytics', 'Dashboards', 'Open Source']
),

-- 58. Hex
(
  'Hex',
  '協作式分析筆記平台',
  'https://hex.tech/',
  'hex',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Data Notebooks'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Data Science', 'Analytics')
  ),
  jsonb_build_object(
    'encyclopedia', '協作式分析筆記平台',
    'guide', 'Collaborative data notebooks',
    'strategy', 'Use for data analysis and collaboration',
    'inspiration', jsonb_build_array()
  ),
  75,
  80,
  true,
  'curated_v1.2',
  ARRAY['Data Science', 'Notebooks', 'Analytics']
),

-- 59. dbdiagram.io
(
  'dbdiagram.io',
  '繪製資料庫 ER 圖工具',
  'https://dbdiagram.io/',
  'dbdiagram',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Database Design'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Database Design', 'ER Diagram')
  ),
  jsonb_build_object(
    'encyclopedia', '繪製資料庫 ER 圖工具',
    'guide', 'Database ER diagram tool',
    'strategy', 'Use for designing database schemas',
    'inspiration', jsonb_build_array()
  ),
  73,
  78,
  true,
  'curated_v1.2',
  ARRAY['Database', 'Design', 'ER Diagram']
),

-- 60. DataGrip
(
  'DataGrip',
  'SQL 與資料庫 IDE',
  'https://www.jetbrains.com/datagrip/',
  'datagrip',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Database Management'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Database', 'SQL')
  ),
  jsonb_build_object(
    'encyclopedia', 'SQL 與資料庫 IDE',
    'guide', 'SQL IDE for databases',
    'strategy', 'Use for database management and queries',
    'inspiration', jsonb_build_array()
  ),
  80,
  85,
  true,
  'curated_v1.2',
  ARRAY['Database', 'SQL', 'IDE']
),

-- 61. Prisma
(
  'Prisma',
  '型別安全資料庫客戶端',
  'https://www.prisma.io/',
  'prisma',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('ORM'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('ORM', 'Database')
  ),
  jsonb_build_object(
    'encyclopedia', '型別安全資料庫客戶端',
    'guide', 'Type-safe ORM for Node.js',
    'strategy', 'Use for database access with TypeScript',
    'inspiration', jsonb_build_array()
  ),
  84,
  88,
  true,
  'curated_v1.2',
  ARRAY['ORM', 'TypeScript', 'Database']
),

-- 62. Drizzle ORM
(
  'Drizzle ORM',
  '輕量 TypeScript ORM',
  'https://orm.drizzle.team/',
  'drizzle',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('ORM'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('ORM', 'Database')
  ),
  jsonb_build_object(
    'encyclopedia', '輕量 TypeScript ORM',
    'guide', 'Lightweight TypeScript ORM',
    'strategy', 'Use for type-safe database queries',
    'inspiration', jsonb_build_array()
  ),
  78,
  83,
  true,
  'curated_v1.2',
  ARRAY['ORM', 'TypeScript', 'Lightweight']
),

-- 63. Livekit
(
  'Livekit',
  '構建即時音訊與視訊應用',
  'https://livekit.io/',
  'livekit',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Real-time Communication'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Video', 'Real-time')
  ),
  jsonb_build_object(
    'encyclopedia', '構建即時音訊與視訊應用',
    'guide', 'Real-time audio/video SDK',
    'strategy', 'Use for building video conferencing apps',
    'inspiration', jsonb_build_array()
  ),
  76,
  81,
  true,
  'curated_v1.2',
  ARRAY['Real-time', 'Video', 'Audio']
),

-- 64. Dyad.sh
(
  'Dyad.sh',
  'AI 代理微服務部署平台',
  'https://dyad.sh/',
  'dyad',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('Deployment'),
    'tech_layer', jsonb_build_array('Integration Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Agent Deployment', 'Microservices')
  ),
  jsonb_build_object(
    'encyclopedia', 'AI 代理微服務部署平台',
    'guide', 'Agent microservice deployment',
    'strategy', 'Use for deploying AI agents',
    'inspiration', jsonb_build_array()
  ),
  70,
  75,
  true,
  'curated_v1.2',
  ARRAY['Deployment', 'Agents', 'Microservices']
),

-- 65. Chainlit
(
  'Chainlit',
  'Python 對話式 LLM 框架',
  'https://chainlit.io/',
  'chainlit',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('System Oriented'),
    'functional_role', jsonb_build_array('LLM Framework'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('LLM Apps', 'Python')
  ),
  jsonb_build_object(
    'encyclopedia', 'Python 對話式 LLM 框架',
    'guide', 'Conversational LLM framework',
    'strategy', 'Use for building chat applications in Python',
    'inspiration', jsonb_build_array()
  ),
  74,
  79,
  true,
  'curated_v1.2',
  ARRAY['LLM', 'Python', 'Chat']
),

-- 66. Gradio
(
  'Gradio',
  '建立互動式 ML 網頁介面',
  'https://gradio.app/',
  'gradio',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('ML Interface'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('ML Apps', 'UI')
  ),
  jsonb_build_object(
    'encyclopedia', '建立互動式 ML 網頁介面',
    'guide', 'Interactive ML app builder',
    'strategy', 'Use for creating ML demos and interfaces',
    'inspiration', jsonb_build_array()
  ),
  81,
  86,
  true,
  'curated_v1.2',
  ARRAY['ML', 'UI', 'Python']
),

-- 67. DALL·E 3
(
  'DALL·E 3',
  '文字到圖像模型',
  'https://openai.com/dall-e-3',
  'dalle3',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('AI Generator'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Low-code',
    'application_field', jsonb_build_array('Image Generation', 'AI')
  ),
  jsonb_build_object(
    'encyclopedia', '文字到圖像模型',
    'guide', 'Text-to-image generation model',
    'strategy', 'Use for generating images from text',
    'inspiration', jsonb_build_array()
  ),
  91,
  96,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Image Generation', 'OpenAI']
),

-- 68. HuggingFace Spaces
(
  'HuggingFace Spaces',
  '托管 ML Demo 與互動應用',
  'https://huggingface.co/spaces',
  'hfspaces',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('ML Hosting'),
    'tech_layer', jsonb_build_array('Frontend Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('ML Apps', 'Hosting')
  ),
  jsonb_build_object(
    'encyclopedia', '托管 ML Demo 與互動應用',
    'guide', 'Host ML demos and apps',
    'strategy', 'Use for deploying ML models',
    'inspiration', jsonb_build_array()
  ),
  83,
  87,
  true,
  'curated_v1.2',
  ARRAY['ML', 'Hosting', 'Hugging Face']
),

-- 69. Kaggle
(
  'Kaggle',
  '競賽與資料集平台',
  'https://www.kaggle.com/',
  'kaggle',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Data Science Platform'),
    'tech_layer', jsonb_build_array('Data Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Data Science', 'Competitions')
  ),
  jsonb_build_object(
    'encyclopedia', '競賽與資料集平台',
    'guide', 'Data science competitions and datasets',
    'strategy', 'Use for data science learning and competitions',
    'inspiration', jsonb_build_array()
  ),
  87,
  91,
  true,
  'curated_v1.2',
  ARRAY['Data Science', 'Competitions', 'Datasets']
),

-- 70. GitHub Copilot
(
  'GitHub Copilot',
  '編輯器內 AI 程式助手',
  'https://github.com/features/copilot',
  'copilot',
  true,
  'v1.2-complete-70',
  jsonb_build_object(
    'purpose', jsonb_build_array('Application Oriented'),
    'functional_role', jsonb_build_array('Code Assistant'),
    'tech_layer', jsonb_build_array('AI Layer'),
    'difficulty', 'Developer',
    'application_field', jsonb_build_array('Coding', 'AI')
  ),
  jsonb_build_object(
    'encyclopedia', '編輯器內 AI 程式助手',
    'guide', 'AI coding assistant',
    'strategy', 'Use for AI-powered code completion',
    'inspiration', jsonb_build_array()
  ),
  94,
  99,
  true,
  'curated_v1.2',
  ARRAY['AI', 'Coding', 'GitHub']
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

/*
  Import Summary (Part 2):
  ------------------------
  - 35 tools added/updated (Tools 36-70)
  - All marked with is_curated=true
  - Batch identifier: "v1.2-complete-70"
  - Upsert logic: updates existing or inserts new
  - Bilingual support included
  - Categories mapped to 4D classification

  Tools included (36-70):
  - AI Writing: Jasper, Grammarly
  - Document QA: ChatPDF, DocGPT
  - Voice/Speech: Voiceflow, Retell AI, ElevenLabs, Vapi.ai, Notta.ai, AssemblyAI
  - AI Search: Inkeep
  - Community: Stack Overflow
  - Sales/CRM: Kluster.ai, Apollo.io, Salesforce CRM
  - Project Management: Monday.com, ClickUp, Trello, Linear, Jira
  - Analytics: Metabase, Apache Superset, Hex
  - Database Tools: dbdiagram.io, DataGrip, Prisma, Drizzle ORM
  - Real-time: Livekit
  - Deployment: Dyad.sh
  - LLM Apps: Chainlit, Gradio
  - Image Gen: DALL·E 3
  - Platforms: HuggingFace Spaces, Kaggle
  - Code Assistant: GitHub Copilot

  Total Tools Imported:
  ---------------------
  Part 1: 35 tools (1-35)
  Part 2: 35 tools (36-70)
  Total: 70 tools complete!

  Next Steps:
  -----------
  - Add tool translations for all 70 tools
  - Create tool pairings based on common use cases
  - Import 70 creative use case stacks
  - Update 4D classification mappings
*/
