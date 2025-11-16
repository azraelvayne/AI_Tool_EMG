INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/supabase/integrations","zap_structure":{"trigger":{"app":"Supabase","event":"New Event","description":"當 Supabase 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Supabase","event":"Create Item","description":"在 Supabase 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Supabase 範本","2. 連接您的 Supabase 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Supabase template","2. Connect your Supabase account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Row","Updated Row","Deleted Row"],"common_actions":["Insert Row","Update Row","Delete Row","Run Query"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Airtable Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"operation":"create","application":"YOUR_BASE_ID","table":"YOUR_TABLE_NAME","options":{}},"id":"airtable-action","name":"Airtable Action","type":"n8n-nodes-base.airtable","typeVersion":1,"position":[650,300],"credentials":{"airtableApi":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Airtable Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Airtable Action","type":"main","index":0}]]},"Airtable Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Airtable","automation","資料庫/內容"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.472Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"airtable-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.airtable.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"airtable-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"airtable-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/airtable/integrations","zap_structure":{"trigger":{"app":"Airtable","event":"New Record","description":"當 Airtable 表格中新增記錄時觸發","required_fields":["base","table"]},"actions":[{"app":"Airtable","event":"Create Record","description":"在 Airtable 表格中建立新記錄","field_mapping":{"base":"trigger.base","table":"trigger.table","fields":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Airtable 範本","2. 連接您的 Airtable 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Airtable template","2. Connect your Airtable account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Record","Updated Record","New Record in View"],"common_actions":["Create Record","Update Record","Find Record"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Airtable'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Notion Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"resource":"page","operation":"create","pageId":"={{ $json.parent_page_id }}","title":"={{ $json.title }}"},"id":"notion-action","name":"Notion Action","type":"n8n-nodes-base.notion","typeVersion":1,"position":[650,300],"credentials":{"notionApi":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Notion Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Notion Action","type":"main","index":0}]]},"Notion Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Notion","automation","知識管理"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.472Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"notion-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.notion.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"notion-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"notion-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/notion/integrations","zap_structure":{"trigger":{"app":"Notion","event":"New Database Item","description":"當 Notion 資料庫中新增項目時觸發","required_fields":["database_id"]},"actions":[{"app":"Notion","event":"Create Database Item","description":"在 Notion 資料庫中建立新項目","field_mapping":{"database_id":"trigger.database_id","properties":"trigger.properties"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Notion 範本","2. 連接您的 Notion 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Notion template","2. Connect your Notion account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Database Item","Updated Database Item","New Page"],"common_actions":["Create Page","Update Database Item","Add Comment"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Notion'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Flowise Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.flowise.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"flowise-action","name":"Flowise Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Flowise Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Flowise Action","type":"main","index":0}]]},"Flowise Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Flowise","automation","LLM 編排"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.472Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"flowise-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.flowise.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"flowise-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"flowise-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/flowise/integrations","zap_structure":{"trigger":{"app":"Flowise","event":"New Event","description":"當 Flowise 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Flowise","event":"Create Item","description":"在 Flowise 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Flowise 範本","2. 連接您的 Flowise 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Flowise template","2. Connect your Flowise account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Flowise'
ON CONFLICT DO NOTHING;

