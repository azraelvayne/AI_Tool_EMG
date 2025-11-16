/*
  # Add Persona Images and 6th Persona

  ## Overview
  This migration adds visual identity support for the persona system:
  - Adds icon_url column to store custom illustration paths
  - Creates the 6th persona: Workflow Architect (自動化工程師)
  - Updates existing 5 personas with their illustration file paths
  - Maintains emoji icons as fallback values

  ## Changes
  1. Schema Enhancement
    - Add icon_url column to personas table
    - Column is nullable to maintain backward compatibility

  2. New Persona
    - Workflow Architect persona with cyan-blue theme
    - Intermediate skill level
    - Focus on automation and system integration

  3. Image Path Updates
    - AI Tool Designer → Artificial Intelligence Tool Designer.png
    - Creative Builder → creative-builder.png
    - Data Analyst → data-analyst.png
    - Knowledge Manager → knowledge-curator.jpg
    - Business Developer → business-developer.png
    - Workflow Architect → workflow-architect.png (placeholder)

  ## Security
  - No changes to RLS policies needed
  - Public read access maintained
*/

-- Add icon_url column to personas table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'personas' AND column_name = 'icon_url'
  ) THEN
    ALTER TABLE personas ADD COLUMN icon_url TEXT;
  END IF;
END $$;

-- Update existing personas with image paths
UPDATE personas SET icon_url = '/personas/Artificial Intelligence Tool Designer.png' WHERE persona_key = 'ai_tool_designer';
UPDATE personas SET icon_url = '/personas/creative-builder.png' WHERE persona_key = 'creative_builder';
UPDATE personas SET icon_url = '/personas/data-analyst.png' WHERE persona_key = 'data_analyst';
UPDATE personas SET icon_url = '/personas/knowledge-curator.jpg' WHERE persona_key = 'knowledge_manager';
UPDATE personas SET icon_url = '/personas/business-developer.png' WHERE persona_key = 'business_developer';

-- Insert 6th persona: Workflow Architect
INSERT INTO personas (
  persona_key,
  name_en,
  name_zh_tw,
  description_en,
  description_zh_tw,
  skill_level,
  learning_focus,
  icon,
  icon_url,
  display_order
)
VALUES (
  'workflow_architect',
  'Workflow Architect',
  '自動化工程師',
  'System integrators who design and build automated workflows connecting multiple tools and services.',
  '系統整合者，設計與建構連接多個工具與服務的自動化工作流程。',
  'intermediate',
  '["Process Automation", "Tool Integration", "Workflow Design"]'::jsonb,
  '⚙️',
  '/personas/workflow-architect.png',
  6
)
ON CONFLICT (persona_key) DO NOTHING;
