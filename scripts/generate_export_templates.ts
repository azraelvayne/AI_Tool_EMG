import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

interface Tool {
  id: string;
  name_en: string;
  name_zh: string;
  category_zh: string;
}

interface ExportTemplate {
  tool_id: string;
  tool_name: string;
  platform: 'n8n' | 'langflow' | 'zapier';
  format: 'json' | 'guide';
  payload: any;
  version: string;
}

const generateN8NTemplate = (tool: Tool): any => {
  const toolSlug = tool.id.replace(/-/g, '_');
  const nodeType = getN8NNodeType(tool);

  return {
    name: `${tool.name_en} Integration Workflow`,
    nodes: [
      {
        parameters: {},
        id: "webhook-trigger",
        name: "Webhook",
        type: "n8n-nodes-base.webhook",
        typeVersion: 1,
        position: [250, 300],
        webhookId: "auto-generated"
      },
      {
        parameters: {
          assignments: {
            assignments: [
              {
                id: "input_data",
                name: "input_data",
                value: "={{ $json.body }}",
                type: "string"
              }
            ]
          }
        },
        id: "set-variables",
        name: "Set Variables",
        type: "n8n-nodes-base.set",
        typeVersion: 3,
        position: [450, 300]
      },
      {
        parameters: getN8NParameters(tool),
        id: `${toolSlug}-action`,
        name: `${tool.name_en} Action`,
        type: nodeType,
        typeVersion: 1,
        position: [650, 300],
        credentials: getN8NCredentials(tool)
      },
      {
        parameters: {
          respondWith: "json",
          responseBody: "={{ $json }}"
        },
        id: "respond-webhook",
        name: "Respond to Webhook",
        type: "n8n-nodes-base.respondToWebhook",
        typeVersion: 1,
        position: [850, 300]
      }
    ],
    connections: {
      "Webhook": {
        "main": [[{ "node": "Set Variables", "type": "main", "index": 0 }]]
      },
      "Set Variables": {
        "main": [[{ "node": `${tool.name_en} Action`, "type": "main", "index": 0 }]]
      },
      [`${tool.name_en} Action`]: {
        "main": [[{ "node": "Respond to Webhook", "type": "main", "index": 0 }]]
      }
    },
    pinData: {},
    settings: {
      executionOrder: "v1"
    },
    staticData: null,
    tags: [tool.name_en, "automation", tool.category_zh],
    triggerCount: 1,
    updatedAt: new Date().toISOString(),
    versionId: "1"
  };
};

const generateLangflowTemplate = (tool: Tool): any => {
  const toolSlug = tool.id;
  const nodeType = getLangflowNodeType(tool);

  return {
    data: {
      nodes: [
        {
          id: "input-1",
          type: "ChatInput",
          position: { x: 100, y: 200 },
          data: {
            type: "ChatInput",
            node: {
              template: {
                input_value: {
                  type: "str",
                  required: true,
                  placeholder: "輸入您的問題...",
                  value: ""
                }
              },
              description: "用戶輸入節點"
            }
          }
        },
        {
          id: `${toolSlug}-2`,
          type: nodeType,
          position: { x: 400, y: 200 },
          data: {
            type: nodeType,
            node: {
              template: getLangflowTemplate(tool)
            }
          }
        },
        {
          id: "output-3",
          type: "ChatOutput",
          position: { x: 700, y: 200 },
          data: {
            type: "ChatOutput",
            node: {
              template: {
                input_value: {
                  type: "Message"
                }
              }
            }
          }
        }
      ],
      edges: [
        {
          id: "edge-1-2",
          source: "input-1",
          target: `${toolSlug}-2`,
          sourceHandle: "output",
          targetHandle: "input"
        },
        {
          id: "edge-2-3",
          source: `${toolSlug}-2`,
          target: "output-3",
          sourceHandle: "output",
          targetHandle: "input"
        }
      ]
    },
    viewport: { x: 0, y: 0, zoom: 1 }
  };
};

const generateZapierGuide = (tool: Tool): any => {
  const toolSlug = tool.id;

  return {
    template_url: `https://zapier.com/apps/${toolSlug}/integrations`,
    zap_structure: {
      trigger: getZapierTrigger(tool),
      actions: getZapierActions(tool)
    },
    setup_guide_zh: [
      `1. 點擊「Use this Zap」按鈕開啟 ${tool.name_zh} 範本`,
      `2. 連接您的 ${tool.name_zh} 帳號並授權存取`,
      `3. 設定觸發條件：選擇何時啟動自動化流程`,
      `4. 映射欄位：將來源資料對應到目標欄位`,
      `5. 測試工作流程確保正常運作`,
      `6. 啟用 Zap 開始自動化`
    ],
    setup_guide_en: [
      `1. Click 'Use this Zap' to open the ${tool.name_en} template`,
      `2. Connect your ${tool.name_en} account and authorize access`,
      `3. Configure trigger: Select when to start the automation`,
      `4. Map fields: Connect source data to target fields`,
      `5. Test the workflow to ensure it works correctly`,
      `6. Activate the Zap to start automation`
    ],
    common_triggers: getCommonTriggers(tool),
    common_actions: getCommonActions(tool)
  };
};

const getN8NNodeType = (tool: Tool): string => {
  const nodeTypeMap: Record<string, string> = {
    'openai': 'n8n-nodes-base.openAi',
    'anthropic': 'n8n-nodes-base.anthropic',
    'n8n': 'n8n-nodes-base.httpRequest',
    'supabase': 'n8n-nodes-base.supabase',
    'airtable': 'n8n-nodes-base.airtable',
    'notion': 'n8n-nodes-base.notion',
    'zapier': 'n8n-nodes-base.httpRequest',
    'make': 'n8n-nodes-base.httpRequest',
    'slack': 'n8n-nodes-base.slack',
    'gmail': 'n8n-nodes-base.gmail',
    'google-sheets': 'n8n-nodes-base.googleSheets'
  };
  return nodeTypeMap[tool.id] || 'n8n-nodes-base.httpRequest';
};

const getN8NParameters = (tool: Tool): any => {
  if (tool.category_zh === 'AI/LLM') {
    return {
      resource: "text",
      operation: "complete",
      model: "gpt-4",
      prompt: "={{ $json.input_data }}",
      temperature: 0.7,
      maxTokens: 1000
    };
  } else if (tool.category_zh === '資料庫' || tool.id === 'supabase') {
    return {
      operation: "select",
      table: "your_table_name",
      returnAll: true
    };
  } else if (tool.id === 'notion') {
    return {
      resource: "page",
      operation: "create",
      pageId: "={{ $json.parent_page_id }}",
      title: "={{ $json.title }}"
    };
  } else if (tool.id === 'airtable') {
    return {
      operation: "create",
      application: "YOUR_BASE_ID",
      table: "YOUR_TABLE_NAME",
      options: {}
    };
  }
  return {
    method: "POST",
    url: `https://api.${tool.id}.com/v1/action`,
    authentication: "predefinedCredentialType",
    body: "={{ $json.input_data }}"
  };
};

const getN8NCredentials = (tool: Tool): any => {
  const credMap: Record<string, any> = {
    'openai': { "openAiApi": { "id": "REPLACE_WITH_YOUR_CREDENTIAL_ID", "name": "OpenAI Account" }},
    'anthropic': { "anthropicApi": { "id": "REPLACE_WITH_YOUR_CREDENTIAL_ID", "name": "Anthropic Account" }},
    'supabase': { "supabaseApi": { "id": "REPLACE_WITH_YOUR_CREDENTIAL_ID", "name": "Supabase Account" }},
    'airtable': { "airtableApi": { "id": "REPLACE_WITH_YOUR_CREDENTIAL_ID", "name": "Airtable Account" }},
    'notion': { "notionApi": { "id": "REPLACE_WITH_YOUR_CREDENTIAL_ID", "name": "Notion Account" }}
  };
  return credMap[tool.id] || { "httpBasicAuth": { "id": "REPLACE_WITH_YOUR_CREDENTIAL_ID", "name": `${tool.name_en} Account` }};
};

const getLangflowNodeType = (tool: Tool): string => {
  const nodeTypeMap: Record<string, string> = {
    'openai': 'OpenAI',
    'anthropic': 'ChatAnthropic',
    'google-gemini': 'ChatGoogleGenerativeAI',
    'cohere': 'Cohere',
    'huggingface': 'HuggingFaceEndpoint',
    'ollama': 'ChatOllama'
  };
  return nodeTypeMap[tool.id] || 'HTTPRequest';
};

const getLangflowTemplate = (tool: Tool): any => {
  if (tool.category_zh === 'AI/LLM') {
    return {
      api_key: {
        type: "str",
        required: true,
        password: true,
        value: "",
        display_name: "API Key"
      },
      model_name: {
        type: "str",
        value: tool.id === 'openai' ? "gpt-4" : tool.id === 'anthropic' ? "claude-3-opus-20240229" : "default",
        display_name: "Model Name"
      },
      temperature: {
        type: "float",
        value: 0.7,
        display_name: "Temperature"
      },
      max_tokens: {
        type: "int",
        value: 1000,
        display_name: "Max Tokens"
      }
    };
  }
  return {
    url: {
      type: "str",
      required: true,
      value: `https://api.${tool.id}.com`,
      display_name: "API URL"
    },
    method: {
      type: "str",
      value: "POST",
      display_name: "Method"
    }
  };
};

const getZapierTrigger = (tool: Tool): any => {
  const triggers: Record<string, any> = {
    'airtable': {
      app: "Airtable",
      event: "New Record",
      description: "當 Airtable 表格中新增記錄時觸發",
      required_fields: ["base", "table"]
    },
    'notion': {
      app: "Notion",
      event: "New Database Item",
      description: "當 Notion 資料庫中新增項目時觸發",
      required_fields: ["database_id"]
    },
    'gmail': {
      app: "Gmail",
      event: "New Email",
      description: "當收到新郵件時觸發",
      required_fields: ["label"]
    }
  };
  return triggers[tool.id] || {
    app: tool.name_en,
    event: "New Event",
    description: `當 ${tool.name_zh} 有新事件時觸發`,
    required_fields: ["event_type"]
  };
};

const getZapierActions = (tool: Tool): any[] => {
  const actions: Record<string, any[]> = {
    'openai': [
      {
        app: "OpenAI",
        event: "Generate Text",
        description: "使用 GPT 模型生成文字",
        field_mapping: {
          prompt: "trigger.message",
          model: "gpt-4"
        }
      }
    ],
    'airtable': [
      {
        app: "Airtable",
        event: "Create Record",
        description: "在 Airtable 表格中建立新記錄",
        field_mapping: {
          base: "trigger.base",
          table: "trigger.table",
          fields: "trigger.data"
        }
      }
    ],
    'notion': [
      {
        app: "Notion",
        event: "Create Database Item",
        description: "在 Notion 資料庫中建立新項目",
        field_mapping: {
          database_id: "trigger.database_id",
          properties: "trigger.properties"
        }
      }
    ]
  };
  return actions[tool.id] || [
    {
      app: tool.name_en,
      event: "Create Item",
      description: `在 ${tool.name_zh} 中建立新項目`,
      field_mapping: {
        data: "trigger.data"
      }
    }
  ];
};

const getCommonTriggers = (tool: Tool): string[] => {
  const triggers: Record<string, string[]> = {
    'openai': ["API Request", "Scheduled Generation"],
    'airtable': ["New Record", "Updated Record", "New Record in View"],
    'notion': ["New Database Item", "Updated Database Item", "New Page"],
    'gmail': ["New Email", "New Label", "New Attachment"],
    'slack': ["New Message", "New Channel", "Reaction Added"],
    'supabase': ["New Row", "Updated Row", "Deleted Row"]
  };
  return triggers[tool.id] || ["New Item", "Updated Item"];
};

const getCommonActions = (tool: Tool): string[] => {
  const actions: Record<string, string[]> = {
    'openai': ["Generate Text", "Create Embedding", "Generate Image"],
    'airtable': ["Create Record", "Update Record", "Find Record"],
    'notion': ["Create Page", "Update Database Item", "Add Comment"],
    'gmail': ["Send Email", "Create Draft", "Add Label"],
    'slack': ["Send Message", "Create Channel", "Update Message"],
    'supabase': ["Insert Row", "Update Row", "Delete Row", "Run Query"]
  };
  return actions[tool.id] || ["Create Item", "Update Item", "Delete Item"];
};

// Main execution
const topTools = [
  'openai',
  'anthropic',
  'google-gemini',
  'n8n',
  'zapier',
  'make',
  'supabase',
  'airtable',
  'notion',
  'flowise',
  'langflow',
  'dify',
  'webflow',
  'bubble',
  'figma',
  'midjourney',
  'salesforce',
  'monday',
  'pipedream',
  'huggingface'
];

const csvPath = path.join(__dirname, 'data', 'tools.csv');
const outputPath = path.join(__dirname, 'data', 'export_templates.json');

try {
  const csvContent = fs.readFileSync(csvPath, 'utf-8');
  const lines = csvContent.split('\n').filter(line => line.trim());

  const tools: Tool[] = lines.slice(1).map(line => {
    const values = line.split(',');
    return {
      id: values[0],
      name_zh: values[1],
      name_en: values[2],
      category_zh: values[3]
    };
  });

  console.log(`Loaded ${tools.length} tools from CSV`);

  const templates: ExportTemplate[] = [];

  for (const toolId of topTools) {
    const tool = tools.find(t => t.id === toolId);
    if (!tool) {
      console.warn(`Tool ${toolId} not found`);
      continue;
    }

    console.log(`Generating templates for ${tool.name_en}...`);

    templates.push({
      tool_id: tool.id,
      tool_name: tool.name_en,
      platform: 'n8n',
      format: 'json',
      payload: generateN8NTemplate(tool),
      version: 'v1.0'
    });

    templates.push({
      tool_id: tool.id,
      tool_name: tool.name_en,
      platform: 'langflow',
      format: 'json',
      payload: generateLangflowTemplate(tool),
      version: 'v1.0'
    });

    templates.push({
      tool_id: tool.id,
      tool_name: tool.name_en,
      platform: 'zapier',
      format: 'guide',
      payload: generateZapierGuide(tool),
      version: 'v1.0'
    });
  }

  console.log(`Generated ${templates.length} export templates`);

  fs.writeFileSync(outputPath, JSON.stringify(templates, null, 2));
  console.log(`Saved to ${outputPath}`);

} catch (error) {
  console.error('Error generating export templates:', error);
  process.exit(1);
}
