INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"n8n-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.n8n.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"n8n-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"n8n-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/n8n/integrations","zap_structure":{"trigger":{"app":"n8n","event":"New Event","description":"當 n8n 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"n8n","event":"Create Item","description":"在 n8n 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 n8n 範本","2. 連接您的 n8n 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the n8n template","2. Connect your n8n account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Zapier Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.zapier.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"zapier-action","name":"Zapier Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Zapier Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Zapier Action","type":"main","index":0}]]},"Zapier Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Zapier","automation","自動化"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.471Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Zapier'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"zapier-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.zapier.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"zapier-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"zapier-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Zapier'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/zapier/integrations","zap_structure":{"trigger":{"app":"Zapier","event":"New Event","description":"當 Zapier 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Zapier","event":"Create Item","description":"在 Zapier 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Zapier 範本","2. 連接您的 Zapier 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Zapier template","2. Connect your Zapier account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Zapier'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Make Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.make.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"make-action","name":"Make Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Make Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Make Action","type":"main","index":0}]]},"Make Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Make","automation","自動化"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.471Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"make-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.make.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"make-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"make-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/make/integrations","zap_structure":{"trigger":{"app":"Make","event":"New Event","description":"當 Make (Integromat) 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Make","event":"Create Item","description":"在 Make (Integromat) 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Make (Integromat) 範本","2. 連接您的 Make (Integromat) 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Make template","2. Connect your Make account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Make'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Supabase Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"operation":"select","table":"your_table_name","returnAll":true},"id":"supabase-action","name":"Supabase Action","type":"n8n-nodes-base.supabase","typeVersion":1,"position":[650,300],"credentials":{"supabaseApi":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Supabase Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Supabase Action","type":"main","index":0}]]},"Supabase Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Supabase","automation","資料庫"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.471Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"supabase-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.supabase.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"supabase-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"supabase-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Supabase'
ON CONFLICT DO NOTHING;

