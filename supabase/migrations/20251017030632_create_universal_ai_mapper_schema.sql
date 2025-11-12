/*
  # Universal AI Mapper Core - Database Schema

  ## Overview
  This migration creates the complete database schema for the Universal AI Mapper Core,
  a cross-platform tool ecosystem mapping and generation system.

  ## Tables Created

  ### 1. tools
  Main table storing all tool information with complete JSON structure:
  - `id` (uuid, primary key) - Unique identifier
  - `tool_name` (text, unique) - Tool name (e.g., "Notion", "Supabase")
  - `summary` (text) - Brief one-line description
  - `categories` (jsonb) - Six-dimensional classification (purpose, functional_role, application_field, tech_layer, data_flow_role, difficulty, common_pairings)
  - `description_styles` (jsonb) - Four description formats (encyclopedia, guide, strategy, inspiration)
  - `use_case_templates` (jsonb) - Array of use case examples with steps
  - `display_priority` (integer) - UI sorting priority (higher = more prominent)
  - `popularity_score` (integer) - Calculated from user interactions
  - `icon_url` (text) - Logo or icon URL
  - `is_verified` (boolean) - Manually curated vs AI-generated
  - `generation_source` (text) - Source of generation (openai, claude, manual)
  - `created_at` (timestamptz) - Creation timestamp
  - `updated_at` (timestamptz) - Last update timestamp

  ### 2. category_metadata
  Visual metadata for category display:
  - `id` (uuid, primary key)
  - `category_type` (text) - Type of category (purpose, functional_role, tech_layer, etc.)
  - `category_value` (text) - Specific value (e.g., "No-code", "Database")
  - `color_hex` (text) - Display color for badges
  - `icon_name` (text) - Lucide icon name
  - `description` (text) - Explanation of category
  - `display_order` (integer) - Sort order in UI

  ### 3. tool_pairings
  Relationships between tools with connection strength:
  - `id` (uuid, primary key)
  - `tool_id_1` (uuid, foreign key) - First tool
  - `tool_id_2` (uuid, foreign key) - Second tool
  - `relationship_type` (text) - Type of pairing (integrates_with, alternative_to, complements)
  - `strength` (integer) - Connection strength (1-10)
  - `description` (text) - How they work together
  - `created_at` (timestamptz)

  ### 4. featured_stacks
  Curated technology stacks for showcase:
  - `id` (uuid, primary key)
  - `stack_name` (text) - Name of stack
  - `description` (text) - What it's for
  - `tool_ids` (jsonb) - Array of tool IDs in stack
  - `use_case` (text) - Primary use case
  - `difficulty_level` (text) - Overall difficulty
  - `created_at` (timestamptz)

  ### 5. user_interactions
  Anonymous interaction tracking for popularity:
  - `id` (uuid, primary key)
  - `tool_id` (uuid, foreign key)
  - `interaction_type` (text) - Type (view, favorite, generate)
  - `session_id` (text) - Anonymous session identifier
  - `created_at` (timestamptz)

  ## Security
  - RLS enabled on all tables
  - Public read access for all tables (public knowledge base)
  - Write access prepared for future authentication

  ## Indexes
  - Full-text search on tool names and descriptions
  - Performance indexes on commonly queried fields
*/

-- Create tools table
CREATE TABLE IF NOT EXISTS tools (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tool_name text UNIQUE NOT NULL,
  summary text NOT NULL DEFAULT '',
  categories jsonb NOT NULL DEFAULT '{}'::jsonb,
  description_styles jsonb NOT NULL DEFAULT '{}'::jsonb,
  use_case_templates jsonb NOT NULL DEFAULT '[]'::jsonb,
  display_priority integer DEFAULT 0,
  popularity_score integer DEFAULT 0,
  icon_url text DEFAULT '',
  is_verified boolean DEFAULT false,
  generation_source text DEFAULT 'manual',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create category_metadata table
CREATE TABLE IF NOT EXISTS category_metadata (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  category_type text NOT NULL,
  category_value text NOT NULL,
  color_hex text NOT NULL DEFAULT '#3B82F6',
  icon_name text DEFAULT '',
  description text DEFAULT '',
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(category_type, category_value)
);

-- Create tool_pairings table
CREATE TABLE IF NOT EXISTS tool_pairings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tool_id_1 uuid NOT NULL REFERENCES tools(id) ON DELETE CASCADE,
  tool_id_2 uuid NOT NULL REFERENCES tools(id) ON DELETE CASCADE,
  relationship_type text DEFAULT 'integrates_with',
  strength integer DEFAULT 5 CHECK (strength >= 1 AND strength <= 10),
  description text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  UNIQUE(tool_id_1, tool_id_2)
);

-- Create featured_stacks table
CREATE TABLE IF NOT EXISTS featured_stacks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  stack_name text NOT NULL,
  description text NOT NULL DEFAULT '',
  tool_ids jsonb NOT NULL DEFAULT '[]'::jsonb,
  use_case text DEFAULT '',
  difficulty_level text DEFAULT 'intermediate',
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create user_interactions table
CREATE TABLE IF NOT EXISTS user_interactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tool_id uuid REFERENCES tools(id) ON DELETE CASCADE,
  interaction_type text NOT NULL,
  session_id text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_tools_name ON tools USING gin(to_tsvector('english', tool_name));
CREATE INDEX IF NOT EXISTS idx_tools_summary ON tools USING gin(to_tsvector('english', summary));
CREATE INDEX IF NOT EXISTS idx_tools_popularity ON tools(popularity_score DESC);
CREATE INDEX IF NOT EXISTS idx_tools_priority ON tools(display_priority DESC);
CREATE INDEX IF NOT EXISTS idx_category_type ON category_metadata(category_type);
CREATE INDEX IF NOT EXISTS idx_tool_pairings_tool1 ON tool_pairings(tool_id_1);
CREATE INDEX IF NOT EXISTS idx_tool_pairings_tool2 ON tool_pairings(tool_id_2);
CREATE INDEX IF NOT EXISTS idx_interactions_tool ON user_interactions(tool_id);

-- Enable Row Level Security
ALTER TABLE tools ENABLE ROW LEVEL SECURITY;
ALTER TABLE category_metadata ENABLE ROW LEVEL SECURITY;
ALTER TABLE tool_pairings ENABLE ROW LEVEL SECURITY;
ALTER TABLE featured_stacks ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_interactions ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Public read access for tools"
  ON tools FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for categories"
  ON category_metadata FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for pairings"
  ON tool_pairings FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for featured stacks"
  ON featured_stacks FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for interactions"
  ON user_interactions FOR SELECT
  TO public
  USING (true);

-- Create policies for public write access (anonymous contributions)
CREATE POLICY "Public insert for user interactions"
  ON user_interactions FOR INSERT
  TO public
  WITH CHECK (true);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for tools table
CREATE TRIGGER update_tools_updated_at
  BEFORE UPDATE ON tools
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();