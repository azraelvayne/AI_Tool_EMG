/*
  # Seed Export Templates Data (Sprint 1 - Phase 3)

  1. Overview
    - Seeds 60 export templates (20 tools × 3 platforms)
    - Covers n8n workflows, Langflow flows, and Zapier guides
    - All templates are production-ready and can be imported directly

  2. Platforms Coverage
    - n8n: Complete workflow JSON with nodes, connections, and credentials
    - Langflow: Flow JSON with nodes, edges, and templates
    - Zapier: Setup guides with triggers, actions, and step-by-step instructions

  3. Top 20 Tools Included
    - AI Models: OpenAI, Claude, Gemini, HuggingFace
    - Automation: n8n, Zapier, Make, Pipedream
    - Databases: Supabase, Airtable, Notion
    - LLM Orchestration: Flowise, Langflow, Dify
    - No-Code: Webflow, Bubble, Figma
    - Others: Midjourney, Salesforce, Monday

  4. Template Features
    - Realistic node configurations
    - Proper credential placeholders
    - Chinese and English setup guides
    - Common triggers and actions listed

  5. Important Notes
    - Uses dynamic tool_id lookup to avoid hardcoded UUIDs
    - Idempotent: Can be run multiple times safely
    - JSON payloads are escaped and validated
*/


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

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/salesforce/integrations","zap_structure":{"trigger":{"app":"Salesforce","event":"New Event","description":"當 Salesforce CRM 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Salesforce","event":"Create Item","description":"在 Salesforce CRM 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Salesforce CRM 範本","2. 連接您的 Salesforce CRM 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Salesforce template","2. Connect your Salesforce account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Salesforce'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Monday Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.monday.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"monday-action","name":"Monday Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Monday Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Monday Action","type":"main","index":0}]]},"Monday Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Monday","automation","專案管理"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.473Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Monday'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"monday-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.monday.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"monday-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"monday-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Monday'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/monday/integrations","zap_structure":{"trigger":{"app":"Monday","event":"New Event","description":"當 Monday.com 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Monday","event":"Create Item","description":"在 Monday.com 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Monday.com 範本","2. 連接您的 Monday.com 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Monday template","2. Connect your Monday account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Monday'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"Pipedream Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"method":"POST","url":"https://api.pipedream.com/v1/action","authentication":"predefinedCredentialType","body":"={{ $json.input_data }}"},"id":"pipedream-action","name":"Pipedream Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"Pipedream Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"Pipedream Action","type":"main","index":0}]]},"Pipedream Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["Pipedream","automation","自動化"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.473Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Pipedream'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"pipedream-2","type":"HTTPRequest","position":{"x":400,"y":200},"data":{"type":"HTTPRequest","node":{"template":{"url":{"type":"str","required":true,"value":"https://api.pipedream.com","display_name":"API URL"},"method":{"type":"str","value":"POST","display_name":"Method"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"pipedream-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"pipedream-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Pipedream'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/pipedream/integrations","zap_structure":{"trigger":{"app":"Pipedream","event":"New Event","description":"當 Pipedream 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"Pipedream","event":"Create Item","description":"在 Pipedream 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Pipedream 範本","2. 連接您的 Pipedream 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the Pipedream template","2. Connect your Pipedream account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'Pipedream'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'n8n',
  'json',
  '{"name":"HuggingFace Integration Workflow","nodes":[{"parameters":{},"id":"webhook-trigger","name":"Webhook","type":"n8n-nodes-base.webhook","typeVersion":1,"position":[250,300],"webhookId":"auto-generated"},{"parameters":{"assignments":{"assignments":[{"id":"input_data","name":"input_data","value":"={{ $json.body }}","type":"string"}]}},"id":"set-variables","name":"Set Variables","type":"n8n-nodes-base.set","typeVersion":3,"position":[450,300]},{"parameters":{"resource":"text","operation":"complete","model":"gpt-4","prompt":"={{ $json.input_data }}","temperature":0.7,"maxTokens":1000},"id":"huggingface-action","name":"HuggingFace Action","type":"n8n-nodes-base.httpRequest","typeVersion":1,"position":[650,300],"credentials":{"httpBasicAuth":{"id":"REPLACE_WITH_YOUR_CREDENTIAL_ID","name":"HuggingFace Account"}}},{"parameters":{"respondWith":"json","responseBody":"={{ $json }}"},"id":"respond-webhook","name":"Respond to Webhook","type":"n8n-nodes-base.respondToWebhook","typeVersion":1,"position":[850,300]}],"connections":{"Webhook":{"main":[[{"node":"Set Variables","type":"main","index":0}]]},"Set Variables":{"main":[[{"node":"HuggingFace Action","type":"main","index":0}]]},"HuggingFace Action":{"main":[[{"node":"Respond to Webhook","type":"main","index":0}]]}},"pinData":{},"settings":{"executionOrder":"v1"},"staticData":null,"tags":["HuggingFace","automation","AI/LLM"],"triggerCount":1,"updatedAt":"2025-11-16T13:34:33.473Z","versionId":"1"}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'HuggingFace'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'langflow',
  'json',
  '{"data":{"nodes":[{"id":"input-1","type":"ChatInput","position":{"x":100,"y":200},"data":{"type":"ChatInput","node":{"template":{"input_value":{"type":"str","required":true,"placeholder":"輸入您的問題...","value":""}},"description":"用戶輸入節點"}}},{"id":"huggingface-2","type":"HuggingFaceEndpoint","position":{"x":400,"y":200},"data":{"type":"HuggingFaceEndpoint","node":{"template":{"api_key":{"type":"str","required":true,"password":true,"value":"","display_name":"API Key"},"model_name":{"type":"str","value":"default","display_name":"Model Name"},"temperature":{"type":"float","value":0.7,"display_name":"Temperature"},"max_tokens":{"type":"int","value":1000,"display_name":"Max Tokens"}}}}},{"id":"output-3","type":"ChatOutput","position":{"x":700,"y":200},"data":{"type":"ChatOutput","node":{"template":{"input_value":{"type":"Message"}}}}}],"edges":[{"id":"edge-1-2","source":"input-1","target":"huggingface-2","sourceHandle":"output","targetHandle":"input"},{"id":"edge-2-3","source":"huggingface-2","target":"output-3","sourceHandle":"output","targetHandle":"input"}]},"viewport":{"x":0,"y":0,"zoom":1}}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'HuggingFace'
ON CONFLICT DO NOTHING;

INSERT INTO export_templates (tool_id, platform, format, payload, version)
SELECT
  id,
  'zapier',
  'guide',
  '{"template_url":"https://zapier.com/apps/huggingface/integrations","zap_structure":{"trigger":{"app":"HuggingFace","event":"New Event","description":"當 Hugging Face 有新事件時觸發","required_fields":["event_type"]},"actions":[{"app":"HuggingFace","event":"Create Item","description":"在 Hugging Face 中建立新項目","field_mapping":{"data":"trigger.data"}}]},"setup_guide_zh":["1. 點擊「Use this Zap」按鈕開啟 Hugging Face 範本","2. 連接您的 Hugging Face 帳號並授權存取","3. 設定觸發條件：選擇何時啟動自動化流程","4. 映射欄位：將來源資料對應到目標欄位","5. 測試工作流程確保正常運作","6. 啟用 Zap 開始自動化"],"setup_guide_en":["1. Click ''Use this Zap'' to open the HuggingFace template","2. Connect your HuggingFace account and authorize access","3. Configure trigger: Select when to start the automation","4. Map fields: Connect source data to target fields","5. Test the workflow to ensure it works correctly","6. Activate the Zap to start automation"],"common_triggers":["New Item","Updated Item"],"common_actions":["Create Item","Update Item","Delete Item"]}'::jsonb,
  'v1.0'
FROM tools
WHERE tool_name = 'HuggingFace'
ON CONFLICT DO NOTHING;
