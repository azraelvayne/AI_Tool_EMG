import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.join(__dirname, '..', '.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY!;

const supabase = createClient(supabaseUrl, supabaseKey);

interface ValidationResult {
  toolName: string;
  missingFields: string[];
  warnings: string[];
}

interface Tool {
  id: string;
  tool_name: string;
  summary: string;
  categories: any;
  description_styles: any;
  use_case_templates: any[];
  icon_url?: string;
  is_verified: boolean;
}

async function validateTools() {
  console.log('🔍 Starting tool data validation...\n');

  const { data: tools, error } = await supabase
    .from('tools')
    .select('*')
    .order('tool_name');

  if (error) {
    console.error('❌ Error fetching tools:', error);
    return;
  }

  if (!tools || tools.length === 0) {
    console.log('⚠️  No tools found in database');
    return;
  }

  console.log(`📊 Validating ${tools.length} tools...\n`);

  const results: ValidationResult[] = [];
  let totalIssues = 0;

  for (const tool of tools as Tool[]) {
    const missingFields: string[] = [];
    const warnings: string[] = [];

    if (!tool.summary || tool.summary.trim() === '') {
      missingFields.push('summary');
    }

    if (!tool.icon_url || tool.icon_url.trim() === '') {
      missingFields.push('icon_url');
    }

    if (!tool.categories || Object.keys(tool.categories).length === 0) {
      missingFields.push('categories');
    } else {
      const cats = tool.categories;
      if (!cats.purpose || cats.purpose.length === 0) {
        warnings.push('categories.purpose is empty');
      }
      if (!cats.functional_role || cats.functional_role.length === 0) {
        warnings.push('categories.functional_role is empty');
      }
      if (!cats.difficulty) {
        warnings.push('categories.difficulty is missing');
      }
    }

    if (!tool.description_styles || Object.keys(tool.description_styles).length === 0) {
      missingFields.push('description_styles');
    } else {
      const styles = tool.description_styles;
      if (!styles.encyclopedia || styles.encyclopedia.trim() === '') {
        warnings.push('description_styles.encyclopedia is empty');
      }
      if (!styles.guide || styles.guide.trim() === '') {
        warnings.push('description_styles.guide is empty');
      }
      if (!styles.strategy || styles.strategy.trim() === '') {
        warnings.push('description_styles.strategy is empty');
      }
    }

    if (!tool.use_case_templates || tool.use_case_templates.length === 0) {
      warnings.push('use_case_templates is empty');
    }

    if (missingFields.length > 0 || warnings.length > 0) {
      results.push({
        toolName: tool.tool_name,
        missingFields,
        warnings
      });
      totalIssues += missingFields.length + warnings.length;
    }
  }

  console.log('═══════════════════════════════════════════════════════\n');
  console.log('📋 VALIDATION REPORT\n');
  console.log('═══════════════════════════════════════════════════════\n');

  if (results.length === 0) {
    console.log('✅ All tools have complete data!\n');
  } else {
    console.log(`⚠️  Found ${results.length} tools with issues (${totalIssues} total issues)\n`);

    for (const result of results) {
      console.log(`\n🔧 ${result.toolName}`);
      console.log('─────────────────────────────────────────────────────');

      if (result.missingFields.length > 0) {
        console.log('  ❌ Missing critical fields:');
        result.missingFields.forEach(field => {
          console.log(`     • ${field}`);
        });
      }

      if (result.warnings.length > 0) {
        console.log('  ⚠️  Warnings:');
        result.warnings.forEach(warning => {
          console.log(`     • ${warning}`);
        });
      }
    }
  }

  console.log('\n═══════════════════════════════════════════════════════');
  console.log('\n📊 SUMMARY');
  console.log('───────────────────────────────────────────────────────');
  console.log(`Total tools: ${tools.length}`);
  console.log(`Complete tools: ${tools.length - results.length}`);
  console.log(`Tools with issues: ${results.length}`);
  console.log(`Total issues: ${totalIssues}`);

  const missingIcons = results.filter(r => r.missingFields.includes('icon_url')).length;
  const missingDescriptions = results.filter(r => r.missingFields.includes('description_styles')).length;
  const missingUseCases = results.filter(r => r.warnings.some(w => w.includes('use_case_templates'))).length;

  console.log('\n📈 Priority Areas:');
  console.log(`   • Tools without icons: ${missingIcons}`);
  console.log(`   • Tools without description styles: ${missingDescriptions}`);
  console.log(`   • Tools without use case templates: ${missingUseCases}`);

  console.log('\n═══════════════════════════════════════════════════════\n');

  const exportTemplatesCheck = await checkExportTemplates();
  const toolPairingsCheck = await checkToolPairings();

  return {
    toolValidation: results,
    exportTemplates: exportTemplatesCheck,
    toolPairings: toolPairingsCheck
  };
}

async function checkExportTemplates() {
  console.log('🔍 Checking export templates coverage...\n');

  const { data: templates, error } = await supabase
    .from('export_templates')
    .select('tool_id');

  if (error) {
    console.error('❌ Error fetching export templates:', error);
    return null;
  }

  const { data: tools, error: toolsError } = await supabase
    .from('tools')
    .select('id, tool_name')
    .order('popularity_score', { ascending: false })
    .limit(20);

  if (toolsError) {
    console.error('❌ Error fetching tools:', toolsError);
    return null;
  }

  const toolsWithTemplates = new Set(templates?.map(t => t.tool_id) || []);
  const topToolsWithoutTemplates = tools?.filter(t => !toolsWithTemplates.has(t.id)) || [];

  console.log(`📊 Export Templates Coverage:`);
  console.log(`   • Total templates: ${templates?.length || 0}`);
  console.log(`   • Top 20 tools without templates: ${topToolsWithoutTemplates.length}`);

  if (topToolsWithoutTemplates.length > 0) {
    console.log('\n   Priority tools needing templates:');
    topToolsWithoutTemplates.slice(0, 10).forEach((tool, i) => {
      console.log(`      ${i + 1}. ${tool.tool_name}`);
    });
  }

  console.log('');
  return { templates: templates?.length || 0, missingTop20: topToolsWithoutTemplates.length };
}

async function checkToolPairings() {
  console.log('🔍 Checking tool pairings...\n');

  const { data: pairings, error } = await supabase
    .from('tool_pairings')
    .select('*');

  if (error) {
    console.error('❌ Error fetching tool pairings:', error);
    return null;
  }

  console.log(`📊 Tool Pairings:`);
  console.log(`   • Total pairings: ${pairings?.length || 0}`);

  const byType = pairings?.reduce((acc: any, p: any) => {
    acc[p.relationship_type] = (acc[p.relationship_type] || 0) + 1;
    return acc;
  }, {});

  if (byType) {
    console.log('\n   By relationship type:');
    Object.entries(byType).forEach(([type, count]) => {
      console.log(`      • ${type}: ${count}`);
    });
  }

  console.log('');
  return { total: pairings?.length || 0, byType };
}

validateTools().then(() => {
  console.log('✅ Validation complete!\n');
  process.exit(0);
}).catch((error) => {
  console.error('❌ Validation failed:', error);
  process.exit(1);
});
