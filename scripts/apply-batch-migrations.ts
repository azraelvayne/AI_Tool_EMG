import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

function main() {
  console.log('=== Batch Migration SQL Files ===\n');
  console.log('The following migration files have been generated:');
  console.log('');

  for (let batch = 1; batch <= 3; batch++) {
    const migrationPath = join(
      __dirname,
      '..',
      'supabase',
      'migrations',
      `20251207_batch${batch}_import_10_tools.sql`
    );

    try {
      const sql = readFileSync(migrationPath, 'utf-8');
      console.log(`Batch ${batch}: 20251207_batch${batch}_import_10_tools.sql`);
      console.log(`  Size: ${(sql.length / 1024).toFixed(2)} KB`);
      console.log(`  Lines: ${sql.split('\n').length}`);
    } catch (error) {
      console.error(`Error reading batch ${batch}:`, error);
    }
  }

  console.log('\nTo apply these migrations:');
  console.log('1. Use the Supabase MCP tool: mcp__supabase__apply_migration');
  console.log('2. Or manually execute each SQL file in Supabase Studio');
  console.log('3. Apply them in order: batch1 -> batch2 -> batch3');
}

main();
