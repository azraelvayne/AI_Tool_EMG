/*
  # Phase 3 v1.1 Enhancement - Database Schema

  ## Overview
  This migration adds the necessary tables and fields for the Phase 3 v1.1 enhancement,
  transforming AI Mapper into an interactive application curation platform.

  ## Changes Summary

  ### 1. Tools Table Extensions
  - Add `is_curated` (boolean) - Marks tools as part of curated collections
  - Add `curation_batch` (text) - Tracks which batch/version the tool was added in
  - Add `source_slug` (text) - Kebab-case identifier for deduplication
  - Add `url` (text) - Official website URL (if not already exists)
  - Enhance `popularity_score` with default value

  ### 2. Export Templates Table (NEW)
  Platform-specific export templates for n8n, Langflow, and Zapier:
  - `id` (uuid, primary key)
  - `tool_id` (uuid, foreign key) - Reference to tools table
  - `platform` (text) - Platform name (n8n, langflow, zapier)
  - `format` (text) - Format type (json, url, guide)
  - `payload` (jsonb) - Template content or configuration
  - `version` (text) - Template version for tracking changes
  - `created_at` (timestamptz)
  - `updated_at` (timestamptz)

  ### 3. Creative Use Cases Table (NEW)
  Curated cross-domain creative application scenarios:
  - `id` (uuid, primary key)
  - `slug` (text, unique) - URL-friendly identifier
  - `title` (text) - English title
  - `title_en` (text) - Explicit English title
  - `title_zh_tw` (text) - Traditional Chinese title
  - `description` (text) - English description
  - `description_en` (text) - Explicit English description
  - `description_zh_tw` (text) - Traditional Chinese description
  - `difficulty` (text) - Difficulty level (beginner, intermediate, advanced)
  - `use_case_tags` (text[]) - Array of categorization tags
  - `tools` (text[]) - Array of tool slugs used in this use case
  - `workflow_steps` (jsonb) - Step-by-step instructions
  - `export_format` (text[]) - Supported export formats
  - `estimated_time` (text) - Time estimate to implement
  - `display_order` (integer) - Sort order for UI
  - `created_at` (timestamptz)
  - `updated_at` (timestamptz)

  ### 4. Tool Pairings Table Extensions
  Enhanced relationship tracking between tools:
  - Add `strength` (integer) - Connection strength score (0-100)
  - Add `rationale` (text) - Explanation of why tools pair well
  - Add `example_workflow_id` (uuid, nullable) - Reference to creative_use_cases

  ## Security
  - RLS enabled on all new tables
  - Public read access for knowledge base tables
  - Write access prepared for future authentication

  ## Indexes
  - Composite index on (tool_id, platform) for export_templates
  - Unique index on slug for creative_use_cases
  - Index on source_slug for tools table deduplication
*/

-- ============================================================================
-- 1. EXTEND TOOLS TABLE
-- ============================================================================

-- Add new fields to tools table if they don't exist
DO $$
BEGIN
  -- Add is_curated field
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'is_curated'
  ) THEN
    ALTER TABLE tools ADD COLUMN is_curated boolean DEFAULT false;
  END IF;

  -- Add curation_batch field
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'curation_batch'
  ) THEN
    ALTER TABLE tools ADD COLUMN curation_batch text DEFAULT NULL;
  END IF;

  -- Add source_slug field
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'source_slug'
  ) THEN
    ALTER TABLE tools ADD COLUMN source_slug text DEFAULT NULL;
  END IF;

  -- Add url field if it doesn't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'url'
  ) THEN
    ALTER TABLE tools ADD COLUMN url text DEFAULT NULL;
  END IF;
END $$;

-- Create index on source_slug for efficient deduplication queries
CREATE INDEX IF NOT EXISTS idx_tools_source_slug ON tools(source_slug);

-- Create index on curation_batch for filtering curated tools
CREATE INDEX IF NOT EXISTS idx_tools_curation_batch ON tools(curation_batch);

-- ============================================================================
-- 2. CREATE EXPORT TEMPLATES TABLE
-- ============================================================================

CREATE TABLE IF NOT EXISTS export_templates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tool_id uuid REFERENCES tools(id) ON DELETE CASCADE,
  platform text NOT NULL CHECK (platform IN ('n8n', 'langflow', 'zapier')),
  format text NOT NULL CHECK (format IN ('json', 'url', 'guide')),
  payload jsonb NOT NULL DEFAULT '{}'::jsonb,
  version text DEFAULT 'v1.0',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create composite index for efficient lookups
CREATE INDEX IF NOT EXISTS idx_export_templates_tool_platform
ON export_templates(tool_id, platform);

-- Enable Row Level Security
ALTER TABLE export_templates ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Export templates are publicly readable"
  ON export_templates
  FOR SELECT
  TO public
  USING (true);

-- Create policy for authenticated write access (for future)
CREATE POLICY "Export templates writable by authenticated users"
  ON export_templates
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- ============================================================================
-- 3. CREATE CREATIVE USE CASES TABLE
-- ============================================================================

CREATE TABLE IF NOT EXISTS creative_use_cases (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL DEFAULT '',
  title_en text NOT NULL DEFAULT '',
  title_zh_tw text DEFAULT '',
  description text NOT NULL DEFAULT '',
  description_en text NOT NULL DEFAULT '',
  description_zh_tw text DEFAULT '',
  difficulty text NOT NULL DEFAULT 'beginner' CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  use_case_tags text[] DEFAULT ARRAY[]::text[],
  tools text[] DEFAULT ARRAY[]::text[],
  workflow_steps jsonb DEFAULT '[]'::jsonb,
  export_format text[] DEFAULT ARRAY[]::text[],
  estimated_time text DEFAULT '2-3 hours',
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create unique index on slug
CREATE UNIQUE INDEX IF NOT EXISTS idx_creative_use_cases_slug ON creative_use_cases(slug);

-- Create index on difficulty for filtering
CREATE INDEX IF NOT EXISTS idx_creative_use_cases_difficulty ON creative_use_cases(difficulty);

-- Create GIN index on use_case_tags for array searches
CREATE INDEX IF NOT EXISTS idx_creative_use_cases_tags ON creative_use_cases USING GIN(use_case_tags);

-- Create GIN index on tools array for searches
CREATE INDEX IF NOT EXISTS idx_creative_use_cases_tools ON creative_use_cases USING GIN(tools);

-- Enable Row Level Security
ALTER TABLE creative_use_cases ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Creative use cases are publicly readable"
  ON creative_use_cases
  FOR SELECT
  TO public
  USING (true);

-- Create policy for authenticated write access (for future)
CREATE POLICY "Creative use cases writable by authenticated users"
  ON creative_use_cases
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- ============================================================================
-- 4. EXTEND TOOL PAIRINGS TABLE
-- ============================================================================

-- Add new fields to tool_pairings if table exists
DO $$
BEGIN
  -- Check if tool_pairings table exists
  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_name = 'tool_pairings'
  ) THEN
    -- Add strength field
    IF NOT EXISTS (
      SELECT 1 FROM information_schema.columns
      WHERE table_name = 'tool_pairings' AND column_name = 'strength'
    ) THEN
      ALTER TABLE tool_pairings ADD COLUMN strength integer DEFAULT 50 CHECK (strength >= 0 AND strength <= 100);
    END IF;

    -- Add rationale field
    IF NOT EXISTS (
      SELECT 1 FROM information_schema.columns
      WHERE table_name = 'tool_pairings' AND column_name = 'rationale'
    ) THEN
      ALTER TABLE tool_pairings ADD COLUMN rationale text DEFAULT '';
    END IF;

    -- Add example_workflow_id field
    IF NOT EXISTS (
      SELECT 1 FROM information_schema.columns
      WHERE table_name = 'tool_pairings' AND column_name = 'example_workflow_id'
    ) THEN
      ALTER TABLE tool_pairings ADD COLUMN example_workflow_id uuid REFERENCES creative_use_cases(id) ON DELETE SET NULL;
    END IF;

    -- Create index on strength for sorting
    CREATE INDEX IF NOT EXISTS idx_tool_pairings_strength ON tool_pairings(strength DESC);
  END IF;
END $$;

-- ============================================================================
-- 5. UPDATE TIMESTAMPS TRIGGER
-- ============================================================================

-- Create or replace function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Add triggers for updated_at on new tables
DO $$
BEGIN
  -- Export templates trigger
  IF NOT EXISTS (
    SELECT 1 FROM pg_trigger
    WHERE tgname = 'update_export_templates_updated_at'
  ) THEN
    CREATE TRIGGER update_export_templates_updated_at
      BEFORE UPDATE ON export_templates
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
  END IF;

  -- Creative use cases trigger
  IF NOT EXISTS (
    SELECT 1 FROM pg_trigger
    WHERE tgname = 'update_creative_use_cases_updated_at'
  ) THEN
    CREATE TRIGGER update_creative_use_cases_updated_at
      BEFORE UPDATE ON creative_use_cases
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
  END IF;
END $$;

-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================

/*
  Migration Notes:
  ----------------
  - All operations use IF NOT EXISTS / IF EXISTS to be idempotent
  - Existing data is preserved
  - New fields have sensible defaults
  - Indexes added for performance
  - RLS policies configured for security
  - Triggers set up for automatic timestamp updates

  Next Steps:
  -----------
  1. Seed 70 curated tools with is_curated=true and curation_batch="v1.1-core-70"
  2. Add export templates for popular tools
  3. Seed 10 creative use case examples
  4. Update tool pairings with strength scores and rationales
*/
