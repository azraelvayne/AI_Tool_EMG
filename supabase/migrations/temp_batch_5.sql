INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"bubble-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.bubble.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"bubble-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"bubble-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Bubble'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/bubble/integrations","zap_structure":{"trigger":{"app":"Bubble","event":"New Event","description":"當 Bubble.io 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Bubble","event":"Create Item","description":"在 Bubble.io 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Bubble.io 範本","2. 連接您的 Bubble.io 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Bubble template","2. Connect your Bubble account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Bubble'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Figma Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.figma.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"figma-action","name":"Figma Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Figma Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Figma Action","type":"main","index":0}]]},"Figma Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Figma","automation","設計"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.473Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Figma'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"figma-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.figma.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"figma-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"figma-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Figma'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/figma/integrations","zap_structure":{"trigger":{"app":"Figma","event":"New Event","description":"當 Figma 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Figma","event":"Create Item","description":"在 Figma 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Figma 範本","2. 連接您的 Figma 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Figma template","2. Connect your Figma account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Figma'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Midjourney Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.midjourney.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"midjourney-action","name":"Midjourney Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Midjourney Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Midjourney Action","type":"main","index":0}]]},"Midjourney Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Midjourney","automation","圖像生成"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.473Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Midjourney'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"midjourney-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.midjourney.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"midjourney-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"midjourney-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Midjourney'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/midjourney/integrations","zap_structure":{"trigger":{"app":"Midjourney","event":"New Event","description":"當 Midjourney 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Midjourney","event":"Create Item","description":"在 Midjourney 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Midjourney 範本","2. 連接您的 Midjourney 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Midjourney template","2. Connect your Midjourney account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Midjourney'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Salesforce Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.salesforce.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"salesforce-action","name":"Salesforce Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Salesforce Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Salesforce Action","type":"main","index":0}]]},"Salesforce Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Salesforce","automation","CRM"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.473Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Salesforce'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"salesforce-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.salesforce.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"salesforce-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"salesforce-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Salesforce'
ON CONFLICT DO NOTHING;

