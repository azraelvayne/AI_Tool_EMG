# Backup Data Directory

This directory contains historical data files that were previously used during development but are no longer actively used by the application.

## Purpose

All tool data, featured stacks, and other content is now stored in and loaded from the Supabase database. The application no longer reads from local JSON files in the `src/` directory.

## Contents

This directory may contain:
- `tools_dataset.json` - Historical tool data (if backed up)
- `featured_stacks.json` - Historical featured stack data (if backed up)
- Other deprecated data files from earlier development phases

## Note

These files are kept for reference only. The application sources all data from the Supabase PostgreSQL database via the `src/lib/database.ts` module.

If you need to restore or reference old data structures, these files may serve as examples, but they should not be imported into the application code.
