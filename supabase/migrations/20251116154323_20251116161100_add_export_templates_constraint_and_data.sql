/*
  # Add Export Templates with Proper Constraints

  ## Changes
  1. Add unique constraint on (tool_id, platform) to prevent duplicates
  2. Populate export templates for popular tools
  3. Include n8n workflows, Langflow flows, and Zapier guides
*/

-- Add unique constraint if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint 
    WHERE conname = 'export_templates_tool_platform_unique'
  ) THEN
    ALTER TABLE export_templates 
    ADD CONSTRAINT export_templates_tool_platform_unique 
    UNIQUE (tool_id, platform);
  END IF;
END $$;

-- Helper function
CREATE OR REPLACE FUNCTION get_tool_id_by_slug(slug_param text)
RETURNS uuid AS $$
DECLARE
  tool_uuid uuid;
BEGIN
  SELECT id INTO tool_uuid FROM tools WHERE source_slug = slug_param LIMIT 1;
  RETURN tool_uuid;
END;
$$ LANGUAGE plpgsql;

-- Delete existing templates to avoid conflicts
DELETE FROM export_templates;

-- n8n Templates
INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('openai'),
  'n8n',
  'json',
  jsonb_build_object(
    'name', 'OpenAI Integration Workflow',
    'nodes', jsonb_build_array(
      jsonb_build_object(
        'parameters', jsonb_build_object(),
        'name', 'Start',
        'type', 'n8n-nodes-base.start',
        'typeVersion', 1,
        'position', jsonb_build_array(250, 300)
      ),
      jsonb_build_object(
        'parameters', jsonb_build_object(
          'resource', 'text',
          'operation', 'complete',
          'model', 'gpt-4',
          'prompt', '={{$json["query"]}}'
        ),
        'name', 'OpenAI',
        'type', 'n8n-nodes-base.openAi',
        'typeVersion', 1,
        'position', jsonb_build_array(450, 300)
      )
    ),
    'connections', jsonb_build_object(
      'Start', jsonb_build_object(
        'main', jsonb_build_array(jsonb_build_array(jsonb_build_object('node', 'OpenAI', 'type', 'main', 'index', 0)))
      )
    )
  ),
  'v1.0'
WHERE get_tool_id_by_slug('openai') IS NOT NULL;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('supabase'),
  'n8n',
  'json',
  jsonb_build_object(
    'name', 'Supabase Database Operations',
    'nodes', jsonb_build_array(
      jsonb_build_object(
        'parameters', jsonb_build_object(),
        'name', 'Start',
        'type', 'n8n-nodes-base.start',
        'typeVersion', 1,
        'position', jsonb_build_array(250, 300)
      ),
      jsonb_build_object(
        'parameters', jsonb_build_object(
          'operation', 'getAll',
          'tableId', '={{$json["table"]}}',
          'returnAll', true
        ),
        'name', 'Supabase',
        'type', 'n8n-nodes-base.supabase',
        'typeVersion', 1,
        'position', jsonb_build_array(450, 300)
      )
    ),
    'connections', jsonb_build_object(
      'Start', jsonb_build_object(
        'main', jsonb_build_array(jsonb_build_array(jsonb_build_object('node', 'Supabase', 'type', 'main', 'index', 0)))
      )
    )
  ),
  'v1.0'
WHERE get_tool_id_by_slug('supabase') IS NOT NULL;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('airtable'),
  'n8n',
  'json',
  jsonb_build_object(
    'name', 'Airtable Data Sync',
    'nodes', jsonb_build_array(
      jsonb_build_object(
        'parameters', jsonb_build_object(),
        'name', 'Start',
        'type', 'n8n-nodes-base.start',
        'typeVersion', 1,
        'position', jsonb_build_array(250, 300)
      ),
      jsonb_build_object(
        'parameters', jsonb_build_object(
          'operation', 'list',
          'base', jsonb_build_object('value', '={{$json["baseId"]}}'),
          'table', jsonb_build_object('value', '={{$json["tableName"]}}')
        ),
        'name', 'Airtable',
        'type', 'n8n-nodes-base.airtable',
        'typeVersion', 1,
        'position', jsonb_build_array(450, 300)
      )
    ),
    'connections', jsonb_build_object(
      'Start', jsonb_build_object(
        'main', jsonb_build_array(jsonb_build_array(jsonb_build_object('node', 'Airtable', 'type', 'main', 'index', 0)))
      )
    )
  ),
  'v1.0'
WHERE get_tool_id_by_slug('airtable') IS NOT NULL;

-- Langflow Templates
INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('openai'),
  'langflow',
  'json',
  jsonb_build_object(
    'name', 'OpenAI Chat Flow',
    'description', 'Simple OpenAI chat workflow',
    'data', jsonb_build_object(
      'nodes', jsonb_build_array(
        jsonb_build_object(
          'id', 'chatinput-1',
          'type', 'ChatInput',
          'position', jsonb_build_object('x', 100, 'y', 200)
        ),
        jsonb_build_object(
          'id', 'openai-1',
          'type', 'ChatOpenAI',
          'position', jsonb_build_object('x', 400, 'y', 200),
          'data', jsonb_build_object(
            'node', jsonb_build_object(
              'template', jsonb_build_object(
                'model_name', jsonb_build_object('value', 'gpt-4')
              )
            )
          )
        ),
        jsonb_build_object(
          'id', 'chatoutput-1',
          'type', 'ChatOutput',
          'position', jsonb_build_object('x', 700, 'y', 200)
        )
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id', 'e1', 'source', 'chatinput-1', 'target', 'openai-1'),
        jsonb_build_object('id', 'e2', 'source', 'openai-1', 'target', 'chatoutput-1')
      )
    )
  ),
  'v1.0'
WHERE get_tool_id_by_slug('openai') IS NOT NULL;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('supabase'),
  'langflow',
  'json',
  jsonb_build_object(
    'name', 'Supabase Vector Store RAG',
    'description', 'Retrieval Augmented Generation with Supabase'
  ),
  'v1.0'
WHERE get_tool_id_by_slug('supabase') IS NOT NULL;

-- Zapier Templates
INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('openai'),
  'zapier',
  'guide',
  jsonb_build_object(
    'title', 'OpenAI Integration with Zapier',
    'description', 'Automate OpenAI tasks with 5000+ apps',
    'template_url', 'https://zapier.com/apps/openai/integrations',
    'setup_steps', jsonb_build_array(
      'Connect your OpenAI API key',
      'Choose a trigger app',
      'Add OpenAI action (Send Prompt)',
      'Configure output destination',
      'Test and activate'
    ),
    'common_use_cases', jsonb_build_array(
      'Auto-reply to emails',
      'Generate social media content',
      'Analyze customer feedback',
      'Create document summaries'
    )
  ),
  'v1.0'
WHERE get_tool_id_by_slug('openai') IS NOT NULL;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('airtable'),
  'zapier',
  'guide',
  jsonb_build_object(
    'title', 'Airtable Automation with Zapier',
    'description', 'Connect Airtable with 5000+ apps',
    'template_url', 'https://zapier.com/apps/airtable/integrations',
    'setup_steps', jsonb_build_array(
      'Connect Airtable account',
      'Select base and table',
      'Configure trigger or action',
      'Map data fields',
      'Test and enable Zap'
    ),
    'common_use_cases', jsonb_build_array(
      'Auto-create records from forms',
      'Sync with other databases',
      'Send notifications on updates',
      'Generate automated reports'
    )
  ),
  'v1.0'
WHERE get_tool_id_by_slug('airtable') IS NOT NULL;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT 
  get_tool_id_by_slug('notion'),
  'zapier',
  'guide',
  jsonb_build_object(
    'title', 'Notion Automation with Zapier',
    'description', 'Automate your Notion workspace',
    'template_url', 'https://zapier.com/apps/notion/integrations',
    'setup_steps', jsonb_build_array(
      'Connect Notion workspace',
      'Select database or page',
      'Configure create/update actions',
      'Map trigger data to Notion properties',
      'Activate automation'
    ),
    'common_use_cases', jsonb_build_array(
      'Create pages from emails',
      'Log tasks from PM tools',
      'Save social posts to Notion',
      'Sync meeting notes from calendar'
    )
  ),
  'v1.0'
WHERE get_tool_id_by_slug('notion') IS NOT NULL;

-- Cleanup
DROP FUNCTION IF EXISTS get_tool_id_by_slug(text);

/*
  Migration Complete
  ------------------
  - Added unique constraint on (tool_id, platform)
  - Created 8 export templates across 3 platforms
  - n8n: 3 workflow JSONs
  - Langflow: 2 flow JSONs  
  - Zapier: 3 setup guides

  Next: Implement UI components to display these templates
*/
