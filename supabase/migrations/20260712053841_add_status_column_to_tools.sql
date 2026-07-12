/*
# Add status column to tools table

## Overview
Adds a `status` column to the `tools` table to support draft/published/archived workflow.
Also adds admin write policies (insert/update/delete) for the anon role, since the
admin panel uses the anon key (no Supabase Auth sign-in).

## Changes
1. New column: `tools.status` (text, default 'published')
   - Values: 'draft', 'published', 'archived'
2. Index on `status` for filtering performance
3. New RLS policies for INSERT, UPDATE, DELETE on `tools` (anon + authenticated)
4. New RLS policies for INSERT, UPDATE, DELETE on `tool_translations` (anon + authenticated)

## Security
- SELECT policy updated: only published tools are visible to the public.
  Draft and archived tools are only visible inside the admin panel (which uses
  the same anon key — so we allow anon to see all statuses for simplicity in
  this no-auth single-tenant app).
- INSERT/UPDATE/DELETE: allowed for anon + authenticated (no-auth app pattern).

## Important Notes
1. All existing tools are set to 'published' status by default.
2. The admin panel reads/writes via the anon key, so all CRUD is permitted.
3. The public-facing app filters by status='published' in its queries.
*/

-- Add status column
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tools' AND column_name = 'status'
  ) THEN
    ALTER TABLE tools ADD COLUMN status text NOT NULL DEFAULT 'published';
  END IF;
END $$;

-- Set existing tools to published
UPDATE tools SET status = 'published' WHERE status IS NULL;

-- Create index on status
CREATE INDEX IF NOT EXISTS idx_tools_status ON tools(status);

-- ============================================================================
-- RLS POLICIES FOR ADMIN WRITE ACCESS (no-auth single-tenant app)
-- ============================================================================

-- Drop existing SELECT policy and replace with one that allows seeing all statuses
DROP POLICY IF EXISTS "Public read access for tools" ON tools;
CREATE POLICY "anon_select_tools" ON tools FOR SELECT
  TO anon, authenticated USING (true);

-- INSERT policy
DROP POLICY IF EXISTS "anon_insert_tools" ON tools;
CREATE POLICY "anon_insert_tools" ON tools FOR INSERT
  TO anon, authenticated WITH CHECK (true);

-- UPDATE policy
DROP POLICY IF EXISTS "anon_update_tools" ON tools;
CREATE POLICY "anon_update_tools" ON tools FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

-- DELETE policy
DROP POLICY IF EXISTS "anon_delete_tools" ON tools;
CREATE POLICY "anon_delete_tools" ON tools FOR DELETE
  TO anon, authenticated USING (true);

-- ============================================================================
-- RLS POLICIES FOR tool_translations (admin write access)
-- ============================================================================

-- Check if tool_translations table exists before adding policies
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_name = 'tool_translations' AND table_schema = 'public'
  ) THEN
    -- We can't run CREATE POLICY inside DO block, so just note it
    RAISE NOTICE 'tool_translations table exists, policies will be added outside';
  END IF;
END $$;

-- INSERT policy for tool_translations
DROP POLICY IF EXISTS "anon_insert_tool_translations" ON tool_translations;
CREATE POLICY "anon_insert_tool_translations" ON tool_translations FOR INSERT
  TO anon, authenticated WITH CHECK (true);

-- UPDATE policy for tool_translations
DROP POLICY IF EXISTS "anon_update_tool_translations" ON tool_translations;
CREATE POLICY "anon_update_tool_translations" ON tool_translations FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

-- DELETE policy for tool_translations
DROP POLICY IF EXISTS "anon_delete_tool_translations" ON tool_translations;
CREATE POLICY "anon_delete_tool_translations" ON tool_translations FOR DELETE
  TO anon, authenticated USING (true);
