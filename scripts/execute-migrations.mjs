import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables
config({ path: join(__dirname, '..', '.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Error: Missing Supabase credentials');
  console.error('VITE_SUPABASE_URL:', !!supabaseUrl);
  console.error('SUPABASE_SERVICE_ROLE_KEY:', !!supabaseServiceKey);
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function getToolCount() {
  const { count, error } = await supabase
    .from('tools')
    .select('*', { count: 'exact', head: true });

  if (error) {
    console.error('Error counting tools:', error);
    return -1;
  }

  return count || 0;
}

async function executeSQLFile(batch) {
  const filePath = join(__dirname, '..', 'supabase', 'migrations', `20251207_batch${batch}_import_10_tools.sql`);

  console.log(`\nReading batch ${batch} migration file...`);
  const sql = readFileSync(filePath, 'utf-8');

  console.log(`Executing batch ${batch}...`);

  // Split by DO $$ blocks and execute
  const { data, error } = await supabase.rpc('query', { query_text: sql }).catch(async (e) => {
    // If RPC doesn't exist, try direct execution through a custom function
    // For now, we'll use a workaround - execute via raw SQL
    const response = await fetch(`${supabaseUrl}/rest/v1/rpc/exec`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': supabaseServiceKey,
        'Authorization': `Bearer ${supabaseServiceKey}`
      },
      body: JSON.stringify({ sql })
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return response.json();
  });

  if (error) {
    console.error(`Error executing batch ${batch}:`, error);
    return false;
  }

  console.log(`✓ Batch ${batch} executed successfully`);
  return true;
}

async function main() {
  console.log('=== Applying Batch Migrations ===\n');

  const initialCount = await getToolCount();
  console.log(`Initial tool count: ${initialCount}`);

  for (let batch = 1; batch <= 3; batch++) {
    const success = await executeSQLFile(batch);

    if (!success) {
      console.error(`\nFailed at batch ${batch}`);
      process.exit(1);
    }

    const currentCount = await getToolCount();
    const added = currentCount - initialCount;
    console.log(`Current tool count: ${currentCount} (+${added} tools)`);
  }

  const finalCount = await getToolCount();
  const totalAdded = finalCount - initialCount;

  console.log(`\n=== Migration Complete ===`);
  console.log(`Initial: ${initialCount} tools`);
  console.log(`Final: ${finalCount} tools`);
  console.log(`Added: ${totalAdded} tools`);
  console.log(`Expected: 30 tools`);
  console.log(totalAdded === 30 ? '✓ Success!' : '⚠ Warning: Count mismatch');
}

main().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
