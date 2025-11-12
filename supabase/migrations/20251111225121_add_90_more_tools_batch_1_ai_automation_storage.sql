/*
  # Add 90 More Tools - Batch 1: AI/LLM, Automation, Cloud Storage
  
  ## Summary
  This is the first batch of adding 90 additional tools to reach our goal of 100 tools.
  This batch focuses on three high-priority categories from the n8n ecosystem.
  
  ## Categories Covered in This Batch
  1. AI/LLM (8 more tools) - Already have OpenAI, Claude, Flowise
  2. Automation (6 more tools) - Already have n8n, Make  
  3. Cloud Storage (10 tools) - New category
  
  ## Tools Being Added (24 tools)
  
  ### AI/LLM Category (8 tools)
  1. Google Gemini - Google's multimodal AI model
  2. Anthropic Claude - (already exists, skipping)
  3. Llama 2 - Meta's open-source LLM
  4. Mistral AI - European AI company's models
  5. Cohere - Enterprise AI platform
  6. Hugging Face - ML model hub and APIs
  7. Replicate - Run open-source models via API
  8. LangChain - LLM application framework
  9. Pinecone - Vector database for AI
  
  ### Automation Category (6 tools)
  1. Zapier - Popular automation platform
  2. Power Automate - Microsoft's automation tool
  3. Automate.io - Cloud automation platform
  4. Workato - Enterprise automation
  5. Tray.io - Advanced integration platform
  6. Pipedream - Developer-first automation
  
  ### Cloud Storage Category (10 tools)
  1. Google Drive - Google's cloud storage
  2. Dropbox - File hosting service
  3. OneDrive - Microsoft cloud storage
  4. Box - Enterprise cloud content management
  5. AWS S3 - Amazon's object storage
  6. Cloudinary - Media asset management
  7. UploadCare - File uploading service
  8. Filestack - File upload and processing
  9. Backblaze B2 - Cost-effective cloud storage
  10. pCloud - Encrypted cloud storage
  
  ## Changes Made
  - Adds 24 new tools with complete metadata
  - Each tool includes summary, categories (legacy JSONB format), descriptions
  - Sets appropriate display priorities and verification status
  - Provides foundation for 4D classification in next migration
*/

-- ============================================================================
-- AI/LLM TOOLS (8 new tools)
-- ============================================================================

INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('Google Gemini', 'Google''s multimodal AI model capable of processing text, code, images, audio, and video with advanced reasoning.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["AI Assistant"],
  "application_field": ["AI Applications", "Content Creation"],
  "tech_layer": ["AI Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["n8n", "LangChain", "Flowise"]
}'::jsonb,
'{
  "encyclopedia": "Google Gemini is a family of multimodal AI models developed by Google, capable of understanding and generating text, code, images, audio, and video with state-of-the-art reasoning capabilities.",
  "guide": "Gemini excels at multimodal tasks, allowing you to combine text prompts with images or other media. Use it for applications requiring vision + language understanding, code generation, or complex reasoning across multiple domains.",
  "strategy": "Choose Gemini when you need multimodal AI capabilities or want to leverage Google''s AI ecosystem. Strong for applications combining text and vision, code assistance, or tasks requiring large context windows.",
  "inspiration": ["Build a multimodal content analyzer that processes images and generates captions, alt text, and SEO descriptions", "Create an AI code reviewer that understands both code and documentation screenshots", "Design a visual Q&A system that answers questions about images, diagrams, or charts"]
}'::jsonb,
'[]'::jsonb, 95, 135, true, 'manual'),

('Llama 2', 'Meta''s open-source large language model available for commercial use with strong performance across tasks.', 
'{
  "purpose": ["Application Oriented", "Learning Oriented"],
  "functional_role": ["AI Assistant"],
  "application_field": ["AI Applications"],
  "tech_layer": ["AI Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["Flowise", "LangChain", "Hugging Face"]
}'::jsonb,
'{
  "encyclopedia": "Llama 2 is Meta''s open-source large language model family, ranging from 7B to 70B parameters, designed for commercial and research use with performance comparable to closed-source models.",
  "guide": "Llama 2 offers the advantage of being fully open-source and self-hostable. Use it for privacy-sensitive applications, on-premise deployments, or when you want full control over your AI infrastructure. Fine-tuning is straightforward.",
  "strategy": "Select Llama 2 when you need an open-source LLM for self-hosting, want to avoid API costs, require data privacy, or plan to fine-tune on domain-specific data. Ideal for startups and enterprises with specific compliance needs.",
  "inspiration": ["Deploy a private AI assistant for sensitive enterprise data that never leaves your infrastructure", "Fine-tune Llama 2 on your company''s knowledge base for domain-specific question answering", "Build a cost-effective AI service that processes unlimited requests without API fees"]
}'::jsonb,
'[]'::jsonb, 85, 110, true, 'manual'),

('Mistral AI', 'European AI company offering efficient open-source and commercial LLMs optimized for performance and cost.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["AI Assistant"],
  "application_field": ["AI Applications"],
  "tech_layer": ["AI Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["LangChain", "Flowise", "n8n"]
}'::jsonb,
'{
  "encyclopedia": "Mistral AI is a French AI company providing efficient language models including Mistral 7B and Mixtral 8x7B, known for exceptional performance-to-cost ratios and European data sovereignty.",
  "guide": "Mistral models offer strong performance with lower computational requirements. Use them for cost-effective AI applications, European data compliance, or when you need efficient models that can run on smaller infrastructure.",
  "strategy": "Choose Mistral when cost efficiency matters, you need European AI providers for compliance, or want models that balance quality with resource usage. Mixtral''s mixture-of-experts architecture provides GPT-4 level performance at a fraction of the cost.",
  "inspiration": ["Build a cost-effective customer service AI that handles thousands of conversations daily", "Create a privacy-compliant AI assistant for European customers meeting GDPR requirements", "Deploy an efficient on-device AI for edge computing applications"]
}'::jsonb,
'[]'::jsonb, 80, 95, true, 'manual'),

('Cohere', 'Enterprise AI platform providing language models and NLP tools with strong multilingual capabilities.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["AI Assistant"],
  "application_field": ["AI Applications", "Data Analysis"],
  "tech_layer": ["AI Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["n8n", "LangChain", "Pinecone"]
}'::jsonb,
'{
  "encyclopedia": "Cohere is an enterprise AI platform offering language models, embeddings, and NLP tools with strong focus on multilingual support, semantic search, and business applications.",
  "guide": "Cohere specializes in enterprise NLP tasks like semantic search, classification, and content generation. Use their embeddings API for building powerful search systems, or generation models for text creation with good multilingual support.",
  "strategy": "Select Cohere for enterprise AI applications requiring multilingual support, semantic search, or text classification. Strong for building custom AI solutions with fine-tuning capabilities and enterprise-grade support.",
  "inspiration": ["Build a multilingual semantic search engine that understands queries in 100+ languages", "Create an AI content classifier that categorizes support tickets by urgency and topic", "Design a smart document retrieval system using Cohere''s embeddings and reranking"]
}'::jsonb,
'[]'::jsonb, 75, 85, true, 'manual'),

('Hugging Face', 'Open ML platform hosting thousands of models, datasets, and tools for NLP, vision, and audio tasks.', 
'{
  "purpose": ["Learning Oriented", "Application Oriented"],
  "functional_role": ["AI Assistant", "Database"],
  "application_field": ["AI Applications", "Knowledge Management"],
  "tech_layer": ["AI Layer", "Data Layer"],
  "data_flow_role": ["Storage", "Process"],
  "difficulty": "Low-code",
  "common_pairings": ["LangChain", "Flowise", "Replicate"]
}'::jsonb,
'{
  "encyclopedia": "Hugging Face is the leading platform for open-source machine learning, hosting over 500K models, 100K datasets, and providing tools like Transformers library and Inference API for deploying AI.",
  "guide": "Hugging Face is your gateway to open-source AI. Use their Model Hub to find pre-trained models for any task, the Inference API for quick deployment, or the Transformers library for custom implementations. Great for experimentation and production.",
  "strategy": "Choose Hugging Face when you want access to cutting-edge open-source models, need to experiment with different AI approaches, or want community-driven solutions. Perfect for developers who want flexibility and transparency.",
  "inspiration": ["Build a custom AI application using any of 500K open-source models without training from scratch", "Create a model comparison tool that tests multiple AI models on your specific use case", "Deploy a specialized AI for medical text analysis using domain-specific models from the Hub"]
}'::jsonb,
'[]'::jsonb, 85, 120, true, 'manual'),

('Replicate', 'Run open-source machine learning models via simple API without infrastructure management.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["AI Assistant"],
  "application_field": ["AI Applications", "Content Creation"],
  "tech_layer": ["AI Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["n8n", "Make", "Zapier"]
}'::jsonb,
'{
  "encyclopedia": "Replicate provides cloud infrastructure for running open-source ML models via API, including image generation, video processing, voice cloning, and more without managing servers or GPUs.",
  "guide": "Replicate makes it easy to run powerful open-source models like Stable Diffusion, Whisper, or SDXL through simple API calls. Pay only for compute time, no need to manage infrastructure or GPUs.",
  "strategy": "Select Replicate when you want to use open-source AI models without DevOps complexity, need pay-per-use pricing, or want to experiment with multiple models quickly. Great for image/video generation and processing.",
  "inspiration": ["Build an AI image generator that uses Stable Diffusion XL without managing GPU servers", "Create a voice cloning service using open-source models with simple API integration", "Design an automated video enhancement pipeline that upscales and restores old footage"]
}'::jsonb,
'[]'::jsonb, 75, 90, true, 'manual'),

('LangChain', 'Framework for developing applications powered by language models with agents, chains, and memory.', 
'{
  "purpose": ["Application Oriented", "System Oriented"],
  "functional_role": ["Automation", "AI Assistant"],
  "application_field": ["AI Applications"],
  "tech_layer": ["AI Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["OpenAI", "Claude", "Pinecone", "Supabase"]
}'::jsonb,
'{
  "encyclopedia": "LangChain is a comprehensive framework for building LLM applications, providing modules for prompts, chains, agents, memory, and integrations with various AI models and vector stores.",
  "guide": "LangChain simplifies building complex AI applications by providing reusable components. Use it to create conversational agents, retrieval systems, or multi-step AI workflows. Supports multiple LLM providers and extensive integrations.",
  "strategy": "Choose LangChain when building sophisticated AI applications requiring multi-step reasoning, memory, tool use, or document retrieval. Essential for developers building production RAG systems or autonomous agents.",
  "inspiration": ["Build a conversational AI agent that can use tools, search the web, and remember context across sessions", "Create a document Q&A system with retrieval-augmented generation from your knowledge base", "Design an AI research assistant that can plan multi-step information gathering tasks"]
}'::jsonb,
'[]'::jsonb, 90, 125, true, 'manual'),

('Pinecone', 'Fully managed vector database for building AI applications with semantic search and similarity matching.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Database"],
  "application_field": ["AI Applications", "Data Analysis"],
  "tech_layer": ["Data Layer", "AI Layer"],
  "data_flow_role": ["Storage"],
  "difficulty": "Low-code",
  "common_pairings": ["OpenAI", "LangChain", "Flowise"]
}'::jsonb,
'{
  "encyclopedia": "Pinecone is a specialized vector database optimized for storing and querying embeddings, enabling semantic search, recommendation systems, and retrieval-augmented generation at scale.",
  "guide": "Pinecone stores vector embeddings and provides ultra-fast similarity search. Use it for building semantic search, recommendation engines, or RAG systems. Simple API, auto-scaling, and optimized for AI workloads.",
  "strategy": "Select Pinecone when you need fast, scalable vector search for AI applications. Perfect for building chatbots with long-term memory, semantic search engines, or recommendation systems. Managed service eliminates infrastructure complexity.",
  "inspiration": ["Build a chatbot with unlimited memory that recalls relevant past conversations using embeddings", "Create a semantic search engine for your documentation that understands intent, not just keywords", "Design a personalized recommendation system that understands user preferences at a deeper level"]
}'::jsonb,
'[]'::jsonb, 80, 100, true, 'manual')

ON CONFLICT (tool_name) DO NOTHING;

-- ============================================================================
-- AUTOMATION TOOLS (6 new tools)
-- ============================================================================

INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('Zapier', 'Leading no-code automation platform connecting 6000+ apps with simple trigger-action workflows.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation"],
  "tech_layer": ["Integration Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "No-code",
  "common_pairings": ["Google Sheets", "Slack", "Gmail", "Airtable"]
}'::jsonb,
'{
  "encyclopedia": "Zapier is the most popular no-code automation platform, connecting over 6,000 applications with simple if-this-then-that workflows called Zaps, enabling anyone to automate repetitive tasks.",
  "guide": "Zapier makes automation accessible to non-technical users through a simple trigger-action interface. Create workflows in minutes without code, connecting your favorite apps to automate data entry, notifications, and processes.",
  "strategy": "Choose Zapier for quick, simple automations when ease of use matters more than complexity. Ideal for small businesses, solopreneurs, and teams that need fast setup without learning curves. Largest app ecosystem available.",
  "inspiration": ["Automatically save Gmail attachments to Google Drive and notify your team in Slack", "Create a lead pipeline that captures form submissions, adds to CRM, and triggers email sequences", "Build a social media content calendar that posts to multiple platforms on schedule"]
}'::jsonb,
'[]'::jsonb, 95, 150, true, 'manual'),

('Power Automate', 'Microsoft''s automation platform deeply integrated with Microsoft 365 and Azure services.', 
'{
  "purpose": ["Application Oriented", "System Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation"],
  "tech_layer": ["Integration Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Low-code",
  "common_pairings": ["Microsoft 365", "SharePoint", "Teams", "Dynamics"]
}'::jsonb,
'{
  "encyclopedia": "Power Automate (formerly Microsoft Flow) is Microsoft''s automation platform offering cloud and desktop automation, RPA capabilities, and deep integration with Microsoft''s ecosystem of products.",
  "guide": "Power Automate shines in Microsoft-centric environments, offering both cloud workflows and desktop automation (RPA). Use it to connect Microsoft 365 apps, automate repetitive desktop tasks, or build approval workflows.",
  "strategy": "Select Power Automate if you''re in the Microsoft ecosystem, need RPA capabilities for legacy systems, or want enterprise-grade automation with governance features. Strong for organizations already using Microsoft 365.",
  "inspiration": ["Automate approval workflows in Teams for expense reports and leave requests", "Build an RPA bot that extracts data from legacy desktop applications into SharePoint", "Create automated document processing that routes invoices based on content"]
}'::jsonb,
'[]'::jsonb, 85, 115, true, 'manual'),

('Automate.io', 'Cloud-based automation platform with multi-step workflows and advanced data transformation.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation"],
  "tech_layer": ["Integration Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "No-code",
  "common_pairings": ["Salesforce", "HubSpot", "Slack", "Trello"]
}'::jsonb,
'{
  "encyclopedia": "Automate.io is a cloud automation platform that connects marketing, sales, and business apps with multi-step workflows, conditional logic, and data transformation capabilities.",
  "guide": "Automate.io offers more flexibility than simple automation tools with multi-step workflows, conditional branching, and data formatting. Use it for marketing automation, sales pipelines, or business process automation.",
  "strategy": "Choose Automate.io when you need multi-step workflows with conditional logic but want simpler setup than complex platforms. Good for marketing teams and SMBs needing sophistication without steep learning curves.",
  "inspiration": ["Build a lead scoring system that routes high-value leads to sales and nurtures others via email", "Create a customer onboarding automation that personalizes steps based on user responses", "Design a social media monitoring system that alerts teams to brand mentions and sentiment"]
}'::jsonb,
'[]'::jsonb, 70, 80, true, 'manual'),

('Workato', 'Enterprise automation and integration platform with AI-powered recipe building and governance.', 
'{
  "purpose": ["System Oriented", "Application Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation", "Data Analysis"],
  "tech_layer": ["Integration Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Low-code",
  "common_pairings": ["Salesforce", "ServiceNow", "NetSuite", "Workday"]
}'::jsonb,
'{
  "encyclopedia": "Workato is an enterprise-grade integration and automation platform offering AI-assisted workflow building, robust governance, and pre-built connectors for business applications with focus on security and scalability.",
  "guide": "Workato excels at complex enterprise integrations with sophisticated data transformation, error handling, and governance. Use it for mission-critical business processes, ERP integrations, or when you need audit trails and compliance.",
  "strategy": "Select Workato for enterprise-scale automation requiring governance, security, compliance, and complex data transformations. Ideal for large organizations with sophisticated integration needs across multiple systems.",
  "inspiration": ["Integrate Salesforce with NetSuite for automated order-to-cash process with full audit trails", "Build a master data management system that synchronizes customer data across 10+ enterprise apps", "Create an automated compliance workflow that tracks and logs all data movements"]
}'::jsonb,
'[]'::jsonb, 75, 90, true, 'manual'),

('Tray.io', 'Advanced low-code integration platform for building complex, scalable automation workflows.', 
'{
  "purpose": ["System Oriented", "Application Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation"],
  "tech_layer": ["Integration Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Low-code",
  "common_pairings": ["Salesforce", "Marketo", "Slack", "PostgreSQL"]
}'::jsonb,
'{
  "encyclopedia": "Tray.io is a powerful visual automation platform that enables technical and business users to build complex, scalable integrations with advanced logic, error handling, and data transformation capabilities.",
  "guide": "Tray.io provides a visual canvas for building sophisticated automations with loops, branches, error handling, and custom logic. Use it when you need more power than simple automation tools but want visual development.",
  "strategy": "Choose Tray.io when you need advanced automation capabilities with visual development, want to empower citizen developers, or require scalable integrations for growing businesses. Strong for RevOps teams.",
  "inspiration": ["Build a revenue operations pipeline integrating marketing, sales, and customer success tools", "Create a data synchronization system with sophisticated conflict resolution and retry logic", "Design a multi-tenant automation platform that serves different customer configurations"]
}'::jsonb,
'[]'::jsonb, 75, 85, true, 'manual'),

('Pipedream', 'Developer-first automation platform with code flexibility and instant API integrations.', 
'{
  "purpose": ["Application Oriented", "System Oriented"],
  "functional_role": ["Automation", "API"],
  "application_field": ["Automation", "Web Development"],
  "tech_layer": ["Integration Layer", "Processing Layer"],
  "data_flow_role": ["Process"],
  "difficulty": "Code",
  "common_pairings": ["REST APIs", "Webhooks", "PostgreSQL", "AWS"]
}'::jsonb,
'{
  "encyclopedia": "Pipedream is a developer-focused integration platform that combines no-code workflow building with full coding flexibility, allowing developers to use JavaScript/Python within visual workflows.",
  "guide": "Pipedream bridges no-code and code-first approaches. Start with pre-built components, add custom code where needed, and deploy instantly. Perfect for developers who want automation speed without sacrificing flexibility.",
  "strategy": "Select Pipedream when you need automation with coding flexibility, want to build custom integrations quickly, or need to process data with custom logic. Ideal for technical teams and SaaS companies building integrations.",
  "inspiration": ["Build custom webhooks that transform and route data with JavaScript before sending to your app", "Create an API monitoring system that tests endpoints and alerts on failures with custom logic", "Design a data pipeline that extracts, transforms, and loads data between services with code"]
}'::jsonb,
'[]'::jsonb, 80, 95, true, 'manual')

ON CONFLICT (tool_name) DO NOTHING;

-- ============================================================================
-- CLOUD STORAGE TOOLS (10 new tools)
-- ============================================================================

INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, display_priority, popularity_score, is_verified, generation_source) VALUES
('Google Drive', 'Google''s cloud storage service with 15GB free storage, real-time collaboration, and Google Workspace integration.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management", "Database"],
  "application_field": ["Cloud Storage", "Collaboration"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage", "Output"],
  "difficulty": "No-code",
  "common_pairings": ["Google Sheets", "n8n", "Zapier", "Make"]
}'::jsonb,
'{
  "encyclopedia": "Google Drive is Google''s cloud storage platform offering file storage, sharing, and collaboration with deep integration into Google Workspace including Docs, Sheets, and Slides.",
  "guide": "Google Drive provides 15GB free storage with seamless collaboration features. Use it for storing files, sharing documents, or as a data source for automation workflows. Strong API for programmatic access.",
  "strategy": "Choose Google Drive for teams already using Google Workspace, when you need real-time collaboration, or want free storage for small projects. Excellent for storing automation outputs and sharing results.",
  "inspiration": ["Build an automated report generator that creates Google Sheets reports and shares them with stakeholders", "Create a document approval workflow that routes files through team members in Drive", "Design a backup system that archives important files from other services to Drive"]
}'::jsonb,
'[]'::jsonb, 90, 140, true, 'manual'),

('Dropbox', 'Popular cloud file hosting service with sync, sharing, and collaboration features for individuals and teams.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management"],
  "application_field": ["Cloud Storage", "Collaboration"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage"],
  "difficulty": "No-code",
  "common_pairings": ["n8n", "Zapier", "Slack", "Trello"]
}'::jsonb,
'{
  "encyclopedia": "Dropbox is a widely-used cloud storage platform providing file synchronization, sharing, and collaboration tools with desktop and mobile apps for seamless access across devices.",
  "guide": "Dropbox excels at file synchronization and simple sharing. Use it for backing up files, sharing large files with clients, or as central file storage for teams. Smart Sync saves local storage space.",
  "strategy": "Select Dropbox for reliable file sync across devices, simple file sharing, or when working with external collaborators. Strong for creative teams needing to share large media files.",
  "inspiration": ["Automatically backup client deliverables to Dropbox and send share links via email", "Create a media asset library that syncs to team members'' devices automatically", "Build a project folder structure that auto-organizes files by client and date"]
}'::jsonb,
'[]'::jsonb, 85, 125, true, 'manual'),

('OneDrive', 'Microsoft''s cloud storage integrated with Windows, Office 365, and Microsoft ecosystem.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management", "Database"],
  "application_field": ["Cloud Storage", "Collaboration"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage"],
  "difficulty": "No-code",
  "common_pairings": ["Microsoft 365", "SharePoint", "Power Automate", "Teams"]
}'::jsonb,
'{
  "encyclopedia": "OneDrive is Microsoft''s cloud storage service deeply integrated with Windows 10/11, Office 365, and the Microsoft ecosystem, offering personal and business storage solutions.",
  "guide": "OneDrive is ideal for Windows users and Office 365 subscribers, offering seamless integration with Office apps, Windows Explorer, and Microsoft Teams. Business version provides advanced sharing and compliance features.",
  "strategy": "Choose OneDrive if you''re in the Microsoft ecosystem, need Office integration, or want enterprise features like data loss prevention and eDiscovery. Comes included with Microsoft 365 subscriptions.",
  "inspiration": ["Set up automatic backup of your Desktop, Documents, and Pictures folders to the cloud", "Build a document collaboration system that version-controls Office files automatically", "Create a compliance workflow that scans OneDrive files for sensitive information"]
}'::jsonb,
'[]'::jsonb, 85, 120, true, 'manual'),

('Box', 'Enterprise-focused cloud content management and file sharing platform with strong security and compliance.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management", "Database"],
  "application_field": ["Cloud Storage", "Collaboration"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage"],
  "difficulty": "No-code",
  "common_pairings": ["Salesforce", "Slack", "Microsoft 365", "n8n"]
}'::jsonb,
'{
  "encyclopedia": "Box is an enterprise cloud content management platform emphasizing security, compliance, and workflow automation with features like Box Sign, Box Relay, and extensive integration capabilities.",
  "guide": "Box targets enterprises with advanced security requirements, offering features like granular permissions, compliance tools, legal holds, and workflow automation. Use it for secure file sharing and content management.",
  "strategy": "Select Box for enterprise environments needing compliance (HIPAA, GDPR), advanced security controls, or sophisticated content workflows. Strong for industries like healthcare, finance, and legal services.",
  "inspiration": ["Build a secure client portal for sharing sensitive documents with external stakeholders", "Create a contract management workflow with Box Sign integration for e-signatures", "Design an automated compliance system that classifies and protects sensitive files"]
}'::jsonb,
'[]'::jsonb, 75, 95, true, 'manual'),

('AWS S3', 'Amazon''s scalable object storage service for storing and retrieving any amount of data from anywhere.', 
'{
  "purpose": ["System Oriented", "Application Oriented"],
  "functional_role": ["Database", "Content Management"],
  "application_field": ["Cloud Storage", "Web Development"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage"],
  "difficulty": "Code",
  "common_pairings": ["AWS Lambda", "CloudFront", "n8n", "Supabase"]
}'::jsonb,
'{
  "encyclopedia": "Amazon S3 (Simple Storage Service) is a highly scalable, durable object storage service that stores data as objects within buckets, serving as the foundation for many web applications and data lakes.",
  "guide": "S3 is perfect for storing large amounts of unstructured data like images, videos, backups, or logs. Use it with static website hosting, as a CDN origin, or for data archival with different storage classes for cost optimization.",
  "strategy": "Choose S3 for scalable, cost-effective object storage, backup and archival, static website hosting, or as data storage for applications. Virtually unlimited scalability with pay-per-use pricing.",
  "inspiration": ["Build a static website hosting solution with CloudFront CDN for global delivery", "Create an automated backup system that archives databases and files to S3 Glacier", "Design a user-uploaded content system that stores images in S3 and serves via CDN"]
}'::jsonb,
'[]'::jsonb, 85, 110, true, 'manual'),

('Cloudinary', 'Media management platform for storing, transforming, optimizing, and delivering images and videos.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management"],
  "application_field": ["Cloud Storage", "Content Creation"],
  "tech_layer": ["Data Layer", "Processing Layer"],
  "data_flow_role": ["Storage", "Process", "Output"],
  "difficulty": "Low-code",
  "common_pairings": ["Webflow", "Shopify", "WordPress", "Next.js"]
}'::jsonb,
'{
  "encyclopedia": "Cloudinary is an end-to-end media management platform that handles upload, storage, transformation, optimization, and delivery of images and videos with powerful on-the-fly editing capabilities.",
  "guide": "Cloudinary simplifies media management with automatic format conversion, responsive images, and URL-based transformations. Upload once, deliver optimized versions for any device. Includes AI-powered features for auto-cropping and tagging.",
  "strategy": "Choose Cloudinary for media-heavy applications, e-commerce sites, or when you need dynamic image transformations. Eliminates need for manual image optimization and reduces page load times significantly.",
  "inspiration": ["Build an e-commerce site that automatically generates thumbnails and responsive images for products", "Create a user-generated content platform with automatic image moderation and optimization", "Design a digital asset management system with AI-powered tagging and search"]
}'::jsonb,
'[]'::jsonb, 75, 90, true, 'manual'),

('UploadCare', 'File uploading, processing, and delivery service with CDN and image transformations built-in.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management"],
  "application_field": ["Cloud Storage", "Web Development"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage", "Input"],
  "difficulty": "Low-code",
  "common_pairings": ["React", "Vue.js", "Webflow", "n8n"]
}'::jsonb,
'{
  "encyclopedia": "UploadCare provides a complete file uploading infrastructure with drag-and-drop widgets, image processing, CDN delivery, and integrations with cloud storage providers.",
  "guide": "UploadCare handles the complexity of file uploads with pre-built widgets, automatic optimization, and global CDN delivery. Use it to add file uploading to your app without building infrastructure.",
  "strategy": "Select UploadCare when you need quick file upload implementation, want to avoid managing storage infrastructure, or need features like file validation and virus scanning out of the box.",
  "inspiration": ["Add a professional file upload interface to your app in minutes with drag-and-drop", "Build a form that accepts images and automatically optimizes them for web delivery", "Create a document submission system with file type validation and virus scanning"]
}'::jsonb,
'[]'::jsonb, 65, 70, true, 'manual'),

('Filestack', 'File upload, transformation, and delivery API with powerful processing and conversion capabilities.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management"],
  "application_field": ["Cloud Storage", "Web Development"],
  "tech_layer": ["Data Layer", "Processing Layer"],
  "data_flow_role": ["Storage", "Process"],
  "difficulty": "Code",
  "common_pairings": ["React", "Angular", "Node.js", "AWS S3"]
}'::jsonb,
'{
  "encyclopedia": "Filestack provides a powerful API for uploading, transforming, and delivering files with features like document conversion, video transcoding, and image manipulation through URL parameters.",
  "guide": "Filestack offers developer-friendly APIs for complete file management workflows. Use it to build file upload interfaces, convert between formats, or process images and videos. Supports multiple storage backends.",
  "strategy": "Choose Filestack for applications needing advanced file processing, document conversion, or when you want powerful transformation capabilities via simple URLs. Good for SaaS products with file handling needs.",
  "inspiration": ["Build a document converter that transforms Word docs, PDFs, and images between formats", "Create a video processing pipeline that transcodes uploads to multiple formats and qualities", "Design a profile picture uploader with automatic face detection and cropping"]
}'::jsonb,
'[]'::jsonb, 65, 75, true, 'manual'),

('Backblaze B2', 'Cost-effective cloud storage compatible with S3 API, offering lowest-cost data storage and egress.', 
'{
  "purpose": ["Application Oriented", "System Oriented"],
  "functional_role": ["Database", "Content Management"],
  "application_field": ["Cloud Storage"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage"],
  "difficulty": "Code",
  "common_pairings": ["Cloudflare", "Rclone", "Restic", "n8n"]
}'::jsonb,
'{
  "encyclopedia": "Backblaze B2 is an affordable cloud storage service offering S3-compatible API at a fraction of the cost, making it ideal for backups, archival, and cost-conscious storage needs.",
  "guide": "B2 offers the lowest-cost cloud storage with S3 compatibility, making it easy to switch from AWS. Use it for backups, archival, or as cheap storage for infrequently accessed data. Free egress when paired with Cloudflare.",
  "strategy": "Choose Backblaze B2 when cost is a primary concern, for backup and archival storage, or when you can use Cloudflare for free egress. Great for storing large datasets or video libraries cost-effectively.",
  "inspiration": ["Build an automated backup system that costs 1/4 of AWS S3 pricing", "Create a media archive for storing old content at minimal cost", "Design a disaster recovery solution with affordable offsite backups"]
}'::jsonb,
'[]'::jsonb, 70, 80, true, 'manual'),

('pCloud', 'European cloud storage provider with client-side encryption and lifetime storage plans.', 
'{
  "purpose": ["Application Oriented"],
  "functional_role": ["Content Management"],
  "application_field": ["Cloud Storage"],
  "tech_layer": ["Data Layer"],
  "data_flow_role": ["Storage"],
  "difficulty": "No-code",
  "common_pairings": ["Cryptomator", "rclone", "Zapier"]
}'::jsonb,
'{
  "encyclopedia": "pCloud is a Swiss-based cloud storage provider emphasizing privacy and security with optional client-side encryption, competitive pricing, and unique lifetime storage plans.",
  "guide": "pCloud offers a privacy-focused alternative to mainstream cloud storage with Swiss data sovereignty, optional zero-knowledge encryption, and the option to purchase lifetime storage rather than subscriptions.",
  "strategy": "Select pCloud for privacy-sensitive storage needs, European data residency requirements, or when you prefer one-time payment over subscriptions. Strong for personal use and small businesses valuing privacy.",
  "inspiration": ["Store sensitive business documents with zero-knowledge encryption in European data centers", "Buy lifetime cloud storage once instead of paying monthly subscriptions forever", "Create a secure backup solution for personal data that respects privacy"]
}'::jsonb,
'[]'::jsonb, 65, 70, true, 'manual')

ON CONFLICT (tool_name) DO NOTHING;