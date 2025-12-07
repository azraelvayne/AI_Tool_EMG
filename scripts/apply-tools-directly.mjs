import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { createClient } from '@supabase/supabase-js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Read .env file manually
const envPath = join(__dirname, '..', '.env');
const envContent = readFileSync(envPath, 'utf-8');
const env = {};
envContent.split('\n').forEach(line => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match) {
    env[match[1].trim()] = match[2].trim().replace(/^["']|["']$/g, '');
  }
});

const supabaseUrl = env.VITE_SUPABASE_URL || process.env.VITE_SUPABASE_URL;
const supabaseKey = env.VITE_SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function getToolCount() {
  const { count } = await supabase.from('tools').select('*', { count: 'exact', head: true });
  return count || 0;
}

async function insertTool(tool) {
  const { data: existingTool } = await supabase
    .from('tools')
    .select('id')
    .eq('tool_name', tool.tool_name)
    .maybeSingle();

  let toolId;

  if (existingTool) {
    const { data, error } = await supabase
      .from('tools')
      .update({
        summary: tool.summary,
        source_slug: tool.source_slug,
        categories: tool.categories,
        description_styles: tool.description_styles,
        use_case_templates: tool.use_case_templates,
        is_curated: true,
        curation_batch: tool.curation_batch,
        updated_at: new Date().toISOString()
      })
      .eq('tool_name', tool.tool_name)
      .select('id')
      .single();

    if (error) throw error;
    toolId = data.id;
    console.log(`  ↻ Updated: ${tool.tool_name}`);
  } else {
    const { data, error } = await supabase
      .from('tools')
      .insert({
        tool_name: tool.tool_name,
        summary: tool.summary,
        source_slug: tool.source_slug,
        categories: tool.categories,
        description_styles: tool.description_styles,
        use_case_templates: tool.use_case_templates,
        is_curated: true,
        curation_batch: tool.curation_batch,
        generation_source: 'claude-ai',
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select('id')
      .single();

    if (error) throw error;
    toolId = data.id;
    console.log(`  ✓ Inserted: ${tool.tool_name}`);
  }

  const { error: translationError } = await supabase
    .from('tool_translations')
    .upsert({
      tool_id: toolId,
      language_code: 'zh-TW',
      summary: tool.summary,
      description_styles: tool.description_styles
    }, {
      onConflict: 'tool_id,language_code'
    });

  if (translationError) throw translationError;
}

function generateSlug(name) {
  return name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

async function main() {
  console.log('=== Importing 30 Tools (3 Batches) ===\n');

  const initialCount = await getToolCount();
  console.log(`Initial tool count: ${initialCount}\n`);

  const dataPath = join(__dirname, 'data', 'additional_tools_dataset copy copy.json');
  const toolsData = JSON.parse(readFileSync(dataPath, 'utf-8'));

  for (let batch = 1; batch <= 3; batch++) {
    const startIdx = (batch - 1) * 10;
    const batchTools = toolsData.slice(startIdx, startIdx + 10);

    console.log(`Batch ${batch}:`);

    for (const toolData of batchTools) {
      try {
        await insertTool({
          tool_name: toolData.tool_name,
          summary: toolData.summary,
          source_slug: generateSlug(toolData.tool_name),
          categories: toolData.categories,
          description_styles: toolData.description_styles,
          use_case_templates: toolData.use_case_templates || [],
          curation_batch: `v3.0-expansion-batch${batch}`
        });
      } catch (error) {
        console.error(`  ✗ Failed ${toolData.tool_name}:`, error.message);
      }
    }

    const currentCount = await getToolCount();
    console.log(`  Count: ${currentCount} (+${currentCount - initialCount})\n`);
  }

  const finalCount = await getToolCount();
  console.log('=== Complete ===');
  console.log(`Initial: ${initialCount}`);
  console.log(`Final: ${finalCount}`);
  console.log(`Added: ${finalCount - initialCount}`);
  console.log(finalCount - initialCount === 30 ? '✓ Success!' : `⚠ Expected 30, got ${finalCount - initialCount}`);
}

main().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
