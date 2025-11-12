/*
  # Update Existing Tools and Add New Curated Tools

  ## Overview
  This migration:
  1. Updates existing tools with URLs, tags, and free tier info
  2. Adds new tools that do not exist yet
  3. Focuses on 3 main categories: AI/LLM, Automation, and Creative Tools

  ## Strategy
  - UPDATE existing tools with enhanced information
  - INSERT only new tools
  - Add bilingual translations
*/

-- Update existing AI/LLM tools
UPDATE tools SET
  url = 'https://openai.com',
  tags = ARRAY['AI', 'LLM', 'Chat', 'Text Generation', 'API'],
  free_tier_info = '{"tier": "Pay-as-you-go", "free_credits": "$5 trial", "limits": "API rate limits apply"}'::jsonb,
  popularity_score = 95,
  display_priority = 100
WHERE tool_name = 'OpenAI';

UPDATE tools SET
  url = 'https://claude.ai',
  tags = ARRAY['AI', 'LLM', 'Chat', 'Analysis', 'API'],
  free_tier_info = '{"tier": "Free tier available", "free_credits": "Limited messages", "limits": "Rate limited on free tier"}'::jsonb,
  popularity_score = 90,
  display_priority = 95
WHERE tool_name = 'Claude';

UPDATE tools SET
  url = 'https://huggingface.co',
  tags = ARRAY['AI', 'ML', 'Open Source', 'Models', 'Community'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "Generous API quotas", "limits": "Inference API rate limits"}'::jsonb,
  popularity_score = 88,
  display_priority = 88
WHERE tool_name = 'Hugging Face';

UPDATE tools SET
  url = 'https://cohere.com',
  tags = ARRAY['AI', 'LLM', 'Enterprise', 'Embeddings', 'API'],
  free_tier_info = '{"tier": "Free trial", "free_credits": "1000 API calls/month", "limits": "Limited to trial models"}'::jsonb,
  popularity_score = 75,
  display_priority = 80
WHERE tool_name = 'Cohere';

UPDATE tools SET
  url = 'https://mistral.ai',
  tags = ARRAY['AI', 'LLM', 'Open Source', 'Multilingual'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "API access", "limits": "Rate limited"}'::jsonb,
  popularity_score = 82,
  display_priority = 82
WHERE tool_name = 'Mistral AI';

UPDATE tools SET
  url = 'https://langchain.com',
  tags = ARRAY['AI', 'Framework', 'Developer', 'Integration', 'Open Source'],
  free_tier_info = '{"tier": "Open source", "free_credits": "Free to use", "limits": "Cloud platform has pricing"}'::jsonb,
  popularity_score = 86,
  display_priority = 86
WHERE tool_name = 'LangChain';

UPDATE tools SET
  url = 'https://replicate.com',
  tags = ARRAY['AI', 'ML', 'API', 'Image', 'Text'],
  free_tier_info = '{"tier": "Pay-as-you-go", "free_credits": "Limited free credits", "limits": "Per-model pricing"}'::jsonb,
  popularity_score = 76,
  display_priority = 76
WHERE tool_name = 'Replicate';

-- Update existing Automation tools
UPDATE tools SET
  url = 'https://n8n.io',
  tags = ARRAY['Automation', 'Workflow', 'Open Source', 'Self-Hosted', 'Integration'],
  free_tier_info = '{"tier": "Free self-hosted", "free_credits": "Unlimited", "limits": "Cloud tier: 2500 executions/month"}'::jsonb,
  popularity_score = 92,
  display_priority = 98
WHERE tool_name = 'n8n';

UPDATE tools SET
  url = 'https://make.com',
  tags = ARRAY['Automation', 'Workflow', 'No-Code', 'Integration'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "1000 operations/month", "limits": "15 minute intervals"}'::jsonb,
  popularity_score = 88,
  display_priority = 93
WHERE tool_name = 'Make';

UPDATE tools SET
  url = 'https://zapier.com',
  tags = ARRAY['Automation', 'Workflow', 'No-Code', 'Integration'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "100 tasks/month", "limits": "Single-step Zaps only"}'::jsonb,
  popularity_score = 91,
  display_priority = 96
WHERE tool_name = 'Zapier';

UPDATE tools SET
  url = 'https://flowiseai.com',
  tags = ARRAY['AI', 'Automation', 'LangChain', 'Open Source', 'No-Code'],
  free_tier_info = '{"tier": "Free self-hosted", "free_credits": "Unlimited", "limits": "Cloud tier has limits"}'::jsonb,
  popularity_score = 83,
  display_priority = 87
WHERE tool_name = 'Flowise';

UPDATE tools SET
  url = 'https://pipedream.com',
  tags = ARRAY['Automation', 'Developer', 'API', 'Workflow'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "10k invocations/month", "limits": "Community support only"}'::jsonb,
  popularity_score = 81,
  display_priority = 84
WHERE tool_name = 'Pipedream';

UPDATE tools SET
  url = 'https://glideapps.com',
  tags = ARRAY['No-Code', 'Mobile App', 'Spreadsheet', 'Quick'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "500 rows", "limits": "Public apps only"}'::jsonb,
  popularity_score = 79,
  display_priority = 82
WHERE tool_name = 'Glide';

UPDATE tools SET
  url = 'https://airtable.com',
  tags = ARRAY['Database', 'Collaboration', 'No-Code', 'Workflow'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "Unlimited bases", "limits": "1000 records/base, 2GB attachments"}'::jsonb,
  popularity_score = 87,
  display_priority = 90
WHERE tool_name = 'Airtable';

UPDATE tools SET
  url = 'https://notion.so',
  tags = ARRAY['Productivity', 'Database', 'Documentation', 'Collaboration'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "Individual use", "limits": "Some AI features limited"}'::jsonb,
  popularity_score = 89,
  display_priority = 92
WHERE tool_name = 'Notion';

UPDATE tools SET
  url = 'https://supabase.com',
  tags = ARRAY['Database', 'Backend', 'Open Source', 'PostgreSQL', 'Auth'],
  free_tier_info = '{"tier": "Free tier", "free_credits": "500MB database", "limits": "2GB bandwidth, pauses after 1 week inactive"}'::jsonb,
  popularity_score = 86,
  display_priority = 89
WHERE tool_name = 'Supabase';

-- Insert new AI/LLM tools
INSERT INTO tools (tool_name, summary, url, tags, free_tier_info, popularity_score, display_priority, is_verified)
VALUES
  (
    'Ollama',
    'Run large language models locally on your machine with ease.',
    'https://ollama.com',
    ARRAY['AI', 'LLM', 'Local', 'Open Source', 'Privacy'],
    '{"tier": "Completely free", "free_credits": "Unlimited", "limits": "Only hardware limits"}'::jsonb,
    85,
    90,
    true
  ),
  (
    'Perplexity AI',
    'AI-powered search engine with real-time information and citations.',
    'https://perplexity.ai',
    ARRAY['AI', 'Search', 'Research', 'Citations'],
    '{"tier": "Free tier", "free_credits": "Limited searches", "limits": "Pro features require subscription"}'::jsonb,
    80,
    85,
    true
  ),
  (
    'LM Studio',
    'Desktop app to run local LLMs with a user-friendly interface.',
    'https://lmstudio.ai',
    ARRAY['AI', 'LLM', 'Local', 'Desktop', 'No-Code'],
    '{"tier": "Completely free", "free_credits": "Unlimited", "limits": "Only hardware limits"}'::jsonb,
    78,
    78,
    true
  ),
  (
    'Together AI',
    'Fast inference platform for open-source AI models.',
    'https://together.ai',
    ARRAY['AI', 'LLM', 'API', 'Fast', 'Open Source'],
    '{"tier": "Free trial", "free_credits": "$25 credit", "limits": "After trial: pay-as-you-go"}'::jsonb,
    74,
    74,
    true
  ),
  (
    'Groq',
    'Ultra-fast AI inference with specialized hardware.',
    'https://groq.com',
    ARRAY['AI', 'LLM', 'Fast', 'API', 'Performance'],
    '{"tier": "Free tier", "free_credits": "Generous quotas", "limits": "Rate limited"}'::jsonb,
    79,
    79,
    true
  ),
  (
    'OpenRouter',
    'Unified API for accessing multiple LLM providers.',
    'https://openrouter.ai',
    ARRAY['AI', 'LLM', 'API', 'Aggregator', 'Multi-Provider'],
    '{"tier": "Pay-as-you-go", "free_credits": "Some free models", "limits": "Varies by model"}'::jsonb,
    72,
    72,
    true
  ),
  (
    'LlamaIndex',
    'Data framework for connecting LLMs with external data sources.',
    'https://llamaindex.ai',
    ARRAY['AI', 'Framework', 'Data', 'RAG', 'Open Source'],
    '{"tier": "Open source", "free_credits": "Free to use", "limits": "Cloud platform has pricing"}'::jsonb,
    84,
    84,
    true
  ),
  (
    'Jan AI',
    'Open-source ChatGPT alternative that runs 100% offline.',
    'https://jan.ai',
    ARRAY['AI', 'LLM', 'Local', 'Privacy', 'Open Source'],
    '{"tier": "Completely free", "free_credits": "Unlimited", "limits": "Only hardware limits"}'::jsonb,
    77,
    77,
    true
  );

-- Insert new Automation tools
INSERT INTO tools (tool_name, summary, url, tags, free_tier_info, popularity_score, display_priority, is_verified)
VALUES
  (
    'Botpress',
    'Open-source platform for building conversational AI bots.',
    'https://botpress.com',
    ARRAY['AI', 'Chatbot', 'Conversational', 'Open Source', 'NLU'],
    '{"tier": "Free self-hosted", "free_credits": "Unlimited", "limits": "Cloud tier: 2000 messages/month"}'::jsonb,
    80,
    83,
    true
  ),
  (
    'Voiceflow',
    'No-code platform for designing and deploying conversational AI.',
    'https://voiceflow.com',
    ARRAY['AI', 'Chatbot', 'No-Code', 'Conversational', 'Design'],
    '{"tier": "Free tier", "free_credits": "Limited projects", "limits": "Sandbox environment only"}'::jsonb,
    78,
    81,
    true
  ),
  (
    'MindStudio',
    'Visual AI app builder for creating custom AI tools.',
    'https://mindstudio.ai',
    ARRAY['AI', 'No-Code', 'App Builder', 'Visual'],
    '{"tier": "Free tier", "free_credits": "Limited AI calls", "limits": "1 app, usage limits"}'::jsonb,
    75,
    78,
    true
  ),
  (
    'Relevance AI',
    'Platform for building multi-agent AI workflows.',
    'https://relevanceai.com',
    ARRAY['AI', 'Multi-Agent', 'Workflow', 'No-Code'],
    '{"tier": "Free tier", "free_credits": "Limited tokens", "limits": "Few agents, restricted features"}'::jsonb,
    73,
    75,
    true
  ),
  (
    'Retool',
    'Low-code platform for building internal tools and dashboards.',
    'https://retool.com',
    ARRAY['Low-Code', 'Dashboard', 'Internal Tools', 'Developer'],
    '{"tier": "Free tier", "free_credits": "Up to 5 users", "limits": "Limited features"}'::jsonb,
    82,
    85,
    true
  ),
  (
    'Bubble',
    'No-code platform for building full-stack web applications.',
    'https://bubble.io',
    ARRAY['No-Code', 'Web App', 'Full-Stack', 'Database'],
    '{"tier": "Free tier", "free_credits": "Development environment", "limits": "Bubble branding, limited capacity"}'::jsonb,
    85,
    88,
    true
  );

-- Insert all Creative/Visual Generation tools (all new)
INSERT INTO tools (tool_name, summary, url, tags, free_tier_info, popularity_score, display_priority, is_verified)
VALUES
  (
    'MidJourney',
    'AI image generation tool creating stunning visual art from text prompts.',
    'https://midjourney.com',
    ARRAY['AI', 'Image Generation', 'Art', 'Creative'],
    '{"tier": "No free tier", "free_credits": "None", "limits": "Subscription required ($10/month)"}'::jsonb,
    94,
    97,
    true
  ),
  (
    'Runway',
    'AI-powered creative suite for video, image, and audio generation.',
    'https://runwayml.com',
    ARRAY['AI', 'Video', 'Image', 'Creative', 'Multimodal'],
    '{"tier": "Free tier", "free_credits": "125 credits", "limits": "Credits for various features"}'::jsonb,
    90,
    94,
    true
  ),
  (
    'Leonardo AI',
    'AI art generator with fine control over style and composition.',
    'https://leonardo.ai',
    ARRAY['AI', 'Image Generation', 'Art', 'Style Control'],
    '{"tier": "Free tier", "free_credits": "150 tokens/day", "limits": "Daily refresh"}'::jsonb,
    86,
    89,
    true
  ),
  (
    'Stable Diffusion',
    'Open-source AI model for generating images from text.',
    'https://stability.ai',
    ARRAY['AI', 'Image Generation', 'Open Source', 'Local'],
    '{"tier": "Open source free", "free_credits": "Unlimited local", "limits": "API has usage fees"}'::jsonb,
    88,
    91,
    true
  ),
  (
    'DALL-E 3',
    'OpenAI image generation model creating realistic images from descriptions.',
    'https://openai.com/dall-e',
    ARRAY['AI', 'Image Generation', 'OpenAI', 'Realistic'],
    '{"tier": "Pay-per-use", "free_credits": "Some trial credits", "limits": "Per-image pricing"}'::jsonb,
    89,
    92,
    true
  ),
  (
    'Ideogram',
    'AI image generator with excellent text rendering in images.',
    'https://ideogram.ai',
    ARRAY['AI', 'Image Generation', 'Text Rendering', 'Design'],
    '{"tier": "Free tier", "free_credits": "25 prompts/day", "limits": "Slow generation queue"}'::jsonb,
    82,
    85,
    true
  ),
  (
    'Pika Labs',
    'AI video generation platform for creating animated videos from text.',
    'https://pika.art',
    ARRAY['AI', 'Video Generation', 'Animation', 'Creative'],
    '{"tier": "Free tier", "free_credits": "Limited generation", "limits": "Queue times, watermark"}'::jsonb,
    81,
    84,
    true
  ),
  (
    'Suno AI',
    'AI music generation creating full songs from text descriptions.',
    'https://suno.ai',
    ARRAY['AI', 'Music', 'Audio', 'Generation'],
    '{"tier": "Free tier", "free_credits": "50 credits/day", "limits": "Non-commercial use"}'::jsonb,
    83,
    86,
    true
  ),
  (
    'ElevenLabs',
    'AI voice generation and cloning with realistic speech synthesis.',
    'https://elevenlabs.io',
    ARRAY['AI', 'Voice', 'Audio', 'Text-to-Speech'],
    '{"tier": "Free tier", "free_credits": "10k characters/month", "limits": "Limited voice cloning"}'::jsonb,
    85,
    88,
    true
  ),
  (
    'Descript',
    'All-in-one audio and video editor with AI transcription and voice cloning.',
    'https://descript.com',
    ARRAY['Audio', 'Video', 'Editing', 'AI', 'Transcription'],
    '{"tier": "Free tier", "free_credits": "1 hour transcription", "limits": "Watermark on exports"}'::jsonb,
    84,
    87,
    true
  );