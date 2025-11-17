/*
  # Update Workflow Architect Persona Image

  ## Overview
  This migration updates the Workflow Architect persona's icon_url
  to use the deployment-safe filename.

  ## Changes
  1. Updates persona image path to use deployment-safe filename
  2. Maps to the correct file: workflow-architect.jpg

  ## File Mapping
  - Workflow Architect → workflow-architect.jpg

  ## Security
  - No changes to RLS policies
  - Public read access maintained
*/

-- Update Workflow Architect persona image to use deployment-safe filename
UPDATE personas
SET icon_url = '/personas/workflow-architect.jpg'
WHERE persona_key = 'workflow_architect';
