INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Langflow Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.langflow.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"langflow-action","name":"Langflow Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Langflow Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Langflow Action","type":"main","index":0}]]},"Langflow Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Langflow","automation","LLM 編排"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.472Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Langflow'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"langflow-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.langflow.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"langflow-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"langflow-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Langflow'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/langflow/integrations","zap_structure":{"trigger":{"app":"Langflow","event":"New Event","description":"當 Langflow 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Langflow","event":"Create Item","description":"在 Langflow 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Langflow 範本","2. 連接您的 Langflow 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Langflow template","2. Connect your Langflow account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Langflow'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Dify Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.dify.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"dify-action","name":"Dify Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Dify Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Dify Action","type":"main","index":0}]]},"Dify Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Dify","automation","AI 平台"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.472Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Dify'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"dify-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.dify.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"dify-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"dify-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Dify'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/dify/integrations","zap_structure":{"trigger":{"app":"Dify","event":"New Event","description":"當 Dify.ai 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Dify","event":"Create Item","description":"在 Dify.ai 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Dify.ai 範本","2. 連接您的 Dify.ai 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Dify template","2. Connect your Dify account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Dify'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Webflow Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.webflow.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"webflow-action","name":"Webflow Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Webflow Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Webflow Action","type":"main","index":0}]]},"Webflow Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Webflow","automation","前端設計"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.472Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"webflow-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.webflow.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"webflow-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"webflow-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/webflow/integrations","zap_structure":{"trigger":{"app":"Webflow","event":"New Event","description":"當 Webflow 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Webflow","event":"Create Item","description":"在 Webflow 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Webflow 範本","2. 連接您的 Webflow 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Webflow template","2. Connect your Webflow account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Webflow'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Bubble Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.bubble.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"bubble-action","name":"Bubble Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Bubble Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Bubble Action","type":"main","index":0}]]},"Bubble Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Bubble","automation","無程式建構"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.473Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Bubble'
ON CONFLICT DO NOTHING;

