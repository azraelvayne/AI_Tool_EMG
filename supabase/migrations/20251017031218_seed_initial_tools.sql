/*
  # Seed Initial Tools

  ## Purpose
  Populate the tools table with popular AI and No-Code tools to bootstrap the application.

  ## Tools Added
  1. Notion - Knowledge management and collaboration
  2. Supabase - Open source Firebase alternative
  3. n8n - Workflow automation platform
  4. OpenAI - AI language models and APIs
  5. Claude - Anthropic's AI assistant
  6. Airtable - Cloud-based database platform
  7. Make (Integromat) - Visual automation platform
  8. Webflow - Visual web development platform
  9. Glide - No-code mobile app builder
  10. Flowise - Low-code LLM orchestration tool
*/

-- Insert Notion
INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('Notion', 'All-in-one workspace combining notes, databases, wikis, and project management with AI capabilities.', 
'{
  "purpose": ["Application Oriented", "Learning Oriented"],
  "functional_role": ["Content Management", "Database", "Collaboration"],
  "application_field": ["Knowledge Management", "Collaboration"],
  "tech_layer": ["Data Layer", "Frontend Layer"],
  "data_flow_role": ["Storage", "Output"],
  "difficulty": "No-code",
  "common_pairings": ["n8n", "Make", "OpenAI", "Supabase"]
}'::jsonb,
'{
  "encyclopedia": "Notion is a versatile workspace platform that integrates notes, databases, wikis, and project management tools with recent AI assistant capabilities, serving as a foundation for knowledge management and application development.",
  "guide": "In AI systems, Notion acts as a knowledge memory layer, storing conversation history, task lists, and knowledge summaries. It can be connected via API to automation platforms like n8n or Make for intelligent workflows.",
  "strategy": "Use Notion when you need an intuitive interface for organizing complex information with relational databases. Ideal for building AI research systems, personal knowledge assistants, or content management workflows. Best paired with automation tools for dynamic updates.",
  "inspiration": ["Build an AI-powered research assistant that automatically categorizes and summarizes articles in Notion databases", "Create a personal knowledge graph that uses AI to link related notes and suggest connections", "Design an automated meeting notes system that transcribes, summarizes, and organizes discussions in Notion"]
}'::jsonb,
'[
  {
    "goal": "Build an AI-powered note-taking system",
    "method": "No-code integration",
    "tool_stack": ["Notion", "Make", "OpenAI"],
    "steps": [
      "Create a Notion database for storing notes and summaries",
      "Set up Make workflow to trigger on new Notion pages",
      "Connect OpenAI API to generate summaries and tags",
      "Auto-update Notion pages with AI-generated content"
    ]
  }
]'::jsonb, 100, 150, true, 'manual')
ON CONFLICT (tool_name) DO NOTHING;

-- Insert Supabase
INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('Supabase', 'Open-source Firebase alternative providing database, authentication, storage, and real-time subscriptions.', 
'{
  "purpose": ["Application Oriented", "System Oriented"],
  "functional_role": ["Database", "API", "Content Management"],
  "application_field": ["Web Development", "Data Analysis"],
  "tech_layer": ["Data Layer", "Processing Layer"],
  "data_flow_role": ["Storage", "Process"],
  "difficulty": "Low-code",
  "common_pairings": ["Glide", "Webflow", "n8n", "Next.js"]
}'::jsonb,
'{
  "encyclopedia": "Supabase is an open-source backend-as-a-service platform built on PostgreSQL, offering database, authentication, file storage, and real-time capabilities with a developer-friendly API.",
  "guide": "Supabase serves as the data backbone for modern applications, providing instant APIs for your PostgreSQL database. Perfect for building full-stack applications without managing infrastructure. Use Row Level Security for fine-grained access control.",
  "strategy": "Choose Supabase when you need a powerful relational database with real-time features and built-in authentication. Ideal for AI applications requiring structured data storage, user management, and vector embeddings for semantic search.",
  "inspiration": ["Create a multi-user AI chat application with conversation history stored in Supabase", "Build a document knowledge base with pgvector for semantic search capabilities", "Design a collaborative workspace where team members can share and annotate AI-generated content"]
}'::jsonb,
'[
  {
    "goal": "Build a chatbot with conversation history",
    "method": "Low-code with SQL",
    "tool_stack": ["Supabase", "OpenAI", "React"],
    "steps": [
      "Create conversations and messages tables in Supabase",
      "Set up Row Level Security policies for user data",
      "Build React frontend with Supabase client",
      "Integrate OpenAI API for chat completions",
      "Store conversation history in real-time"
    ]
  }
]'::jsonb, 95, 140, true, 'manual')
ON CONFLICT (tool_name) DO NOTHING;

-- Insert n8n
INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('n8n', 'Fair-code workflow automation platform with 300+ integrations for building complex automation sequences.', 
'{
  "purpose": ["Application Oriented", "System Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation", "AI Applications"],
  "tech_layer": ["Processing Layer", "Integration Layer"],
  "data_flow_role": ["Process", "Input"],
  "difficulty": "Low-code",
  "common_pairings": ["OpenAI", "Supabase", "Notion", "Airtable"]
}'::jsonb,
'{
  "encyclopedia": "n8n is a node-based workflow automation platform that enables users to connect different services and APIs through visual programming, with extensive support for AI model integrations.",
  "guide": "n8n acts as the orchestration layer in AI systems, connecting data sources, AI models, and output destinations. Use it to build complex workflows that trigger on events, process data through multiple steps, and integrate with external services.",
  "strategy": "Select n8n when you need flexible, self-hosted automation with complex conditional logic. Perfect for building AI agents that pull data from multiple sources, process it through language models, and distribute results across platforms.",
  "inspiration": ["Create an automated content pipeline that monitors RSS feeds, summarizes articles with AI, and posts to social media", "Build a customer support bot that triages emails, generates AI responses, and routes complex issues to humans", "Design a data enrichment workflow that processes CRM entries through multiple AI services"]
}'::jsonb,
'[
  {
    "goal": "Automate content summarization workflow",
    "method": "Visual workflow builder",
    "tool_stack": ["n8n", "OpenAI", "Notion"],
    "steps": [
      "Set up n8n trigger for new Notion database entries",
      "Extract content from web URLs using HTTP Request node",
      "Process content through OpenAI for summarization",
      "Update Notion page with generated summary and tags"
    ]
  }
]'::jsonb, 90, 130, true, 'manual')
ON CONFLICT (tool_name) DO NOTHING;

-- Insert OpenAI
INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('OpenAI', 'Leading AI research company providing GPT language models, DALL-E image generation, and Whisper speech recognition.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["AI Assistant"],
  "application_field": ["AI Applications", "Content Creation"],
  "tech_layer": ["AI Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["n8n", "Supabase", "Flowise", "LangChain"]
}'::jsonb,
'{
  "encyclopedia": "OpenAI provides state-of-the-art AI models including GPT-4 for text generation, DALL-E for image creation, and Whisper for speech transcription, accessible via developer-friendly APIs.",
  "guide": "OpenAI serves as the intelligence layer in AI applications. Use GPT models for text generation, analysis, and transformation. Integrate with automation platforms or build custom applications using the API with structured outputs.",
  "strategy": "Choose OpenAI when you need cutting-edge AI capabilities with strong reasoning and generation quality. Best for applications requiring natural language understanding, creative content generation, or complex problem-solving. Consider cost management for high-volume use cases.",
  "inspiration": ["Build a code documentation generator that analyzes codebases and creates comprehensive API docs", "Create an intelligent email assistant that drafts responses based on conversation context and tone", "Design a creative writing tool that helps authors develop character backgrounds and plot outlines"]
}'::jsonb,
'[
  {
    "goal": "Create an AI-powered documentation generator",
    "method": "API integration",
    "tool_stack": ["OpenAI", "GitHub", "Notion"],
    "steps": [
      "Set up GitHub webhook for code commits",
      "Extract changed files and code context",
      "Send to OpenAI API for documentation generation",
      "Format output and update Notion documentation database"
    ]
  }
]'::jsonb, 100, 160, true, 'manual')
ON CONFLICT (tool_name) DO NOTHING;

-- Insert Claude
INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('Claude', 'Anthropic AI assistant with extended context windows, strong reasoning capabilities, and constitutional AI safety.', 
'{
  "purpose": ["Application Oriented", "Learning Oriented"],
  "functional_role": ["AI Assistant"],
  "application_field": ["AI Applications", "Knowledge Management"],
  "tech_layer": ["AI Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["n8n", "Flowise", "Supabase"]
}'::jsonb,
'{
  "encyclopedia": "Claude is Anthropic AI assistant known for its extended context window (200K+ tokens), strong analytical capabilities, and safety-focused design with constitutional AI principles.",
  "guide": "Claude excels at complex reasoning, analysis of long documents, and structured data extraction. Use it for applications requiring deep understanding of context, careful analysis, or working with extensive documentation.",
  "strategy": "Select Claude when you need to process long documents, perform multi-step reasoning, or require more cautious AI behavior. Ideal for research assistance, document analysis, technical writing, and applications where safety and accuracy are critical.",
  "inspiration": ["Build a research paper analyzer that extracts key findings, methodology, and citations from academic papers", "Create a legal document review system that identifies clauses and potential issues", "Design a technical interview preparation tool that provides detailed feedback on coding solutions"]
}'::jsonb,
'[
  {
    "goal": "Build a document analysis system",
    "method": "API integration",
    "tool_stack": ["Claude", "Supabase", "React"],
    "steps": [
      "Upload documents to storage system",
      "Extract text content from PDFs/documents",
      "Send to Claude API for structured analysis",
      "Store extracted insights in Supabase",
      "Display results in searchable interface"
    ]
  }
]'::jsonb, 95, 145, true, 'manual')
ON CONFLICT (tool_name) DO NOTHING;

-- Insert more tools
INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('Airtable', 'Cloud-based database platform combining spreadsheet simplicity with database power and automation features.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Database", "Content Management"],
  "application_field": ["Knowledge Management", "Collaboration"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage", "Output"],
  "difficulty": "No-code",
  "common_pairings": ["n8n", "Make", "Zapier"]
}'::jsonb,
'{
  "encyclopedia": "Airtable combines the familiarity of spreadsheets with the power of databases, offering a flexible platform for organizing information with rich field types, views, and integrations.",
  "guide": "Airtable serves as a visual database layer with an intuitive interface. Use it for content management, project tracking, or as a data source for applications. The API enables programmatic access for automation and integration.",
  "strategy": "Choose Airtable when you need a user-friendly database that non-technical team members can manage. Perfect for content calendars, CRM systems, or as a lightweight backend for simple applications.",
  "inspiration": ["Create an AI content pipeline where Airtable tracks articles through ideation, AI generation, editing, and publishing stages", "Build a customer feedback system that uses AI to categorize and prioritize feature requests", "Design a recruitment workflow that uses AI to score resumes and track candidates"]
}'::jsonb,
'[]'::jsonb, 85, 120, true, 'manual'),

('Make', 'Visual automation platform (formerly Integromat) with advanced routing, error handling, and data transformation.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation"],
  "tech_layer": ["Integration Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "No-code",
  "common_pairings": ["OpenAI", "Notion", "Airtable", "Google Sheets"]
}'::jsonb,
'{
  "encyclopedia": "Make (formerly Integromat) is a visual automation platform that enables users to connect apps and services with powerful data transformation, routing, and error handling capabilities.",
  "guide": "Make excels at complex automation scenarios with branching logic, data manipulation, and sophisticated error handling. Use it to build resilient workflows that integrate multiple services.",
  "strategy": "Select Make when you need advanced automation features like array processing, error recovery, and complex conditional logic. Ideal for enterprise automation and workflows requiring data transformation.",
  "inspiration": ["Build an AI-powered lead enrichment system that processes form submissions through multiple data sources", "Create a social media content scheduler that generates AI captions and posts across platforms", "Design a customer onboarding automation that personalizes communication based on AI analysis"]
}'::jsonb,
'[]'::jsonb, 85, 115, true, 'manual'),

('Webflow', 'Professional no-code web development platform with visual design, CMS, and hosting capabilities.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Frontend", "Content Management"],
  "application_field": ["Web Development", "Content Creation"],
  "tech_layer": ["Frontend Layer"],
  "data_flow_role": ["Output"],
  "difficulty": "No-code",
  "common_pairings": ["Supabase", "Memberstack", "Zapier"]
}'::jsonb,
'{
  "encyclopedia": "Webflow is a visual web development platform that generates production-ready code from design, offering professional website creation without coding along with CMS and hosting.",
  "guide": "Webflow serves as the presentation layer for applications, enabling designers to create responsive websites visually. Combine with backend services via APIs for dynamic functionality.",
  "strategy": "Choose Webflow when you need design flexibility and professional results without coding. Perfect for marketing sites, portfolios, or frontend interfaces for API-driven applications.",
  "inspiration": ["Create an AI-powered portfolio site that generates project descriptions from GitHub repositories", "Build a dynamic pricing page that uses AI to personalize offerings based on visitor behavior", "Design a blog platform where AI assists with SEO optimization and content suggestions"]
}'::jsonb,
'[]'::jsonb, 80, 105, true, 'manual'),

('Glide', 'No-code platform for building mobile and web apps from spreadsheets with native mobile features.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Frontend"],
  "application_field": ["Web Development"],
  "tech_layer": ["Frontend Layer"],
  "data_flow_role": ["Output"],
  "difficulty": "No-code",
  "common_pairings": ["Google Sheets", "Airtable", "Supabase"]
}'::jsonb,
'{
  "encyclopedia": "Glide transforms spreadsheets into beautiful mobile and web applications without code, offering pre-built components, native features, and direct data connections.",
  "guide": "Glide excels at rapid prototyping and internal tools by connecting directly to data sources like Google Sheets or Airtable. Use it to create mobile-friendly interfaces quickly.",
  "strategy": "Select Glide when you need to quickly turn data into an app without development. Ideal for internal tools, directories, or simple data-driven applications with mobile requirements.",
  "inspiration": ["Build an AI-powered employee directory that suggests connections based on skills and projects", "Create a knowledge base app where AI helps find relevant documentation", "Design a field service app that uses AI to route technicians efficiently"]
}'::jsonb,
'[]'::jsonb, 75, 95, true, 'manual'),

('Flowise', 'Open-source low-code platform for building customized LLM orchestration flows and AI agents visually.', 
'{
  "purpose": ["Application Oriented", "Learning Oriented"],
  "functional_role": ["AI Assistant", "Automation"],
  "application_field": ["AI Applications"],
  "tech_layer": ["AI Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Low-code",
  "common_pairings": ["OpenAI", "Claude", "Supabase", "Pinecone"]
}'::jsonb,
'{
  "encyclopedia": "Flowise is an open-source platform for building LLM applications and AI agents using a visual drag-and-drop interface, supporting multiple AI models and vector databases.",
  "guide": "Flowise simplifies building complex AI workflows by providing pre-built components for models, memory, chains, and agents. Use it to experiment with LLM orchestration without extensive coding.",
  "strategy": "Choose Flowise when you want to rapidly prototype AI applications or need a visual interface for building LLM chains. Perfect for building chatbots, document Q&A systems, or autonomous agents.",
  "inspiration": ["Create a customer support chatbot with memory that learns from past conversations", "Build a document analysis system that can answer questions from multiple PDF sources", "Design an AI research assistant that can search, summarize, and synthesize information from various sources"]
}'::jsonb,
'[]'::jsonb, 80, 110, true, 'manual')
ON CONFLICT (tool_name) DO NOTHING;