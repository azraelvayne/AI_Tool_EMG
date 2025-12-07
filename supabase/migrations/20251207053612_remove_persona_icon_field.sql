/*
  # Remove Icon Emoji Field from Personas Table

  ## Overview
  Removes the fallback `icon` field from the personas table since all personas now use custom illustration images via `icon_url`.
  This simplifies the schema and ensures consistent image-only display across the application.

  ## Changes
  1. Drop the `icon` column from the personas table
    - Previously used as emoji fallback (e.g., "🎨", "📊")
    - Now redundant with `icon_url` providing full illustration images
    - Cleans up database schema

  ## Security
  - No changes to RLS policies needed
  - No data loss (emoji icons are no longer needed)
  - All personas maintain their icon_url references

  ## Notes
  - All 6 personas have valid icon_url pointing to /public/personas/ images
  - Images used: creative-builder.png, data-analyst-zh.jpg, ai-tool-designer-full.png, knowledge-manager-zh.jpg, business-developer-zh.png, workflow-architect.jpg
*/

-- Remove icon column from personas table
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'personas' AND column_name = 'icon'
  ) THEN
    ALTER TABLE personas DROP COLUMN icon;
  END IF;
END $$;
