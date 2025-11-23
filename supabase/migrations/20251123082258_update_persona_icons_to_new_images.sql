/*
  # Update Persona Icons to New Illustration Images

  ## Overview
  This migration updates all persona character cards to use the new custom illustration images.
  All images have been organized into the /public/personas/ directory for better file management.

  ## Changes
  1. Image Organization
    - All persona images moved to /personas/ subdirectory
    - Fixed typo: creative-builde.png → creative-builder.png
    - Removed duplicate image files from public root directory

  2. Persona Icon Updates
    - Creative Builder → /personas/creative-builder.png
    - Data Analyst → /personas/data-analyst-zh.jpg
    - AI Tool Designer → /personas/ai-tool-designer-full.png
    - Knowledge Manager → /personas/knowledge-manager-zh.jpg
    - Business Developer → /personas/business-developer-zh.png
    - Workflow Architect → /personas/workflow-architect.jpg

  3. File Mapping Details
    - creative_builder: Purple-themed illustration with design tools
    - data_analyst: Blue-themed illustration with data analytics
    - ai_tool_designer: Blue-themed illustration with automation gears
    - knowledge_manager: Green-themed illustration with knowledge organization
    - business_developer: Purple-themed illustration with business strategy
    - workflow_architect: Blue-themed illustration with workflow automation

  ## Security
  - No changes to RLS policies needed
  - Public read access maintained
  - Images served from public directory

  ## Notes
  - All 6 personas now have custom illustration images
  - Fallback emoji icons remain in icon column for compatibility
  - Images optimized for persona card display (128x128px recommended)
*/

-- Update all persona icon URLs to point to the new /personas/ directory
UPDATE personas SET icon_url = '/personas/creative-builder.png'
WHERE persona_key = 'creative_builder';

UPDATE personas SET icon_url = '/personas/data-analyst-zh.jpg'
WHERE persona_key = 'data_analyst';

UPDATE personas SET icon_url = '/personas/ai-tool-designer-full.png'
WHERE persona_key = 'ai_tool_designer';

UPDATE personas SET icon_url = '/personas/knowledge-manager-zh.jpg'
WHERE persona_key = 'knowledge_manager';

UPDATE personas SET icon_url = '/personas/business-developer-zh.png'
WHERE persona_key = 'business_developer';

UPDATE personas SET icon_url = '/personas/workflow-architect.jpg'
WHERE persona_key = 'workflow_architect';
