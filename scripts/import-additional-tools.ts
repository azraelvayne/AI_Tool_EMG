import { readFileSync, writeFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

interface Tool {
  tool_name: string;
  summary: string;
  categories: {
    purpose: string[];
    functional_role: string[];
    application_field: string[];
    tech_layer: string[];
    data_flow_role: string[];
    difficulty: string;
    common_pairings: string[];
  };
  description_styles: {
    encyclopedia: string;
    guide: string;
    strategy: string;
    inspiration: string[];
  };
  use_case_templates: Array<{
    goal: string;
    method: string;
    tool_stack: string[];
    steps: string[];
  }>;
}

function generateSlug(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

function escapeSQL(str: string): string {
  return str.replace(/'/g, "''");
}

function generateMigration(tools: Tool[]): string {
  const timestamp = new Date().toISOString().split('T')[0].replace(/-/g, '');
  const date = new Date();

  let sql = `/*
  # Import 30 Additional Tools - Phase 3 Expansion

  ## Overview
  This migration imports 30 additional tools to expand the database from 70 to 100+ tools.
  Tools include: Airflow, fal, Prefect, Egnyte, Composio, BrightData, ScrapingBee,
  Phantombuster, Thunderbit, Miro, Atlassian, Jam.dev, Temporal, Typedream, Triform,
  Kintone, Kubernetes, Carrd, Mintlify, Zenler, Replicate, Daloopa, LSEG, Spaceship,
  Alpaca, BioRender, Hex, AllTrails, Canva, and Figma.

  ## Data Source
  Generated from additional_tools_dataset.json

  ## Import Strategy
  - Each tool gets a unique UUID
  - Categories are properly mapped to match existing schema
  - Translations are added for zh-TW locale
  - Common pairings are stored in categories

  ## Date
  Generated: ${date.toISOString()}
*/

-- Import tools
DO $$
DECLARE
  tool_id UUID;
BEGIN
`;

  tools.forEach((tool, index) => {
    const slug = generateSlug(tool.tool_name);
    const toolName = escapeSQL(tool.tool_name);
    const summary = escapeSQL(tool.summary);

    // Generate categories JSON
    const categoriesJSON = {
      purpose: tool.categories.purpose || [],
      functional_role: tool.categories.functional_role || [],
      application_field: tool.categories.application_field || [],
      tech_layer: tool.categories.tech_layer || [],
      data_flow_role: tool.categories.data_flow_role || [],
      difficulty: tool.categories.difficulty || 'Low-code',
      common_pairings: tool.categories.common_pairings || []
    };

    // Generate description_styles JSON (keep Chinese for now, will add to translations)
    const descriptionStylesJSON = {
      encyclopedia: escapeSQL(tool.description_styles.encyclopedia || ''),
      guide: escapeSQL(tool.description_styles.guide || ''),
      strategy: escapeSQL(tool.description_styles.strategy || ''),
      inspiration: (tool.description_styles.inspiration || []).map(i => escapeSQL(i))
    };

    // Generate use_case_templates JSON
    const useCaseTemplatesJSON = (tool.use_case_templates || []).map(uc => ({
      goal: escapeSQL(uc.goal || ''),
      method: escapeSQL(uc.method || ''),
      tool_stack: uc.tool_stack || [],
      steps: (uc.steps || []).map(s => escapeSQL(s))
    }));

    sql += `
  -- ${index + 1}. ${toolName}
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    '${toolName}',
    '${summary}',
    '${slug}',
    '${JSON.stringify(categoriesJSON).replace(/'/g, "''")}'::jsonb,
    '${JSON.stringify(descriptionStylesJSON).replace(/'/g, "''")}'::jsonb,
    '${JSON.stringify(useCaseTemplatesJSON).replace(/'/g, "''")}'::jsonb,
    true,
    'v3.0-expansion-30',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (source_slug) DO UPDATE SET
    tool_name = EXCLUDED.tool_name,
    summary = EXCLUDED.summary,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-30',
    updated_at = NOW();

  -- Add zh-TW translation for ${toolName}
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    '${summary}',
    '${JSON.stringify(descriptionStylesJSON).replace(/'/g, "''")}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;
`;
  });

  sql += `
END $$;

-- Add comment
COMMENT ON TABLE tools IS 'Updated with 30 additional tools from Phase 3 expansion';
`;

  return sql;
}

// Main execution
try {
  console.log('Reading additional_tools_dataset.json...');
  const dataPath = join(__dirname, 'data', 'additional_tools_dataset.json');
  const data = readFileSync(dataPath, 'utf-8');
  const tools: Tool[] = JSON.parse(data);

  console.log(`Found ${tools.length} tools to import`);

  console.log('Generating migration SQL...');
  const migrationSQL = generateMigration(tools);

  const timestamp = new Date().toISOString().replace(/[:.]/g, '').replace('T', '_').slice(0, 15);
  const outputPath = join(__dirname, '..', 'supabase', 'migrations', `${timestamp}_import_30_additional_tools.sql`);

  writeFileSync(outputPath, migrationSQL);
  console.log(`Migration file created: ${outputPath}`);
  console.log(`\nTo apply this migration:`);
  console.log(`1. Review the generated SQL file`);
  console.log(`2. Run: supabase db push (if using Supabase CLI)`);
  console.log(`   OR manually execute the SQL in Supabase Studio`);

} catch (error) {
  console.error('Error generating migration:', error);
  process.exit(1);
}
