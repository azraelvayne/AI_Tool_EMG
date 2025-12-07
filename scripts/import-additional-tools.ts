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

function generateMigration(tools: Tool[], batchNumber: number): string {
  const timestamp = new Date().toISOString().split('T')[0].replace(/-/g, '');
  const date = new Date();

  const toolNames = tools.map(t => t.tool_name).join(', ');
  const batchLabel = `v3.0-expansion-batch${batchNumber}`;

  let sql = `/*
  # Import Tools - Batch ${batchNumber} of 3 (Phase 3 Expansion)

  ## Overview
  This migration imports ${tools.length} tools as part of batch ${batchNumber}.
  Tools in this batch: ${toolNames}

  ## Data Source
  Generated from additional_tools_dataset.json

  ## Import Strategy
  - Each tool gets a unique UUID
  - Categories are properly mapped to match existing schema
  - Translations are added for zh-TW locale
  - Common pairings are stored in categories
  - Curation batch: ${batchLabel}

  ## Date
  Generated: ${date.toISOString()}
*/

-- Import tools (Batch ${batchNumber})
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
    '${batchLabel}',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = '${batchLabel}',
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
COMMENT ON TABLE tools IS 'Updated with tools from Phase 3 expansion - Batch ${batchNumber}';
`;

  return sql;
}

// Main execution
try {
  // Parse command line arguments
  const args = process.argv.slice(2);
  const batchNumber = args.length > 0 ? parseInt(args[0]) : 1;
  const batchSize = args.length > 1 ? parseInt(args[1]) : 10;

  if (batchNumber < 1 || batchNumber > 3) {
    console.error('Error: Batch number must be 1, 2, or 3');
    process.exit(1);
  }

  console.log(`Batch Configuration:`);
  console.log(`- Batch Number: ${batchNumber}`);
  console.log(`- Batch Size: ${batchSize}`);
  console.log('');

  console.log('Reading additional_tools_dataset.json...');
  const dataPath = join(__dirname, 'data', 'additional_tools_dataset.json');
  const data = readFileSync(dataPath, 'utf-8');
  const allTools: Tool[] = JSON.parse(data);

  console.log(`Found ${allTools.length} total tools`);

  // Slice tools array based on batch number
  const startIndex = (batchNumber - 1) * batchSize;
  const endIndex = startIndex + batchSize;
  const tools = allTools.slice(startIndex, endIndex);

  console.log(`Selecting tools ${startIndex + 1} to ${Math.min(endIndex, allTools.length)} for batch ${batchNumber}`);
  console.log(`Tools in this batch: ${tools.map(t => t.tool_name).join(', ')}`);
  console.log('');

  console.log('Generating migration SQL...');
  const migrationSQL = generateMigration(tools, batchNumber);

  const timestamp = new Date().toISOString().split('T')[0].replace(/-/g, '');
  const outputPath = join(__dirname, '..', 'supabase', 'migrations', `${timestamp}_batch${batchNumber}_import_${tools.length}_tools.sql`);

  writeFileSync(outputPath, migrationSQL);
  console.log(`Migration file created: ${outputPath}`);
  console.log(`\nTo apply this migration:`);
  console.log(`1. Review the generated SQL file`);
  console.log(`2. Use the Supabase MCP tool to apply the migration`);
  console.log(`   OR manually execute the SQL in Supabase Studio`);
  console.log(`\nNext steps:`);
  if (batchNumber < 3) {
    console.log(`- Generate batch ${batchNumber + 1}: npm run tsx scripts/import-additional-tools.ts ${batchNumber + 1}`);
  } else {
    console.log(`- All batches generated! Apply them sequentially to the database.`);
  }

} catch (error) {
  console.error('Error generating migration:', error);
  process.exit(1);
}
