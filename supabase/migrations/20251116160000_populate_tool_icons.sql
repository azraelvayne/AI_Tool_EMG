/*
  # Populate Tool Icons from Simple Icons

  ## Overview
  This migration populates the icon_url column in the tools table with
  Simple Icons CDN URLs for visual recognition and branding.

  ## Changes
  - Updates icon_url for all 67+ tools with matching Simple Icons
  - Uses cdn.simpleicons.org for reliable, fast icon delivery
  - Colors are carefully chosen to match brand guidelines
  - Fallback icons use generic representations for missing logos

  ## Icon Source
  Simple Icons (https://simpleicons.org) - Free, open-source brand icons
*/

-- Update icon URLs for AI/LLM tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/openai/412991' WHERE tool_name = 'OpenAI';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/anthropic/CA8B61' WHERE tool_name ILIKE '%Claude%' OR tool_name = 'Anthropic';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/googlegemini/8E75B2' WHERE tool_name ILIKE '%Gemini%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/cohere/39594D' WHERE tool_name = 'Cohere';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/mistral/F7D046' WHERE tool_name ILIKE '%Mistral%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/huggingface/FFD21E' WHERE tool_name ILIKE '%Hugging%Face%' OR tool_name = 'HuggingFace';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/perplexity/20808D' WHERE tool_name = 'Perplexity';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/llamaindex/6F42C1' WHERE tool_name = 'LlamaIndex';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/ollama/000000' WHERE tool_name = 'Ollama';

-- Update icon URLs for LLM orchestration tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/flowise/3B82F6' WHERE tool_name = 'Flowise';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/langflow/1A56DB' WHERE tool_name = 'Langflow';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/dify/155EEF' WHERE tool_name ILIKE '%Dify%';

-- Update icon URLs for automation tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/pipedream/2D3748' WHERE tool_name = 'Pipedream';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/n8n/EA4B71' WHERE tool_name = 'n8n';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/make/6D00CC' WHERE tool_name = 'Make' OR tool_name ILIKE '%Integromat%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/zapier/FF4A00' WHERE tool_name = 'Zapier';

-- Update icon URLs for API development tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/apidog/00D4AA' WHERE tool_name = 'Apidog';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/postman/FF6C37' WHERE tool_name = 'Postman';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/swagger/85EA2D' WHERE tool_name ILIKE '%Swagger%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/awslambda/FF9900' WHERE tool_name ILIKE '%AWS%Lambda%' OR tool_name = 'Lambda';

-- Update icon URLs for database and storage tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/supabase/3FCF8E' WHERE tool_name = 'Supabase';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/airtable/18BFFF' WHERE tool_name = 'Airtable';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/notion/000000' WHERE tool_name = 'Notion';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/prisma/2D3748' WHERE tool_name = 'Prisma';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/drizzle/C5F74F' WHERE tool_name = 'Drizzle';

-- Update icon URLs for no-code/low-code platforms
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/retool/3D3D3D' WHERE tool_name = 'Retool';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/replit/F26207' WHERE tool_name = 'Replit';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/bubble/0061FF' WHERE tool_name ILIKE '%Bubble%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/softr/5E3DB8' WHERE tool_name = 'Softr';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/glide/6B46FF' WHERE tool_name = 'Glide';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/webflow/4353FF' WHERE tool_name = 'Webflow';

-- Update icon URLs for design tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/figma/F24E1E' WHERE tool_name = 'Figma';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/canva/00C4CC' WHERE tool_name = 'Canva';

-- Update icon URLs for image generation tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/midjourney/000000' WHERE tool_name = 'Midjourney';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/runway/000000' WHERE tool_name = 'Runway';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/stabilityai/5C32E0' WHERE tool_name ILIKE '%Stability%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/leonardo/8B5CF6' WHERE tool_name ILIKE '%Leonardo%';

-- Update icon URLs for writing tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/jasper/FF4785' WHERE tool_name = 'Jasper';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/grammarly/15C39A' WHERE tool_name = 'Grammarly';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/chatbot/3B82F6' WHERE tool_name ILIKE '%ChatPDF%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/googledocs/4285F4' WHERE tool_name ILIKE '%DocGPT%';

-- Update icon URLs for voice tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/voiceflow/5340FF' WHERE tool_name = 'Voiceflow';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/elevenlabs/000000' WHERE tool_name = 'ElevenLabs' OR tool_name = '11Labs';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/assemblyai/00D4AA' WHERE tool_name = 'AssemblyAI';

-- Update icon URLs for project management tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/salesforce/00A1E0' WHERE tool_name ILIKE '%Salesforce%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/monday/FF3D57' WHERE tool_name ILIKE '%Monday%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/clickup/7B68EE' WHERE tool_name = 'ClickUp';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/trello/0052CC' WHERE tool_name = 'Trello';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/linear/5E6AD2' WHERE tool_name = 'Linear';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/jira/0052CC' WHERE tool_name = 'Jira';

-- Update icon URLs for analytics tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/metabase/509EE3' WHERE tool_name = 'Metabase';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/apachesuperset/20A6C9' WHERE tool_name = 'Superset';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/hex/8B5CF6' WHERE tool_name = 'Hex';

-- Update icon URLs for database tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/databricks/FF3621' WHERE tool_name ILIKE '%dbdiagram%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/datagrip/000000' WHERE tool_name = 'DataGrip';

-- Update icon URLs for dev tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/livekit/5865F2' WHERE tool_name = 'Livekit' OR tool_name = 'LiveKit';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/chainlink/375BD2' WHERE tool_name = 'Chainlit';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/gradio/FF7C00' WHERE tool_name = 'Gradio';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/kaggle/20BEFF' WHERE tool_name = 'Kaggle';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/githubcopilot/000000' WHERE tool_name ILIKE '%Copilot%';

-- Add index on icon_url for performance
CREATE INDEX IF NOT EXISTS idx_tools_icon_url ON tools(icon_url) WHERE icon_url IS NOT NULL;
