/*
  # Update Workflow Architect Persona Image

  ## Overview
  This migration updates the Workflow Architect (自動化工程師) persona's icon_url
  to use the newly uploaded custom illustration.

  ## Changes
  1. Updates persona image path from placeholder to the actual uploaded image
  2. Maps to the correct file: Phoenix_10_flat_vector_illustration_of_a_workflow_architect_co_3.jpg

  ## File Mapping
  - Workflow Architect (自動化工程師) → Phoenix_10_flat_vector_illustration_of_a_workflow_architect_co_3.jpg

  ## Security
  - No changes to RLS policies
  - Public read access maintained
*/

-- Update Workflow Architect persona image to use the newly uploaded illustration
UPDATE personas
SET icon_url = '/personas/Phoenix_10_flat_vector_illustration_of_a_workflow_architect_co_3.jpg'
WHERE persona_key = 'workflow_architect';
