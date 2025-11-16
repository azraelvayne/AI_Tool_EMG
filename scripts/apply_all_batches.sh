#!/bin/bash
for i in {1..6}; do
  echo "Applying batch $i..."
  # Use first 3 INSERT statements from each batch to test
  head -n 30 /tmp/cc-agent/58780327/project/supabase/migrations/temp_batch_$i.sql
done
