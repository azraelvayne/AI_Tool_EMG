# 70 Curated Tools Import Guide

## Overview
This guide explains how to import the 70 curated tools from `src/data/tools_dataset.json` into your Supabase database.

## Data Source
- File: `src/data/tools_dataset.json`
- Count: 70 tools
- Batch: v1.1-core-70
- Categories: AI Models, Automation, Databases, Frameworks, etc.

## Import Strategy

### Deduplication Logic
1. Generate `source_slug` from tool name (kebab-case conversion)
2. Check if tool exists by `source_slug`
3. If exists: UPDATE only empty fields (preserve existing data)
4. If not exists: INSERT with `is_curated=true` and `curation_batch="v1.1-core-70"`

### Field Mapping
```
JSON Field → Database Field
----------------------------
name → tool_name
summary → summary
official_url → url
category → mapped to categories.functional_role
tags → used for search/tagging
common_pairings → categories.common_pairings
export_templates → future: export_templates table
```

### Category Mapping Rules
```
"AI模型" → AI Layer, Learning Oriented, AI Assistant role
"AI/資料檢索" → AI Layer, System Oriented, AI Assistant role
"LLM編排" → Integration Layer, Application Oriented, Automation role
"自動化工具" → Integration Layer, Application Oriented, Automation role
"知識管理" → Data Layer, Application Oriented, Database role
"資料庫後端" → Data Layer, System Oriented, Database role
"向量資料庫" → Data Layer, System Oriented, Database role
"部署平台" → Integration Layer, System Oriented, API role
"前端框架" → Frontend Layer, Application Oriented, Frontend role
```

## Import Methods

### Method 1: Database Migration (Recommended)
Run the SQL migration file:
```bash
# Apply migration using Supabase CLI
supabase db push

# Or apply specific migration
psql $DATABASE_URL -f supabase/migrations/20251112145000_import_70_curated_tools.sql
```

### Method 2: Admin Script (Alternative)
Create a Node.js script to process and import:

```javascript
import { createClient } from '@supabase/supabase-js'
import toolsData from './src/data/tools_dataset.json'

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

async function importTools() {
  for (const tool of toolsData) {
    const slug = tool.name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-|-$/g, '')

    const { data: existing } = await supabase
      .from('tools')
      .select('id')
      .eq('source_slug', slug)
      .maybeSingle()

    const toolRecord = {
      tool_name: tool.name,
      summary: tool.summary,
      url: tool.official_url,
      source_slug: slug,
      is_curated: true,
      curation_batch: 'v1.1-core-70',
      categories: mapCategories(tool.category, tool.common_pairings),
      popularity_score: 50
    }

    if (existing) {
      await supabase
        .from('tools')
        .update(toolRecord)
        .eq('id', existing.id)
    } else {
      await supabase
        .from('tools')
        .insert(toolRecord)
    }
  }
}
```

### Method 3: Manual Import via Supabase Studio
1. Go to Supabase Studio → SQL Editor
2. Run import query for batches of 10-20 tools at a time
3. Use the migration SQL as a template

## Verification

After import, verify the data:

```sql
-- Count imported tools
SELECT COUNT(*) FROM tools WHERE is_curated = true AND curation_batch = 'v1.1-core-70';

-- Should return 70 (or number actually imported)

-- Check tools by category
SELECT categories->>'functional_role' as role, COUNT(*)
FROM tools
WHERE is_curated = true
GROUP BY role;

-- List all curated tools
SELECT tool_name, summary, source_slug, is_curated
FROM tools
WHERE curation_batch = 'v1.1-core-70'
ORDER BY tool_name;
```

## Key Tools Included

### AI Models & LLMs
- OpenAI (GPT-4, ChatGPT)
- Anthropic Claude
- Google Gemini
- Cohere
- Mistral AI
- Hugging Face
- Perplexity AI

### AI Frameworks & Tools
- LlamaIndex (RAG framework)
- LangChain (LLM orchestration)
- Flowise (low-code AI flows)
- Ollama (local LLM)

### Automation & Integration
- n8n (workflow automation)
- Zapier (cloud automation)
- Make (visual automation)

### Knowledge & Data Management
- Notion (workspace)
- Airtable (database)
- Obsidian (knowledge base)

### Databases
- Supabase (backend-as-a-service)
- Firebase (Google cloud)
- Pinecone (vector DB)
- Weaviate (vector search)
- Chroma (embeddings DB)
- Qdrant (vector similarity)

### Deployment & Infrastructure
- Vercel (frontend deployment)
- Netlify (Jamstack hosting)
- Railway (app deployment)

### Frontend Frameworks
- Next.js (React framework)
- React (UI library)
- Vue.js (progressive framework)
- Svelte (compiler framework)

## Post-Import Tasks

1. **Add Translations**
   - Add Chinese translations to `tool_translations` table
   - Use existing translation patterns

2. **Create Export Templates**
   - Add n8n workflow templates for popular tools
   - Add Langflow configurations
   - Add Zapier integration guides

3. **Build Tool Pairings**
   - Use `common_pairings` data to populate `tool_pairings` table
   - Add strength scores (0-100)
   - Add rationales

4. **Test Frontend**
   - Verify tools appear in ToolsExplorerPage
   - Test filtering by category
   - Check tool detail modals

## Troubleshooting

**Problem**: Duplicate tools appear
**Solution**: Check source_slug generation, ensure it's consistent

**Problem**: Categories don't match filters
**Solution**: Verify category mapping logic, update migration if needed

**Problem**: Common pairings not showing
**Solution**: Ensure `categories.common_pairings` is properly populated

## Next Steps

After successful import:
1. ✅ Verify 70 tools in database
2. ✅ Test tools appear in frontend
3. ⏭️ Add export templates (Phase 3)
4. ⏭️ Enhance tool detail views with pairings
5. ⏭️ Add multilingual translations
