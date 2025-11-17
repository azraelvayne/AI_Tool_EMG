/*
  # Update Persona Image Paths to Match Actual Files

  ## Overview
  This migration corrects the persona icon_url paths to match the actual
  image files that exist in the /public/personas/ directory.

  ## Changes
  1. Updates persona image paths to use the correct filenames
  2. Maps Chinese-named files to corresponding personas
  3. Assigns appropriate images to all 6 personas including Workflow Architect

  ## File Mapping
  - Creative Builder (創意開發者) → 創意開發者.jpg
  - Data Analyst (資料分析師) → 資料分析師.jpg
  - AI Tool Designer → Artificial Intelligence Tool Designer.png (already correct)
  - Knowledge Manager (知識管理者) → 知識管理者.jpg
  - Business Developer (商業開發者) → 商業開發者.png
  - Workflow Architect (自動化工程師) → image-EoRWq18DY6Hg0kQsdqghu.png

  ## Security
  - No changes to RLS policies
  - Public read access maintained
*/

-- Update persona image paths to match actual files
UPDATE personas SET icon_url = '/personas/創意開發者.jpg' WHERE persona_key = 'creative_builder';
UPDATE personas SET icon_url = '/personas/資料分析師.jpg' WHERE persona_key = 'data_analyst';
UPDATE personas SET icon_url = '/personas/知識管理者.jpg' WHERE persona_key = 'knowledge_manager';
UPDATE personas SET icon_url = '/personas/商業開發者.png' WHERE persona_key = 'business_developer';
UPDATE personas SET icon_url = '/personas/image-EoRWq18DY6Hg0kQsdqghu.png' WHERE persona_key = 'workflow_architect';
