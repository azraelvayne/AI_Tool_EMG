/*
  # Add Translation Tables for Multilingual Support

  ## Overview
  This migration adds translation support for category metadata and tool content,
  enabling the application to display content in multiple languages (English and Traditional Chinese).

  ## New Tables

  ### 1. category_metadata_translations
  Stores translated versions of category labels:
  - `id` (uuid, primary key) - Unique identifier
  - `category_metadata_id` (uuid, foreign key) - References parent category
  - `language_code` (text) - Language code (en, zh-TW)
  - `translated_value` (text) - Translated category label
  - `created_at` (timestamptz) - Creation timestamp

  ### 2. tool_translations
  Stores translated versions of tool content:
  - `id` (uuid, primary key) - Unique identifier
  - `tool_id` (uuid, foreign key) - References parent tool
  - `language_code` (text) - Language code (en, zh-TW)
  - `summary` (text) - Translated summary
  - `description_styles` (jsonb) - Translated descriptions (encyclopedia, guide, strategy, inspiration)
  - `created_at` (timestamptz) - Creation timestamp

  ## Security
  - RLS enabled on both tables
  - Public read access for all translations
  - Write access prepared for future authentication

  ## Indexes
  - Composite index on (category_metadata_id, language_code)
  - Composite index on (tool_id, language_code)
  - Fast lookups for language-specific queries
*/

-- Create category_metadata_translations table
CREATE TABLE IF NOT EXISTS category_metadata_translations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  category_metadata_id uuid NOT NULL REFERENCES category_metadata(id) ON DELETE CASCADE,
  language_code text NOT NULL CHECK (language_code IN ('en', 'zh-TW')),
  translated_value text NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(category_metadata_id, language_code)
);

-- Create tool_translations table
CREATE TABLE IF NOT EXISTS tool_translations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tool_id uuid NOT NULL REFERENCES tools(id) ON DELETE CASCADE,
  language_code text NOT NULL CHECK (language_code IN ('en', 'zh-TW')),
  summary text NOT NULL DEFAULT '',
  description_styles jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  UNIQUE(tool_id, language_code)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_category_translations_lookup 
  ON category_metadata_translations(category_metadata_id, language_code);
CREATE INDEX IF NOT EXISTS idx_category_translations_lang 
  ON category_metadata_translations(language_code);
CREATE INDEX IF NOT EXISTS idx_tool_translations_lookup 
  ON tool_translations(tool_id, language_code);
CREATE INDEX IF NOT EXISTS idx_tool_translations_lang 
  ON tool_translations(language_code);

-- Enable Row Level Security
ALTER TABLE category_metadata_translations ENABLE ROW LEVEL SECURITY;
ALTER TABLE tool_translations ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Public read access for category translations"
  ON category_metadata_translations FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Public read access for tool translations"
  ON tool_translations FOR SELECT
  TO public
  USING (true);
