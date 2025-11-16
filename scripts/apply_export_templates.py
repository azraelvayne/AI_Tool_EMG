import json
import sys

# Read the SQL file
with open('/tmp/cc-agent/58780327/project/supabase/migrations/20251116150100_seed_export_templates_v1.sql', 'r') as f:
    content = f.read()

# Split by INSERT statements
inserts = content.split('INSERT INTO export_templates')
print(f"Found {len(inserts)} INSERT statements (including header)")

# Skip the header (first element)
for i, insert_block in enumerate(inserts[1:], 1):
    sql = 'INSERT INTO export_templates' + insert_block.strip()
    # Print only the first 200 chars for progress tracking
    tool_name_start = sql.find("tool_name = '") + 13
    tool_name_end = sql.find("'", tool_name_start)
    tool_name = sql[tool_name_start:tool_name_end] if tool_name_start > 12 else "unknown"
    
    platform_start = sql.find("'", sql.find("SELECT")) + 1
    platform_end = sql.find("'", platform_start)
    platform = sql[platform_start:platform_end] if platform_start > 0 else "unknown"
    
    print(f"Statement {i}: {tool_name} - {platform} ({len(sql)} chars)")
