/*
  # Persona-Driven Learning Platform Schema

  ## Overview
  This migration transforms the tool directory into a persona-driven learning exploration platform.
  The core model is: Persona → Goal → ToolStack → Inspiration

  ## New Tables Created

  ### 1. personas
  AI Learning Personas representing different user identities:
  - `id` (uuid, primary key) - Unique identifier
  - `persona_key` (text, unique) - Identifier key (e.g., "creative_builder")
  - `name_en` (text) - English name
  - `name_zh_tw` (text) - Traditional Chinese name
  - `description_en` (text) - English description
  - `description_zh_tw` (text) - Traditional Chinese description
  - `skill_level` (text) - Suggested skill level (beginner, intermediate, advanced)
  - `learning_focus` (jsonb) - Array of learning focus areas
  - `recommended_goals` (jsonb) - Array of recommended goal IDs
  - `icon` (text) - Icon identifier (emoji or icon name)
  - `display_order` (integer) - Sort order for UI display
  - `created_at` (timestamptz) - Creation timestamp

  ### 2. goals
  Learning goals or tasks that personas want to accomplish:
  - `id` (uuid, primary key) - Unique identifier
  - `goal_key` (text, unique) - Identifier key (e.g., "auto_content_publish")
  - `title_en` (text) - English title
  - `title_zh_tw` (text) - Traditional Chinese title
  - `description_en` (text) - English description
  - `description_zh_tw` (text) - Traditional Chinese description
  - `difficulty` (text) - Difficulty level (beginner, intermediate, advanced)
  - `learning_focus` (jsonb) - Array of what users will learn
  - `expected_skills` (jsonb) - Array of skills users will gain
  - `outcome_en` (text) - Expected outcome in English
  - `outcome_zh_tw` (text) - Expected outcome in Traditional Chinese
  - `display_order` (integer) - Sort order
  - `created_at` (timestamptz) - Creation timestamp

  ### 3. tool_stacks
  Combinations of tools that work together to achieve goals:
  - `id` (uuid, primary key) - Unique identifier
  - `stack_key` (text, unique) - Identifier key
  - `name_en` (text) - English name
  - `name_zh_tw` (text) - Traditional Chinese name
  - `description_en` (text) - English description
  - `description_zh_tw` (text) - Traditional Chinese description
  - `tool_ids` (jsonb) - Array of tool UUIDs in this stack
  - `flow_map` (text) - Simple text flow (e.g., "Gmail → n8n → Notion")
  - `diagram_url` (text) - URL to flow diagram
  - `difficulty` (text) - Overall difficulty level
  - `integration_method` (text) - How tools integrate (API, webhook, native, etc.)
  - `setup_complexity` (text) - Setup difficulty (low, medium, high)
  - `estimated_time` (text) - Time to set up (e.g., "1-2 hours")
  - `created_at` (timestamptz) - Creation timestamp

  ### 4. inspirations
  Real-world application examples showing what can be built:
  - `id` (uuid, primary key) - Unique identifier
  - `inspiration_key` (text, unique) - Identifier key
  - `title_en` (text) - English title
  - `title_zh_tw` (text) - Traditional Chinese title
  - `description_en` (text) - English description
  - `description_zh_tw` (text) - Traditional Chinese description
  - `steps` (jsonb) - Array of step descriptions
  - `stack_id` (uuid) - Reference to tool_stacks
  - `difficulty` (text) - Difficulty level
  - `estimated_time` (text) - Time to complete
  - `learning_focus` (jsonb) - What users will learn
  - `expected_skills` (jsonb) - Skills users will gain
  - `resource_links` (jsonb) - Array of tutorial/documentation links
  - `outcome_demo` (text) - URL to demo or example
  - `visual_hint` (text) - UI display suggestion
  - `display_order` (integer) - Sort order
  - `created_at` (timestamptz) - Creation timestamp

  ### 5. Junction Tables
  Many-to-many relationship tables:
  - `persona_goals` - Links personas to their relevant goals
  - `goal_stacks` - Links goals to tool stacks (multiple paths per goal)
  - `goal_inspirations` - Links goals to inspiration examples

  ## Enhanced Tools Table
  The existing tools table is retained and enhanced with new fields:
  - `url` (text) - Official website URL
  - `free_tier_info` (jsonb) - Information about free tier capabilities
  - `tags` (text[]) - Flexible tagging system

  ## Security
  - RLS enabled on all new tables
  - Public read access for all tables (knowledge base)
  - Write access prepared for future authentication

  ## Indexes
  - Performance indexes on commonly queried fields
  - Full-text search on titles and descriptions
*/

-- Add new fields to existing tools table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'url'
  ) THEN
    ALTER TABLE tools ADD COLUMN url text DEFAULT '';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'free_tier_info'
  ) THEN
    ALTER TABLE tools ADD COLUMN free_tier_info jsonb DEFAULT '{}'::jsonb;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'tags'
  ) THEN
    ALTER TABLE tools ADD COLUMN tags text[] DEFAULT '{}'::text[];
  END IF;
END $$;

-- Create personas table
CREATE TABLE IF NOT EXISTS personas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  persona_key text UNIQUE NOT NULL,
  name_en text NOT NULL,
  name_zh_tw text NOT NULL,
  description_en text NOT NULL,
  description_zh_tw text NOT NULL,
  skill_level text NOT NULL CHECK (skill_level IN ('beginner', 'intermediate', 'advanced')),
  learning_focus jsonb NOT NULL DEFAULT '[]'::jsonb,
  recommended_goals jsonb NOT NULL DEFAULT '[]'::jsonb,
  icon text NOT NULL DEFAULT '',
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create goals table
CREATE TABLE IF NOT EXISTS goals (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  goal_key text UNIQUE NOT NULL,
  title_en text NOT NULL,
  title_zh_tw text NOT NULL,
  description_en text NOT NULL,
  description_zh_tw text NOT NULL,
  difficulty text NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  learning_focus jsonb NOT NULL DEFAULT '[]'::jsonb,
  expected_skills jsonb NOT NULL DEFAULT '[]'::jsonb,
  outcome_en text NOT NULL DEFAULT '',
  outcome_zh_tw text NOT NULL DEFAULT '',
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create tool_stacks table (separate from featured_stacks for clarity)
CREATE TABLE IF NOT EXISTS tool_stacks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  stack_key text UNIQUE NOT NULL,
  name_en text NOT NULL,
  name_zh_tw text NOT NULL,
  description_en text NOT NULL,
  description_zh_tw text NOT NULL,
  tool_ids jsonb NOT NULL DEFAULT '[]'::jsonb,
  flow_map text NOT NULL DEFAULT '',
  diagram_url text DEFAULT '',
  difficulty text NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  integration_method text DEFAULT '',
  setup_complexity text DEFAULT 'medium' CHECK (setup_complexity IN ('low', 'medium', 'high')),
  estimated_time text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

-- Create inspirations table
CREATE TABLE IF NOT EXISTS inspirations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  inspiration_key text UNIQUE NOT NULL,
  title_en text NOT NULL,
  title_zh_tw text NOT NULL,
  description_en text NOT NULL,
  description_zh_tw text NOT NULL,
  steps jsonb NOT NULL DEFAULT '[]'::jsonb,
  stack_id uuid REFERENCES tool_stacks(id) ON DELETE SET NULL,
  difficulty text NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  estimated_time text NOT NULL DEFAULT '',
  learning_focus jsonb NOT NULL DEFAULT '[]'::jsonb,
  expected_skills jsonb NOT NULL DEFAULT '[]'::jsonb,
  resource_links jsonb NOT NULL DEFAULT '[]'::jsonb,
  outcome_demo text DEFAULT '',
  visual_hint text DEFAULT '',
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create persona_goals junction table
CREATE TABLE IF NOT EXISTS persona_goals (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  persona_id uuid NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
  goal_id uuid NOT NULL REFERENCES goals(id) ON DELETE CASCADE,
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(persona_id, goal_id)
);

-- Create goal_stacks junction table (multiple paths per goal)
CREATE TABLE IF NOT EXISTS goal_stacks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  goal_id uuid NOT NULL REFERENCES goals(id) ON DELETE CASCADE,
  stack_id uuid NOT NULL REFERENCES tool_stacks(id) ON DELETE CASCADE,
  implementation_type text DEFAULT 'standard' CHECK (implementation_type IN ('no-code', 'low-code', 'developer', 'standard')),
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(goal_id, stack_id, implementation_type)
);

-- Create goal_inspirations junction table
CREATE TABLE IF NOT EXISTS goal_inspirations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  goal_id uuid NOT NULL REFERENCES goals(id) ON DELETE CASCADE,
  inspiration_id uuid NOT NULL REFERENCES inspirations(id) ON DELETE CASCADE,
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(goal_id, inspiration_id)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_personas_key ON personas(persona_key);
CREATE INDEX IF NOT EXISTS idx_personas_skill ON personas(skill_level);
CREATE INDEX IF NOT EXISTS idx_personas_order ON personas(display_order);

CREATE INDEX IF NOT EXISTS idx_goals_key ON goals(goal_key);
CREATE INDEX IF NOT EXISTS idx_goals_difficulty ON goals(difficulty);
CREATE INDEX IF NOT EXISTS idx_goals_order ON goals(display_order);

CREATE INDEX IF NOT EXISTS idx_tool_stacks_key ON tool_stacks(stack_key);
CREATE INDEX IF NOT EXISTS idx_tool_stacks_difficulty ON tool_stacks(difficulty);

CREATE INDEX IF NOT EXISTS idx_inspirations_key ON inspirations(inspiration_key);
CREATE INDEX IF NOT EXISTS idx_inspirations_stack ON inspirations(stack_id);
CREATE INDEX IF NOT EXISTS idx_inspirations_difficulty ON inspirations(difficulty);
CREATE INDEX IF NOT EXISTS idx_inspirations_order ON inspirations(display_order);

CREATE INDEX IF NOT EXISTS idx_persona_goals_persona ON persona_goals(persona_id);
CREATE INDEX IF NOT EXISTS idx_persona_goals_goal ON persona_goals(goal_id);

CREATE INDEX IF NOT EXISTS idx_goal_stacks_goal ON goal_stacks(goal_id);
CREATE INDEX IF NOT EXISTS idx_goal_stacks_stack ON goal_stacks(stack_id);

CREATE INDEX IF NOT EXISTS idx_goal_inspirations_goal ON goal_inspirations(goal_id);
CREATE INDEX IF NOT EXISTS idx_goal_inspirations_inspiration ON goal_inspirations(inspiration_id);

CREATE INDEX IF NOT EXISTS idx_tools_tags ON tools USING GIN(tags);

-- Enable Row Level Security
ALTER TABLE personas ENABLE ROW LEVEL SECURITY;
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE tool_stacks ENABLE ROW LEVEL SECURITY;
ALTER TABLE inspirations ENABLE ROW LEVEL SECURITY;
ALTER TABLE persona_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE goal_stacks ENABLE ROW LEVEL SECURITY;
ALTER TABLE goal_inspirations ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Public read access for personas"
  ON personas FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for goals"
  ON goals FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for tool_stacks"
  ON tool_stacks FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for inspirations"
  ON inspirations FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for persona_goals"
  ON persona_goals FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for goal_stacks"
  ON goal_stacks FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for goal_inspirations"
  ON goal_inspirations FOR SELECT
  TO public
  USING (true);