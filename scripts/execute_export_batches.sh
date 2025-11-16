#!/bin/bash
echo "Executing export templates in batches..."
for i in {1..6}; do
  echo "Processing batch $i..."
  cat /tmp/cc-agent/58780327/project/supabase/migrations/temp_batch_$i.sql
  echo ""
  echo "---"
done
