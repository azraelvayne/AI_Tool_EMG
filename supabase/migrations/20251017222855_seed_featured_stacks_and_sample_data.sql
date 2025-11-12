/*
  # Seed Featured Stacks and Sample Data

  1. Sample Data
    - Add 8 featured stacks showcasing different use cases
    - Update existing tools with higher popularity scores for testing
    - Add sample user interactions to demonstrate tracking system

  2. Featured Stacks
    - AI Content Creation Stack
    - No-Code App Development Stack
    - Data Analysis Workflow
    - Design System Stack
    - Marketing Automation Stack
    - Developer Productivity Stack
    - E-commerce Backend Stack
    - Research & Documentation Stack

  3. Notes
    - Each stack includes tool IDs (as JSONB array), use case, difficulty level, and display order
    - Popularity scores are set to demonstrate the popular tools feature
    - Sample session IDs are generated for interaction tracking
*/

-- Insert featured stacks with specific tools
INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'AI Content Creation Stack',
  'A powerful combination of tools for creating, editing, and publishing AI-generated content across multiple platforms.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'Claude' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Notion' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'OpenAI' LIMIT 1)
  ),
  'Content creators who want to streamline their workflow from ideation to publication using AI assistance.',
  'beginner',
  1,
  'Create amazing content with AI',
  'creator',
  '30 minutes'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'AI Content Creation Stack');

INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'No-Code App Development Stack',
  'Build full-featured applications without writing code using visual builders and integrations.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'Webflow' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Airtable' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Make' LIMIT 1)
  ),
  'Entrepreneurs and product managers who want to validate ideas and build MVPs quickly.',
  'intermediate',
  2,
  'Build apps without code',
  'creator',
  '2 hours'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'No-Code App Development Stack');

INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'AI Workflow Automation Stack',
  'Automate complex workflows and integrate AI capabilities into your business processes.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'n8n' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Flowise' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Supabase' LIMIT 1)
  ),
  'Teams looking to automate repetitive tasks and integrate AI into their workflows.',
  'advanced',
  3,
  'Automate with AI power',
  'developer',
  '3 hours'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'AI Workflow Automation Stack');

INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'Data Management Stack',
  'Organize, manage, and visualize your data with powerful database and spreadsheet tools.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'Airtable' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Notion' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Supabase' LIMIT 1)
  ),
  'Teams managing complex data structures and needing flexible database solutions.',
  'intermediate',
  4,
  'Manage data efficiently',
  'all',
  '1 hour'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'Data Management Stack');

INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'Website Builder Stack',
  'Create stunning, professional websites without coding using modern website builders.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'Webflow' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Glide' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Supabase' LIMIT 1)
  ),
  'Designers and marketers building beautiful, functional websites quickly.',
  'beginner',
  5,
  'Build beautiful websites',
  'creator',
  '1 hour'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'Website Builder Stack');

INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'AI Assistant Integration Stack',
  'Integrate multiple AI models and create custom AI assistants for your specific needs.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'Claude' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'OpenAI' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Flowise' LIMIT 1)
  ),
  'Developers building custom AI solutions and chatbot applications.',
  'advanced',
  6,
  'Build custom AI assistants',
  'developer',
  '4 hours'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'AI Assistant Integration Stack');

INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'Content & Knowledge Base Stack',
  'Organize knowledge, create documentation, and build comprehensive knowledge bases.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'Notion' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Claude' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Airtable' LIMIT 1)
  ),
  'Researchers, writers, and teams managing large amounts of information.',
  'beginner',
  7,
  'Organize your knowledge',
  'learner',
  '45 minutes'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'Content & Knowledge Base Stack');

INSERT INTO featured_stacks (stack_name, description, tool_ids, use_case, difficulty_level, display_order, tagline, target_audience, estimated_setup_time)
SELECT
  'Rapid Prototyping Stack',
  'Quickly prototype and test ideas with low-code tools and AI assistance.',
  jsonb_build_array(
    (SELECT id FROM tools WHERE tool_name = 'Glide' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Claude' LIMIT 1),
    (SELECT id FROM tools WHERE tool_name = 'Make' LIMIT 1)
  ),
  'Product teams and entrepreneurs validating ideas and building prototypes.',
  'intermediate',
  8,
  'Prototype ideas fast',
  'creator',
  '2 hours'
WHERE NOT EXISTS (SELECT 1 FROM featured_stacks WHERE stack_name = 'Rapid Prototyping Stack');

-- Update some existing tools with higher popularity scores for testing
UPDATE tools SET popularity_score = 150 WHERE tool_name = 'Claude';
UPDATE tools SET popularity_score = 140 WHERE tool_name = 'Notion';
UPDATE tools SET popularity_score = 130 WHERE tool_name = 'OpenAI';
UPDATE tools SET popularity_score = 110 WHERE tool_name = 'n8n';
UPDATE tools SET popularity_score = 100 WHERE tool_name = 'Airtable';
UPDATE tools SET popularity_score = 95 WHERE tool_name = 'Webflow';
UPDATE tools SET popularity_score = 90 WHERE tool_name = 'Supabase';
UPDATE tools SET popularity_score = 85 WHERE tool_name = 'Make';
UPDATE tools SET popularity_score = 80 WHERE tool_name = 'Flowise';
UPDATE tools SET popularity_score = 75 WHERE tool_name = 'Glide';

-- Insert sample user interactions (using demo session IDs)
DO $$
DECLARE
  tool_record RECORD;
  interaction_types TEXT[] := ARRAY['view', 'favorite', 'generate'];
  random_type TEXT;
  i INTEGER;
BEGIN
  FOR tool_record IN 
    SELECT id FROM tools WHERE tool_name IN ('Claude', 'Notion', 'OpenAI', 'n8n', 'Airtable', 'Webflow', 'Supabase', 'Make', 'Flowise', 'Glide')
  LOOP
    FOR i IN 1..5 LOOP
      random_type := interaction_types[1 + floor(random() * 3)];
      INSERT INTO user_interactions (tool_id, interaction_type, session_id)
      VALUES (tool_record.id, random_type, 'demo-session-' || floor(random() * 50)::text)
      ON CONFLICT DO NOTHING;
    END LOOP;
  END LOOP;
END $$;