/*
  # Complete tool_pairings table schema

  1. Changes
    - Add `rationale` (text) - Explanation of why tools pair well
    - Add `example_workflow_id` (uuid) - Reference to creative_use_cases table
    
  2. Security
    - Maintains existing RLS policies
*/

-- Add rationale column if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tool_pairings' AND column_name = 'rationale'
  ) THEN
    ALTER TABLE tool_pairings ADD COLUMN rationale text DEFAULT '';
  END IF;
END $$;

-- Add example_workflow_id column if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tool_pairings' AND column_name = 'example_workflow_id'
  ) THEN
    ALTER TABLE tool_pairings ADD COLUMN example_workflow_id uuid REFERENCES creative_use_cases(id) ON DELETE SET NULL;
  END IF;
END $$;

-- Create index on example_workflow_id for efficient lookups
CREATE INDEX IF NOT EXISTS idx_tool_pairings_example_workflow 
ON tool_pairings(example_workflow_id);
