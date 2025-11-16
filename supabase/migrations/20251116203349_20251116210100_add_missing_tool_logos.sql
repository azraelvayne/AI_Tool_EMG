/*
  # Add Missing Tool Logos (45 Tools)

  ## Overview
  This migration adds icon_url entries for 45 tools that were missing logos.
  Uses Simple Icons CDN for brand recognition and visual consistency.

  ## Changes
  Adds logos for:
  - Cloud storage tools (AWS S3, Dropbox, Google Drive, OneDrive, Box, etc.)
  - AI/LLM tools (DALL-E, Groq, LangChain, Llama, Stable Diffusion, etc.)
  - Automation platforms (Power Automate, Workato, Tray.io, Automate.io)
  - Development tools (Stack Overflow, Replicate, Pinecone, etc.)
  - Media tools (Descript, Cloudinary, etc.)

  ## Icon Sources
  - Simple Icons CDN (https://simpleicons.org)
  - Brand-accurate colors and designs
  - Fallback generic icons where brand logos unavailable

  ## Security
  - No RLS changes
  - Read-only updates to existing records
*/

-- Cloud Storage Tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/amazons3/569A31' WHERE tool_name = 'AWS S3';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/dropbox/0061FF' WHERE tool_name = 'Dropbox';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/googledrive/4285F4' WHERE tool_name = 'Google Drive';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/microsoftonedrive/0078D4' WHERE tool_name = 'OneDrive';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/box/0061D5' WHERE tool_name = 'Box';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/backblaze/E1232B' WHERE tool_name ILIKE '%Backblaze%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/pcloud/00A0F0' WHERE tool_name = 'pCloud';

-- AI/LLM Tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/openai/412991' WHERE tool_name = 'DALL-E 3' OR tool_name = 'DALL·E 3';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/langchain/1C3C3C' WHERE tool_name = 'LangChain';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/meta/0467DF' WHERE tool_name ILIKE '%Llama%2%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/stabilityai/5C32E0' WHERE tool_name ILIKE '%Stable%Diffusion%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/perplexity/20808D' WHERE tool_name ILIKE '%Perplexity%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/groq/F55036' WHERE tool_name = 'Groq';

-- Automation Platforms
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/powerautomate/0066FF' WHERE tool_name ILIKE '%Power%Automate%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/workato/6B4FBB' WHERE tool_name = 'Workato';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/automation/FF6B35' WHERE tool_name = 'Tray.io';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/automation/4A90E2' WHERE tool_name = 'Automate.io';

-- Development & Infrastructure Tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/stackoverflow/F58025' WHERE tool_name ILIKE '%Stack%Overflow%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/replicate/000000' WHERE tool_name = 'Replicate';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/pinecone/000000' WHERE tool_name = 'Pinecone';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/drizzle/C5F74F' WHERE tool_name ILIKE '%Drizzle%ORM%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/openrouter/412991' WHERE tool_name = 'OpenRouter';

-- Media & Content Tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/descript/4353FF' WHERE tool_name = 'Descript';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/cloudinary/3448C5' WHERE tool_name = 'Cloudinary';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/filestack/FF6B6B' WHERE tool_name = 'Filestack';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/uploadcare/1E88E5' WHERE tool_name = 'UploadCare';

-- AI Image Generation Tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/midjourney/000000' WHERE tool_name = 'MidJourney';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/ideogram/7C3AED' WHERE tool_name = 'Ideogram';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/runway/000000' WHERE tool_name ILIKE '%Pika%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/suno/8B5CF6' WHERE tool_name ILIKE '%Suno%';

-- AI Platforms & Services
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/botpress/6B46FF' WHERE tool_name = 'Botpress';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/together/FF6B6B' WHERE tool_name ILIKE '%Together%AI%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/mindstudio/7C3AED' WHERE tool_name = 'MindStudio';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/lmstudio/5C6BC0' WHERE tool_name = 'LM Studio';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/janai/000000' WHERE tool_name = 'Jan AI';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/relevance/4A5568' WHERE tool_name ILIKE '%Relevance%';

-- Voice & Communication AI
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/retell/7C3AED' WHERE tool_name ILIKE '%Retell%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/vapi/6366F1' WHERE tool_name = 'Vapi.ai';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/notta/FF6B6B' WHERE tool_name = 'Notta.ai';

-- Analytics & Sales Tools
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/apachesuperset/20A6C9' WHERE tool_name ILIKE '%Apache%Superset%';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/apollo/7C3AED' WHERE tool_name = 'Apollo.io';

-- AI Tools & Platforms
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/kluster/5B21B6' WHERE tool_name = 'Kluster.ai';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/inkeep/4F46E5' WHERE tool_name = 'Inkeep';
UPDATE tools SET icon_url = 'https://cdn.simpleicons.org/dyad/FF6B6B' WHERE tool_name = 'Dyad.sh';
