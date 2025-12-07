import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

config({ path: join(__dirname, '..', '.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey, {
  auth: { persistSession: false }
});

async function getToolCount() {
  const { count } = await supabase
    .from('tools')
    .select('*', { count: 'exact', head: true });
  return count || 0;
}

async function executeBatch(batchNum) {
  const filePath = join(__dirname, '..', 'supabase', 'migrations', `20251207_batch${batchNum}_import_10_tools.sql`);
  const sql = readFileSync(filePath, 'utf-8');

  console.log(`\nExecuting batch ${batchNum}...`);

  const { data, error } = await supabase.rpc('exec', { sql }).catch(() => ({ data: null, error: 'RPC not available' }));

  if (error) {
    console.error(`Error: ${error}`);
    console.log('Trying alternative method...');

    const lines = sql.split('\n');
    const doBlockStart = lines.findIndex(l => l.trim() === 'DO $$');
    const doBlockEnd = lines.findIndex(l => l.trim() === 'END $$;');

    if (doBlockStart !== -1 && doBlockEnd !== -1) {
      const doBlock = lines.slice(doBlockStart, doBlockEnd + 1).join('\n');

      const response = await fetch(`${supabaseUrl}/rest/v1/rpc/query`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'apikey': supabaseKey,
          'Authorization': `Bearer ${supabaseKey}`,
          'Prefer': 'return=representation'
        },
        body: JSON.stringify({ query: doBlock })
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${await response.text()}`);
      }
    }
  }

  console.log(`✓ Batch ${batchNum} completed`);
}

async function main() {
  console.log('=== Applying Migrations ===\n');

  const initialCount = await getToolCount();
  console.log(`Initial tools: ${initialCount}`);

  for (let batch = 1; batch <= 3; batch++) {
    try {
      await executeBatch(batch);
      const currentCount = await getToolCount();
      console.log(`Tools after batch ${batch}: ${currentCount} (+${currentCount - initialCount})`);
    } catch (error) {
      console.error(`Failed at batch ${batch}:`, error.message);
      process.exit(1);
    }
  }

  const finalCount = await getToolCount();
  console.log(`\n=== Complete ===`);
  console.log(`Added: ${finalCount - initialCount} tools`);
  console.log(finalCount - initialCount === 30 ? '✓ Success!' : '⚠ Unexpected count');
}

main().catch(console.error);
