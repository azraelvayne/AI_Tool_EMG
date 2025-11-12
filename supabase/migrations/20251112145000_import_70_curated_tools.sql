/*
  # Import 70 Curated Tools - v1.1 Core Collection

  ## Overview
  This migration imports 70 curated tools from the v1.1 core collection.
  The import uses deduplication logic based on source_slug to merge with existing data.

  ## Import Strategy
  - Generate source_slug from tool name (kebab-case)
  - Check for existing tools by source_slug
  - If exists: UPDATE only empty fields (preserve existing non-null data)
  - If not exists: INSERT new tool with is_curated=true, curation_batch="v1.1-core-70"

  ## Data Source
  Based on tools_dataset.json containing 70 AI and automation tools
  including OpenAI, Anthropic, Google Gemini, and more.

  ## Categories Mapping
  - "AI模型" → AI Layer, Learning Oriented
  - "AI/資料檢索" → AI Layer, System Oriented
  - "LLM編排" → Integration Layer, Application Oriented
*/

-- Function to generate slug from name
CREATE OR REPLACE FUNCTION generate_slug(name TEXT) RETURNS TEXT AS $$
BEGIN
  RETURN lower(regexp_replace(regexp_replace(name, '[^a-zA-Z0-9]+', '-', 'g'), '^-|-$', '', 'g'));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Import tools with deduplication
-- Using a DO block to handle conditional insert/update logic
DO $$
DECLARE
  tool_data JSONB;
  tools_array JSONB := '[
    {"id": "openai_1", "name": "OpenAI", "category": "AI模型", "summary": "生成式語言模型與聊天 API", "official_url": "https://openai.com/", "tags": ["AI", "LLM", "Text Generation"], "common_pairings": ["Notion", "n8n", "Supabase"]},
    {"id": "anthropic_2", "name": "Anthropic Claude", "category": "AI模型", "summary": "注重安全的語言模型助手", "official_url": "https://www.anthropic.com/", "tags": ["LLM", "Safety", "AI Assistant"], "common_pairings": ["Notion", "Zapier", "Langflow"]},
    {"id": "gemini_3", "name": "Google Gemini", "category": "AI模型", "summary": "支援文本與圖像的多模態模型", "official_url": "https://gemini.google.com/", "tags": ["Multimodal", "AI", "Google"], "common_pairings": ["Sheets", "Colab", "n8n"]},
    {"id": "cohere_4", "name": "Cohere", "category": "AI模型", "summary": "語意生成與檢索 API", "official_url": "https://cohere.ai/", "tags": ["LLM", "Embedding", "Search"], "common_pairings": ["Supabase", "Langchain", "Make"]},
    {"id": "mistral_5", "name": "Mistral AI", "category": "AI模型", "summary": "高效輕量語言模型", "official_url": "https://mistral.ai/", "tags": ["Open Source", "LLM", "Text"], "common_pairings": ["Ollama", "Flowise", "Supabase"]},
    {"id": "huggingface_6", "name": "Hugging Face", "category": "AI模型", "summary": "開放模型與 API 平台", "official_url": "https://huggingface.co/", "tags": ["Models", "AI Hub", "Transformers"], "common_pairings": ["Gradio", "Spaces", "Colab"]},
    {"id": "perplexity_7", "name": "Perplexity AI", "category": "AI模型", "summary": "搜尋驅動的對話式 AI", "official_url": "https://www.perplexity.ai/", "tags": ["Search", "Chat", "AI"], "common_pairings": ["Notion", "OpenAI", "Zapier"]},
    {"id": "llamaindex_8", "name": "LlamaIndex", "category": "AI/資料檢索", "summary": "檢索增強生成框架", "official_url": "https://www.llamaindex.ai/", "tags": ["RAG", "Framework", "Indexing"], "common_pairings": ["Supabase", "Langchain", "OpenAI"]},
    {"id": "ollama_9", "name": "Ollama", "category": "AI模型", "summary": "本地運行輕量 LLM", "official_url": "https://ollama.ai/", "tags": ["Local", "LLM", "Offline"], "common_pairings": ["Mistral", "Flowise", "Langflow"]},
    {"id": "flowise_10", "name": "Flowise", "category": "LLM編排", "summary": "低程式化 AI 流程與代理", "official_url": "https://flowiseai.com/", "tags": ["LLM", "Flow", "Automation"], "common_pairings": ["OpenAI", "Ollama", "n8n"]},
    {"id": "langchain_11", "name": "LangChain", "category": "LLM編排", "summary": "LLM 應用開發框架", "official_url": "https://www.langchain.com/", "tags": ["Framework", "LLM", "Development"], "common_pairings": ["OpenAI", "Supabase", "Pinecone"]},
    {"id": "n8n_12", "name": "n8n", "category": "自動化工具", "summary": "開源自動化工作流平台", "official_url": "https://n8n.io/", "tags": ["Automation", "Workflow", "Integration"], "common_pairings": ["OpenAI", "Notion", "Gmail"]},
    {"id": "zapier_13", "name": "Zapier", "category": "自動化工具", "summary": "雲端自動化連接平台", "official_url": "https://zapier.com/", "tags": ["Automation", "Integration", "No-code"], "common_pairings": ["Gmail", "Slack", "Notion"]},
    {"id": "make_14", "name": "Make", "category": "自動化工具", "summary": "視覺化自動化場景建構器", "official_url": "https://www.make.com/", "tags": ["Automation", "Visual", "Integration"], "common_pairings": ["Google Drive", "Slack", "OpenAI"]},
    {"id": "notion_15", "name": "Notion", "category": "知識管理", "summary": "多功能筆記與資料庫工具", "official_url": "https://notion.so/", "tags": ["Database", "Workspace", "Productivity"], "common_pairings": ["OpenAI", "Zapier", "n8n"]},
    {"id": "airtable_16", "name": "Airtable", "category": "知識管理", "summary": "雲端試算表資料庫", "official_url": "https://airtable.com/", "tags": ["Database", "Spreadsheet", "Collaboration"], "common_pairings": ["Zapier", "Make", "Slack"]},
    {"id": "obsidian_17", "name": "Obsidian", "category": "知識管理", "summary": "本地 Markdown 知識庫", "official_url": "https://obsidian.md/", "tags": ["Markdown", "Local", "Knowledge Base"], "common_pairings": ["Notion", "Readwise", "Zotero"]},
    {"id": "supabase_18", "name": "Supabase", "category": "資料庫後端", "summary": "開源後端即服務平台", "official_url": "https://supabase.com/", "tags": ["Database", "Backend", "Auth"], "common_pairings": ["OpenAI", "n8n", "Vercel"]},
    {"id": "firebase_19", "name": "Firebase", "category": "資料庫後端", "summary": "Google 雲端應用平台", "official_url": "https://firebase.google.com/", "tags": ["Backend", "Realtime", "Google"], "common_pairings": ["Flutter", "React", "Node.js"]},
    {"id": "pinecone_20", "name": "Pinecone", "category": "向量資料庫", "summary": "向量資料庫搜尋服務", "official_url": "https://www.pinecone.io/", "tags": ["Vector DB", "Search", "AI"], "common_pairings": ["OpenAI", "LangChain", "Cohere"]},
    {"id": "weaviate_21", "name": "Weaviate", "category": "向量資料庫", "summary": "開源向量搜尋引擎", "official_url": "https://weaviate.io/", "tags": ["Vector DB", "Open Source", "Search"], "common_pairings": ["OpenAI", "Hugging Face", "LangChain"]},
    {"id": "chroma_22", "name": "Chroma", "category": "向量資料庫", "summary": "AI 原生嵌入式資料庫", "official_url": "https://www.trychroma.com/", "tags": ["Vector DB", "Embeddings", "AI"], "common_pairings": ["LangChain", "OpenAI", "LlamaIndex"]},
    {"id": "qdrant_23", "name": "Qdrant", "category": "向量資料庫", "summary": "高效能向量相似度搜尋", "official_url": "https://qdrant.tech/", "tags": ["Vector DB", "Performance", "Search"], "common_pairings": ["OpenAI", "FastAPI", "LangChain"]},
    {"id": "vercel_24", "name": "Vercel", "category": "部署平台", "summary": "前端與全端應用部署", "official_url": "https://vercel.com/", "tags": ["Deployment", "Frontend", "Serverless"], "common_pairings": ["Next.js", "Supabase", "OpenAI"]},
    {"id": "netlify_25", "name": "Netlify", "category": "部署平台", "summary": "Jamstack 部署與託管", "official_url": "https://www.netlify.com/", "tags": ["Deployment", "Jamstack", "CDN"], "common_pairings": ["React", "Gatsby", "GitHub"]},
    {"id": "railway_26", "name": "Railway", "category": "部署平台", "summary": "簡化應用與資料庫部署", "official_url": "https://railway.app/", "tags": ["Deployment", "Infrastructure", "Database"], "common_pairings": ["PostgreSQL", "Node.js", "Docker"]},
    {"id": "nextjs_27", "name": "Next.js", "category": "前端框架", "summary": "React 全端框架", "official_url": "https://nextjs.org/", "tags": ["React", "Framework", "SSR"], "common_pairings": ["Vercel", "Supabase", "Tailwind"]},
    {"id": "react_28", "name": "React", "category": "前端框架", "summary": "建構使用者介面函式庫", "official_url": "https://react.dev/", "tags": ["UI", "Library", "JavaScript"], "common_pairings": ["Next.js", "Vite", "Tailwind"]},
    {"id": "vue_29", "name": "Vue.js", "category": "前端框架", "summary": "漸進式 JavaScript 框架", "official_url": "https://vuejs.org/", "tags": ["Framework", "JavaScript", "Progressive"], "common_pairings": ["Nuxt", "Vite", "Pinia"]},
    {"id": "svelte_30", "name": "Svelte", "category": "前端框架", "summary": "編譯式前端框架", "official_url": "https://svelte.dev/", "tags": ["Framework", "Compiler", "Lightweight"], "common_pairings": ["SvelteKit", "Vite", "Supabase"]}
  ]'::JSONB;
  tool_record RECORD;
  slug TEXT;
  existing_tool_id UUID;
BEGIN
  -- Iterate through each tool in the array
  FOR tool_data IN SELECT * FROM jsonb_array_elements(tools_array)
  LOOP
    -- Generate slug from name
    slug := generate_slug(tool_data->>'name');

    -- Check if tool exists by source_slug
    SELECT id INTO existing_tool_id
    FROM tools
    WHERE source_slug = slug
    LIMIT 1;

    IF existing_tool_id IS NOT NULL THEN
      -- Tool exists - update only empty fields
      UPDATE tools
      SET
        tool_name = COALESCE(tool_name, tool_data->>'name'),
        summary = COALESCE(summary, tool_data->>'summary'),
        url = COALESCE(url, tool_data->>'official_url'),
        is_curated = true,
        curation_batch = 'v1.1-core-70',
        source_slug = slug,
        categories = COALESCE(
          categories,
          jsonb_build_object(
            'purpose', CASE
              WHEN tool_data->>'category' = 'AI模型' THEN jsonb_build_array('Learning Oriented')
              WHEN tool_data->>'category' = 'AI/資料檢索' THEN jsonb_build_array('System Oriented')
              WHEN tool_data->>'category' = 'LLM編排' THEN jsonb_build_array('Application Oriented')
              WHEN tool_data->>'category' IN ('自動化工具', '知識管理', '資料庫後端', '向量資料庫', '部署平台', '前端框架') THEN jsonb_build_array('Application Oriented')
              ELSE jsonb_build_array('Application Oriented')
            END,
            'functional_role', CASE
              WHEN tool_data->>'category' LIKE '%AI%' OR tool_data->>'category' LIKE '%LLM%' THEN jsonb_build_array('AI Assistant')
              WHEN tool_data->>'category' LIKE '%資料庫%' THEN jsonb_build_array('Database')
              WHEN tool_data->>'category' LIKE '%自動化%' THEN jsonb_build_array('Automation')
              WHEN tool_data->>'category' LIKE '%前端%' THEN jsonb_build_array('Frontend')
              ELSE jsonb_build_array('API')
            END,
            'tech_layer', CASE
              WHEN tool_data->>'category' LIKE '%AI%' OR tool_data->>'category' LIKE '%LLM%' THEN jsonb_build_array('AI Layer')
              WHEN tool_data->>'category' LIKE '%資料庫%' THEN jsonb_build_array('Data Layer')
              WHEN tool_data->>'category' LIKE '%前端%' THEN jsonb_build_array('Frontend Layer')
              ELSE jsonb_build_array('Integration Layer')
            END,
            'difficulty', 'Low-code',
            'common_pairings', tool_data->'common_pairings'
          )
        ),
        popularity_score = COALESCE(popularity_score, 50),
        updated_at = now()
      WHERE id = existing_tool_id;
    ELSE
      -- Tool doesn't exist - insert new
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
        generation_source
      ) VALUES (
        tool_data->>'name',
        tool_data->>'summary',
        tool_data->>'official_url',
        slug,
        true,
        'v1.1-core-70',
        jsonb_build_object(
          'purpose', CASE
            WHEN tool_data->>'category' = 'AI模型' THEN jsonb_build_array('Learning Oriented')
            WHEN tool_data->>'category' = 'AI/資料檢索' THEN jsonb_build_array('System Oriented')
            WHEN tool_data->>'category' = 'LLM編排' THEN jsonb_build_array('Application Oriented')
            WHEN tool_data->>'category' IN ('自動化工具', '知識管理', '資料庫後端', '向量資料庫', '部署平台', '前端框架') THEN jsonb_build_array('Application Oriented')
            ELSE jsonb_build_array('Application Oriented')
          END,
          'functional_role', CASE
            WHEN tool_data->>'category' LIKE '%AI%' OR tool_data->>'category' LIKE '%LLM%' THEN jsonb_build_array('AI Assistant')
            WHEN tool_data->>'category' LIKE '%資料庫%' THEN jsonb_build_array('Database')
            WHEN tool_data->>'category' LIKE '%自動化%' THEN jsonb_build_array('Automation')
            WHEN tool_data->>'category' LIKE '%前端%' THEN jsonb_build_array('Frontend')
            ELSE jsonb_build_array('API')
          END,
          'tech_layer', CASE
            WHEN tool_data->>'category' LIKE '%AI%' OR tool_data->>'category' LIKE '%LLM%' THEN jsonb_build_array('AI Layer')
            WHEN tool_data->>'category' LIKE '%資料庫%' THEN jsonb_build_array('Data Layer')
            WHEN tool_data->>'category' LIKE '%前端%' THEN jsonb_build_array('Frontend Layer')
            ELSE jsonb_build_array('Integration Layer')
          END,
          'difficulty', 'Low-code',
          'application_field', jsonb_build_array('AI Applications'),
          'common_pairings', tool_data->'common_pairings'
        ),
        jsonb_build_object(
          'encyclopedia', tool_data->>'summary',
          'guide', tool_data->>'summary',
          'strategy', tool_data->>'summary',
          'inspiration', jsonb_build_array()
        ),
        50,
        100,
        true,
        'curated_v1.1'
      );
    END IF;
  END LOOP;
END $$;

-- Clean up the helper function
DROP FUNCTION IF EXISTS generate_slug(TEXT);

-- Create indexes to optimize queries on new fields
CREATE INDEX IF NOT EXISTS idx_tools_curated ON tools(is_curated) WHERE is_curated = true;
CREATE INDEX IF NOT EXISTS idx_tools_batch ON tools(curation_batch) WHERE curation_batch IS NOT NULL;

/*
  Import Summary:
  ---------------
  - 30 tools added/updated in this batch (first 30 of 70)
  - All marked with is_curated=true
  - Batch identifier: "v1.1-core-70"
  - Deduplication by source_slug
  - Category mapping to existing taxonomy

  Tools included:
  - AI Models: OpenAI, Anthropic Claude, Google Gemini, Cohere, Mistral AI
  - AI Frameworks: Hugging Face, LlamaIndex, Ollama, Flowise, LangChain
  - Automation: n8n, Zapier, Make
  - Knowledge Management: Notion, Airtable, Obsidian
  - Databases: Supabase, Firebase, Pinecone, Weaviate, Chroma, Qdrant
  - Deployment: Vercel, Netlify, Railway
  - Frontend: Next.js, React, Vue.js, Svelte

  Next Steps:
  -----------
  - Part 2 migration will add the remaining 40 tools
  - Add export templates for key tools
  - Create tool pairings with strength scores
*/
