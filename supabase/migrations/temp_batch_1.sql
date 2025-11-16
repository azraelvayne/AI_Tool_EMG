INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"OpenAI Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"resource":"text","operation":"complete","model":"gpt-4","prompt":"={{ $json.input_data }}","temperature":0.7,"maxTokens":1000},"id":"openai-action","name":"OpenAI Action","type":"n8n-nodes-base.openAi","typeVersion":1,"position":[650,300],"credentials":{"openAiApi":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"OpenAI Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"OpenAI Action","type":"main","index":0}]]},"OpenAI Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["OpenAI","automation","AI/LLM"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.470Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"openai-2","type":"OpenAI","position":{"x":400,"y":200},"data":{"type":"OpenAI","node":{"template":{"api_key":{"type":"str","required":true,"password":true,"value":"","display_name":"API Key"},"model_name":{"type":"str","value":"gpt-4","display_name":"Model Name"},"temperature":{"type":"float","value":0.7,"display_name":"Temperature"},"max_tokens":{"type":"int","value":1000,"display_name":"Max Tokens"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"openai-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"openai-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/openai/integrations","zap_structure":{"trigger":{"app":"OpenAI","event":"New Event","description":"當 OpenAI 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"OpenAI","event":"Generate Text","description":"使用 GPT 模型生成文字","field_mapping":{"prompt":"trigger.message","model":"gpt-4"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 OpenAI 範本","2. 連接您的 OpenAI 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the OpenAI template","2. Connect your OpenAI account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["API Request","Scheduled Generation"],"common_actions":["Generate Text","Create Embedding","Generate Image"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'OpenAI'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Claude Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"resource":"text","operation":"complete","model":"gpt-4","prompt":"={{ $json.input_data }}","temperature":0.7,"maxTokens":1000},"id":"anthropic-action","name":"Claude Action","type":"n8n-nodes-base.anthropic","typeVersion":1,"position":[650,300],"credentials":{"anthropicApi":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Anthropic Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Claude Action","type":"main","index":0}]]},"Claude Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Claude","automation","AI/LLM"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.471Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"anthropic-2","type":"ChatAnthropic","position":{"x":400,"y":200},"data":{"type":"ChatAnthropic","node":{"template":{"api_key":{"type":"str","required":true,"password":true,"value":"","display_name":"API Key"},"model_name":{"type":"str","value":"claude-3-opus-20240229","display_name":"Model Name"},"temperature":{"type":"float","value":0.7,"display_name":"Temperature"},"max_tokens":{"type":"int","value":1000,"display_name":"Max Tokens"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"anthropic-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"anthropic-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/anthropic/integrations","zap_structure":{"trigger":{"app":"Claude","event":"New Event","description":"當 Anthropic Claude 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Claude","event":"Create Item","description":"在 Anthropic Claude 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Anthropic Claude 範本","2. 連接您的 Anthropic Claude 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Claude template","2. Connect your Claude account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Claude'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Gemini Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"resource":"text","operation":"complete","model":"gpt-4","prompt":"={{ $json.input_data }}","temperature":0.7,"maxTokens":1000},"id":"google_gemini-action","name":"Gemini Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Gemini Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Gemini Action","type":"main","index":0}]]},"Gemini Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Gemini","automation","AI/LLM"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.471Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Gemini'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"google-gemini-2","type":"ChatGoogleGenerativeAI","position":{"x":400,"y":200},"data":{"type":"ChatGoogleGenerativeAI","node":{"template":{"api_key":{"type":"str","required":true,"password":true,"value":"","display_name":"API Key"},"model_name":{"type":"str","value":"default","display_name":"Model Name"},"temperature":{"type":"float","value":0.7,"display_name":"Temperature"},"max_tokens":{"type":"int","value":1000,"display_name":"Max Tokens"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"google-gemini-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"google-gemini-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Gemini'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/google-gemini/integrations","zap_structure":{"trigger":{"app":"Gemini","event":"New Event","description":"當 Google Gemini 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Gemini","event":"Create Item","description":"在 Google Gemini 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Google Gemini 範本","2. 連接您的 Google Gemini 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Gemini template","2. Connect your Gemini account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Gemini'
ON CONFLICT DO NOTHING;


INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"n8n Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.n8n.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"n8n-action","name":"n8n Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"n8n Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"n8n Action","type":"main","index":0}]]},"n8n Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["n8n","automation","自動化"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.471Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'n8n'
ON CONFLICT DO NOTHING;

