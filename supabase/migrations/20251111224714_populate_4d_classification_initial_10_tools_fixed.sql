/*
  # Populate 4D Classification for Initial 10 Tools
  
  ## Summary
  This migration populates the 4D classification system (Layer, Category, Use Case, Integration)
  for the initial 10 tools in the database to establish the knowledge graph foundation.
  
  ## 4D Classification Dimensions
  
  ### Dimension 1: Layer (tool_layers)
  Technical layer where the tool operates:
  - Data: Storage and database layers
  - Processing: Transformation and computation
  - AI: Artificial intelligence and machine learning
  - Frontend: User interface and presentation
  - Integration: Connectivity and orchestration
  
  ### Dimension 2: Category (tool_category_mapping)
  n8n ecosystem categories (18 total):
  - AI/LLM: Language models and AI services
  - Automation: Workflow automation platforms
  - Cloud Storage: File storage and management
  - CMS: Content management systems
  - Communication: Messaging and communication tools
  - Database: Data storage solutions
  - Web Development: Website and app builders
  
  ### Dimension 3: Use Case (tool_usecases)
  Real-world application scenarios with:
  - Use case name and description
  - Difficulty level (beginner/intermediate/advanced)
  - Estimated setup time
  - Target user personas
  
  ### Dimension 4: Integration (tool_integrations)
  Platform compatibility and integration methods:
  - n8n, Zapier, Make (automation platforms)
  - Flowise (LLM orchestration)
  - REST API (direct API access)
  - Integration types: trigger, action, bi-directional, webhook, api
  
  ## Tools Being Classified
  1. Notion - Knowledge management
  2. Supabase - Database and backend
  3. n8n - Workflow automation
  4. OpenAI - AI language models
  5. Claude - AI assistant
  6. Airtable - Collaborative database
  7. Make - Visual automation
  8. Webflow - Web development
  9. Glide - No-code app builder
  10. Flowise - LLM orchestration
  
  ## Changes Made
  - Assigns Layer tags to all 10 tools
  - Maps tools to n8n categories
  - Creates initial use case scenarios (2-3 per tool)
  - Defines integration compatibility for each tool
*/

-- ============================================================================
-- DIMENSION 1: LAYER CLASSIFICATION
-- ============================================================================

-- Notion: Data + Frontend (content management and UI)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Data', 1 FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Frontend', 2 FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

-- Supabase: Data + Processing (database and backend logic)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Data', 1 FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Processing', 2 FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

-- n8n: Integration + Processing (workflow orchestration)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Integration', 1 FROM tools WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Processing', 2 FROM tools WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;

-- OpenAI: AI + Processing (AI models and computation)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'AI', 1 FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Processing', 2 FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

-- Claude: AI (AI assistant)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'AI', 1 FROM tools WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;

-- Airtable: Data + Frontend (database with UI)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Data', 1 FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Frontend', 2 FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

-- Make: Integration + Processing (automation platform)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Integration', 1 FROM tools WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Processing', 2 FROM tools WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;

-- Webflow: Frontend (web design and hosting)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Frontend', 1 FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

-- Glide: Frontend + Data (no-code apps with data)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Frontend', 1 FROM tools WHERE tool_name = 'Glide'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Data', 2 FROM tools WHERE tool_name = 'Glide'
ON CONFLICT DO NOTHING;

-- Flowise: AI + Integration (LLM orchestration)
INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'AI', 1 FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

INSERT INTO tool_layers (tool_id, layer, display_order)
SELECT id, 'Integration', 2 FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

-- ============================================================================
-- DIMENSION 2: n8n CATEGORY CLASSIFICATION
-- ============================================================================

-- Notion: CMS + Collaboration
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'CMS', 'Knowledge Management', ARRAY['notes', 'wiki', 'database', 'collaboration', 'productivity']
FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Communication', 'Collaboration', ARRAY['team', 'workspace', 'project-management']
FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

-- Supabase: Database + Backend
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Database', 'PostgreSQL Backend', ARRAY['postgresql', 'auth', 'storage', 'realtime', 'open-source']
FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

-- n8n: Automation
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Automation', 'Workflow Orchestration', ARRAY['no-code', 'self-hosted', 'open-source', 'workflows', 'integration']
FROM tools WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;

-- OpenAI: AI/LLM
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'AI/LLM', 'Language Models', ARRAY['gpt', 'text-generation', 'image-generation', 'api', 'dall-e']
FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

-- Claude: AI/LLM
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'AI/LLM', 'AI Assistant', ARRAY['anthropic', 'long-context', 'reasoning', 'analysis', 'api']
FROM tools WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;

-- Airtable: Database + CMS
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Database', 'Cloud Database', ARRAY['spreadsheet', 'relational', 'collaboration', 'api', 'no-code']
FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'CMS', 'Content Database', ARRAY['content-management', 'flexible-schema']
FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

-- Make: Automation
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Automation', 'Visual Automation', ARRAY['integromat', 'no-code', 'workflows', 'enterprise', 'data-transformation']
FROM tools WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;

-- Webflow: Web Development
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Web Development', 'No-Code Website Builder', ARRAY['visual-design', 'cms', 'hosting', 'responsive', 'professional']
FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

-- Glide: Web Development + No-Code
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Web Development', 'No-Code App Builder', ARRAY['mobile-apps', 'spreadsheet-to-app', 'pwa', 'rapid-prototyping']
FROM tools WHERE tool_name = 'Glide'
ON CONFLICT DO NOTHING;

-- Flowise: AI/LLM + Automation
INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'AI/LLM', 'LLM Orchestration', ARRAY['langchain', 'chatbot', 'vector-db', 'open-source', 'no-code']
FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

INSERT INTO tool_category_mapping (tool_id, n8n_category, sub_category, tags)
SELECT id, 'Automation', 'AI Workflow Builder', ARRAY['agents', 'chains', 'embeddings']
FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

-- ============================================================================
-- DIMENSION 3: USE CASE SCENARIOS
-- ============================================================================

-- Notion Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'ai-knowledge-base', 'AI-Powered Knowledge Base', 
'Build an intelligent knowledge management system where Notion stores documentation, meeting notes, and research. Connect with AI to auto-summarize articles, generate tags, and link related content automatically.',
'beginner', '1-2 hours', 1
FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'content-pipeline', 'Automated Content Pipeline', 
'Create a content creation workflow in Notion that triggers AI writing assistance, tracks editorial stages, and publishes to multiple platforms. Ideal for content teams and bloggers.',
'intermediate', '3-4 hours', 2
FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

-- Supabase Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'ai-chat-app', 'AI Chatbot with Conversation History', 
'Build a multi-user chatbot application using Supabase for user authentication, conversation storage, and real-time updates. Store chat history with vector embeddings for semantic search.',
'intermediate', '4-6 hours', 1
FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'document-qna', 'Document Q&A System', 
'Create a document knowledge base where users upload PDFs, Supabase stores the content with pgvector embeddings, and AI answers questions based on the documents.',
'advanced', '1 day', 2
FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

-- n8n Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'content-summarizer', 'Auto Content Summarization Workflow', 
'Monitor RSS feeds or Notion pages, extract content, process through AI for summarization, and post results to Slack or update databases. Perfect for staying informed without information overload.',
'beginner', '1-2 hours', 1
FROM tools WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'customer-support-bot', 'AI Customer Support Automation', 
'Build an intelligent support system that triages emails, generates AI responses for common issues, escalates complex cases to humans, and logs everything to your CRM.',
'intermediate', '4-5 hours', 2
FROM tools WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;

-- OpenAI Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'code-documentation', 'Automated Code Documentation Generator', 
'Analyze GitHub repositories, extract code structure and comments, use GPT-4 to generate comprehensive documentation, and publish to Notion or static sites. Saves hours of technical writing.',
'intermediate', '3-4 hours', 1
FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'content-personalization', 'Dynamic Content Personalization Engine', 
'Generate personalized email copy, product descriptions, or landing page text based on user data and preferences. Integrates with marketing automation tools.',
'advanced', '1 day', 2
FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

-- Claude Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'research-analyzer', 'Academic Research Paper Analyzer', 
'Upload research papers or long documents to Claude (up to 200K tokens), extract key findings, methodology, citations, and generate summaries. Ideal for researchers and students.',
'beginner', '1 hour', 1
FROM tools WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'legal-document-review', 'Contract and Legal Document Review', 
'Analyze contracts, identify key clauses, flag potential issues, and compare versions. Claude''s extended context window handles entire legal documents at once.',
'intermediate', '2-3 hours', 2
FROM tools WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;

-- Airtable Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'ai-content-calendar', 'AI-Powered Content Calendar', 
'Manage content creation workflow in Airtable, use AI to generate topic ideas and SEO keywords, track articles through drafting, editing, and publishing stages with automation.',
'beginner', '2 hours', 1
FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'crm-enrichment', 'Automated CRM Data Enrichment', 
'Build a lightweight CRM in Airtable that automatically enriches contact information, scores leads with AI, and triggers follow-up workflows based on engagement.',
'intermediate', '3-4 hours', 2
FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

-- Make Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'lead-enrichment', 'Multi-Source Lead Enrichment Pipeline', 
'Capture leads from forms, enrich with data from multiple APIs (Clearbit, Hunter.io), score with AI, and sync to CRM. Advanced routing logic ensures data quality.',
'intermediate', '3-4 hours', 1
FROM tools WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'social-media-scheduler', 'AI Social Media Content Scheduler', 
'Generate social media posts with AI, optimize posting times, add images from Unsplash, and publish across Twitter, LinkedIn, Facebook. Includes engagement tracking.',
'beginner', '2-3 hours', 2
FROM tools WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;

-- Webflow Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'ai-portfolio', 'AI-Enhanced Portfolio Website', 
'Design a professional portfolio in Webflow that pulls project data from GitHub, generates descriptions with AI, and dynamically updates as you add new work. No coding required.',
'beginner', '4-6 hours', 1
FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'dynamic-pricing-page', 'Dynamic Pricing Page with AI Personalization', 
'Create a pricing page that uses AI to personalize offerings based on visitor behavior, company size, or referral source. Connects to backend services via APIs.',
'advanced', '1-2 days', 2
FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

-- Glide Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'employee-directory', 'Smart Employee Directory App', 
'Build a mobile-friendly employee directory connected to Google Sheets or Airtable. AI suggests connections based on skills, projects, and interests. Great for remote teams.',
'beginner', '1-2 hours', 1
FROM tools WHERE tool_name = 'Glide'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'field-service-app', 'AI-Powered Field Service App', 
'Create a field service management app where technicians access job details, AI routes them efficiently, and they update status in real-time. Connects to your backend database.',
'intermediate', '3-4 hours', 2
FROM tools WHERE tool_name = 'Glide'
ON CONFLICT DO NOTHING;

-- Flowise Use Cases
INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'chatbot-memory', 'Chatbot with Long-Term Memory', 
'Build a conversational AI that remembers past interactions, learns user preferences, and provides personalized responses. Uses vector stores for conversation history retrieval.',
'intermediate', '2-3 hours', 1
FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

INSERT INTO tool_usecases (tool_id, usecase_key, usecase_name, usecase_description, difficulty_level, estimated_setup_time, display_order)
SELECT id, 'document-qa-system', 'Multi-Document Q&A System', 
'Upload multiple PDFs and documents, create embeddings, and build a system that answers questions by searching across all documents. Perfect for research and knowledge management.',
'beginner', '1-2 hours', 2
FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

-- ============================================================================
-- DIMENSION 4: INTEGRATION PLATFORM COMPATIBILITY
-- ============================================================================

-- Notion Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'n8n', 'bi-directional', 9 FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Zapier', 'bi-directional', 10 FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Make', 'bi-directional', 9 FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;

-- Supabase Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'n8n', 'bi-directional', 8 FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Webflow', 'api', 7 FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Glide', 'api', 8 FROM tools WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

-- n8n Integrations (self-integration)
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;

-- OpenAI Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'n8n', 'action', 10 FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Zapier', 'action', 9 FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Make', 'action', 10 FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Flowise', 'api', 10 FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;

-- Claude Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'n8n', 'action', 9 FROM tools WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Flowise', 'api', 10 FROM tools WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;

-- Airtable Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'n8n', 'bi-directional', 9 FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Zapier', 'bi-directional', 10 FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Make', 'bi-directional', 10 FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Glide', 'api', 9 FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;

-- Make Integrations (self-integration)
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;

-- Webflow Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'n8n', 'bi-directional', 7 FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Zapier', 'bi-directional', 9 FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Make', 'bi-directional', 8 FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;

-- Glide Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Zapier', 'webhook', 7 FROM tools WHERE tool_name = 'Glide'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 8 FROM tools WHERE tool_name = 'Glide'
ON CONFLICT DO NOTHING;

-- Flowise Integrations
INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'n8n', 'api', 8 FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

INSERT INTO tool_integrations (tool_id, platform, integration_type, strength)
SELECT id, 'Rest API', 'api', 10 FROM tools WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;