# This script will output SQL in batches that can be executed
with open('/tmp/cc-agent/58780327/project/supabase/migrations/20251116150100_seed_export_templates_v1.sql', 'r') as f:
    content = f.read()

# Extract all INSERT statements
inserts = content.split('INSERT INTO export_templates')[1:]  # Skip header

# Create batches of 10 statements each
batch_size = 10
for i in range(0, len(inserts), batch_size):
    batch = inserts[i:i+batch_size]
    batch_sql = '\n'.join(['INSERT INTO export_templates' + stmt for stmt in batch])
    
    # Save each batch to a file
    batch_num = i // batch_size + 1
    with open(f'/tmp/cc-agent/58780327/project/supabase/migrations/temp_batch_{batch_num}.sql', 'w') as f:
        f.write(batch_sql)
    
    print(f"Batch {batch_num}: {len(batch)} statements")

print(f"\nTotal batches: {(len(inserts) + batch_size - 1) // batch_size}")
