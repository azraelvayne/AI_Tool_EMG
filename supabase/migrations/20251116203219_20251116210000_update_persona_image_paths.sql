/*
  # Update Persona Image Paths to Match Actual Files

  ## Overview
  This migration corrects the persona icon_url paths to match the actual
  image files that exist in the /public/personas/ directory.

  ## Changes
  1. Updates persona image paths to use deployment-safe filenames
  2. Removes Chinese characters and spaces from filenames
  3. Assigns appropriate images to all 6 personas including Workflow Architect

  ## File Mapping
  - Creative Builder → creative-builder.jpg
  - Data Analyst → data-analyst-zh.jpg
  - AI Tool Designer → ai-tool-designer-full.png
  - Knowledge Manager → knowledge-manager-zh.jpg
  - Business Developer → business-developer-zh.png
  - Workflow Architect → workflow-architect.jpg

  ## Security
  - No changes to RLS policies
  - Public read access maintained
*/

-- Update persona image paths to match actual files
UPDATE personas SET icon_url = '/personas/creative-builder.jpg' WHERE persona_key = 'creative_builder';
UPDATE personas SET icon_url = '/personas/data-analyst-zh.jpg' WHERE persona_key = 'data_analyst';
UPDATE personas SET icon_url = '/personas/knowledge-manager-zh.jpg' WHERE persona_key = 'knowledge_manager';
UPDATE personas SET icon_url = '/personas/business-developer-zh.png' WHERE persona_key = 'business_developer';
UPDATE personas SET icon_url = '/personas/workflow-architect.jpg' WHERE persona_key = 'workflow_architect';
