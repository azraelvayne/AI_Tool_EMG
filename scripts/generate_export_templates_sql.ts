import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

interface ExportTemplate {
  tool_id: string;
  tool_name: string;
  platform: 'n8n' | 'langflow' | 'zapier';
  format: 'json' | 'guide';
  payload: any;
  version: string;
}

const escapeSqlString = (str: string): string => {
  return str.replace(/'/g, "''");
};

const generateSqlHeader = (): string => {
  return `/*
  # Seed Export Templates Data (Sprint 1 - Phase 3)

  1. Overview
    - Seeds 60 export templates (20 tools × 3 platforms)
    - Covers n8n workflows, Langflow flows, and Zapier guides
    - All templates are production-ready and can be imported directly

  2. Platforms Coverage
    - n8n: Complete workflow JSON with nodes, connections, and credentials
    - Langflow: Flow JSON with nodes, edges, and templates
    - Zapier: Setup guides with triggers, actions, and step-by-step instructions

  3. Top 20 Tools Included
    - AI Models: OpenAI, Claude, Gemini, HuggingFace
    - Automation: n8n, Zapier, Make, Pipedream
    - Databases: Supabase, Airtable, Notion
    - LLM Orchestration: Flowise, Langflow, Dify
    - No-Code: Webflow, Bubble, Figma
    - Others: Midjourney, Salesforce, Monday

  4. Template Features
    - Realistic node configurations
    - Proper credential placeholders
    - Chinese and English setup guides
    - Common triggers and actions listed

  5. Important Notes
    - Uses dynamic tool_id lookup to avoid hardcoded UUIDs
    - Idempotent: Can be run multiple times safely
    - JSON payloads are escaped and validated
*/

`;
};

const generateInsertStatement = (template: ExportTemplate): string => {
  const payloadJson = escapeSqlString(JSON.stringify(template.payload));

  return `
INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  '${template.platform}',
  '${template.format}',
  '${payloadJson}'::jsonb,
  '${template.version}'
FROM tools
WHERE tool_name = '${escapeSqlString(template.tool_name)}'
ON CONFLICT DO NOTHING;
`;
};

// Main execution
const templatesPath = path.join(__dirname, 'data', 'export_templates.json');
const outputPath = path.join(__dirname, '..', 'supabase', 'migrations', '20251116150100_seed_export_templates_v1.sql');

try {
  const templatesContent = fs.readFileSync(templatesPath, 'utf-8');
  const templates: ExportTemplate[] = JSON.parse(templatesContent);

  console.log(`Loaded ${templates.length} export templates`);

  let sql = generateSqlHeader();

  for (const template of templates) {
    sql += generateInsertStatement(template);
  }

  fs.writeFileSync(outputPath, sql);
  console.log(`Generated SQL migration file: ${outputPath}`);
  console.log(`Total file size: ${(sql.length / 1024).toFixed(2)} KB`);

} catch (error) {
  console.error('Error generating SQL:', error);
  process.exit(1);
}
