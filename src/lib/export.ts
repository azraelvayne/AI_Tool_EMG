import type { Tool } from '../types';

export const exportUtils = {
  downloadFile(content: string, filename: string, mimeType: string) {
    const blob = new Blob([content], { type: mimeType });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  },

  copyToClipboard(text: string) {
    navigator.clipboard.writeText(text);
  },

  exportJSON(tool: Tool, pretty: boolean = true): string {
    const data = {
      tool_name: tool.tool_name,
      summary: tool.summary,
      categories: tool.categories,
      description_styles: tool.description_styles,
      use_case_templates: tool.use_case_templates
    };

    return pretty ? JSON.stringify(data, null, 2) : JSON.stringify(data);
  },

  exportMultipleJSON(tools: Tool[], pretty: boolean = true): string {
    const data = tools.map(tool => ({
      tool_name: tool.tool_name,
      summary: tool.summary,
      categories: tool.categories,
      description_styles: tool.description_styles,
      use_case_templates: tool.use_case_templates
    }));

    return pretty ? JSON.stringify(data, null, 2) : JSON.stringify(data);
  },

  exportCSV(tools: Tool[]): string {
    const headers = [
      'Tool Name',
      'Summary',
      'Purpose',
      'Functional Roles',
      'Tech Layers',
      'Difficulty',
      'Application Fields',
      'Common Pairings'
    ];

    const rows = tools.map(tool => {
      const categories = tool.categories as any;
      return [
        tool.tool_name,
        tool.summary,
        categories.purpose?.join('; ') || '',
        categories.functional_role?.join('; ') || '',
        categories.tech_layer?.join('; ') || '',
        categories.difficulty || '',
        categories.application_field?.join('; ') || '',
        categories.common_pairings?.join('; ') || ''
      ].map(cell => `"${String(cell).replace(/"/g, '""')}"`);
    });

    return [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
  },

  exportNotionCSV(tools: Tool[]): string {
    const headers = [
      'Name',
      'Summary',
      'Purpose',
      'Functional Role',
      'Tech Layer',
      'Difficulty',
      'Application Field',
      'Common Pairings',
      'Encyclopedia',
      'Guide',
      'Strategy'
    ];

    const rows = tools.map(tool => {
      const categories = tool.categories as any;
      const descriptions = tool.description_styles as any;
      return [
        tool.tool_name,
        tool.summary,
        categories.purpose?.join(', ') || '',
        categories.functional_role?.join(', ') || '',
        categories.tech_layer?.join(', ') || '',
        categories.difficulty || '',
        categories.application_field?.join(', ') || '',
        categories.common_pairings?.join(', ') || '',
        descriptions.encyclopedia || '',
        descriptions.guide || '',
        descriptions.strategy || ''
      ].map(cell => `"${String(cell).replace(/"/g, '""')}"`);
    });

    return [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
  },

  generateClaudePrompt(tool: Tool): string {
    return `You are an AI tool ecosystem expert. Below is information about ${tool.tool_name}:

**Tool Name:** ${tool.tool_name}

**Summary:** ${tool.summary}

**Categories:**
${JSON.stringify(tool.categories, null, 2)}

**Description Styles:**
${JSON.stringify(tool.description_styles, null, 2)}

**Use Case Templates:**
${JSON.stringify(tool.use_case_templates, null, 2)}

Based on this information, help users understand how to best use ${tool.tool_name} in their projects and workflows.`;
  },

  generateUniversalPrompt(): string {
    return `You are an "AI Tool Ecosystem Mapper Generator". Your task is to generate comprehensive tool information in a standardized JSON format.

When a user provides a tool name, output the following JSON structure:

{
  "tool_name": "",
  "summary": "",
  "categories": {
    "purpose": ["Learning Oriented" | "Application Oriented" | "System Oriented"],
    "functional_role": ["Database" | "API" | "Automation" | "Frontend" | "AI Assistant" | "Content Management" | "Collaboration" | "Analytics"],
    "application_field": ["Knowledge Management" | "Automation" | "Content Creation" | "Data Analysis" | "Web Development" | "AI Applications" | "Collaboration"],
    "tech_layer": ["Data Layer" | "Processing Layer" | "Frontend Layer" | "AI Layer" | "Integration Layer"],
    "data_flow_role": ["Input" | "Process" | "Storage" | "Output"],
    "difficulty": "No-code" | "Low-code" | "Code",
    "common_pairings": []
  },
  "description_styles": {
    "encyclopedia": "",
    "guide": "",
    "strategy": "",
    "inspiration": []
  },
  "use_case_templates": [
    {
      "goal": "",
      "method": "",
      "tool_stack": [],
      "steps": []
    }
  ]
}

Provide four description styles:
1. Encyclopedia: One-sentence definition
2. Guide: System positioning and integration guidance
3. Strategy: When to use, ideal scenarios, and pairing recommendations
4. Inspiration: 3 creative application ideas

Ensure all outputs use Traditional Chinese, are concise, logical, and maintain an educational tone.`;
  },

  generateN8NWorkflowPrompt(tool: Tool): string {
    const categories = tool.categories as any;
    return `# n8n Workflow Template for ${tool.tool_name}

## Workflow Description
This workflow integrates ${tool.tool_name} with other services for automation.

## Recommended Nodes
${categories.common_pairings?.map((pairing: string) => `- ${pairing} node`).join('\n') || ''}

## Setup Steps
1. Add ${tool.tool_name} credentials to n8n
2. Create trigger node based on your use case
3. Add ${tool.tool_name} action node
4. Configure data mapping
5. Add error handling
6. Test the workflow

## Example Use Case
${tool.summary}

## Common Pairings
${categories.common_pairings?.join(', ') || 'None'}`;
  },

  generateCanvaMarkdown(tool: Tool): string {
    const categories = tool.categories as any;
    const descriptions = tool.description_styles as any;

    return `# ${tool.tool_name}

## 📋 Overview
${tool.summary}

## 🎯 Quick Facts
- **Difficulty**: ${categories.difficulty}
- **Primary Role**: ${categories.functional_role?.[0] || 'N/A'}
- **Tech Layer**: ${categories.tech_layer?.[0] || 'N/A'}

---

## 📖 What is ${tool.tool_name}?
${descriptions.encyclopedia}

---

## 🗺️ How It Fits in Your Stack
${descriptions.guide}

---

## 💡 When to Use ${tool.tool_name}
${descriptions.strategy}

---

## 🚀 Creative Ideas
${descriptions.inspiration?.map((idea: string, i: number) => `${i + 1}. ${idea}`).join('\n\n') || 'No ideas available'}

---

## 🔗 Works Well With
${categories.common_pairings?.map((tool: string) => `- ${tool}`).join('\n') || 'No common pairings listed'}`;
  },

  generateN8nWorkflow(tool: Tool): string {
    return JSON.stringify({
      name: `${tool.tool_name} Workflow`,
      nodes: [
        {
          parameters: {},
          name: 'Start',
          type: 'n8n-nodes-base.start',
          typeVersion: 1,
          position: [250, 300]
        },
        {
          parameters: {
            values: {
              string: [
                {
                  name: 'tool_name',
                  value: tool.tool_name
                },
                {
                  name: 'summary',
                  value: tool.summary
                }
              ]
            }
          },
          name: 'Set Variables',
          type: 'n8n-nodes-base.set',
          typeVersion: 1,
          position: [450, 300]
        },
        {
          parameters: {
            url: '={{$json.api_endpoint}}',
            authentication: 'genericCredentialType',
            genericAuthType: 'httpHeaderAuth',
            options: {}
          },
          name: `${tool.tool_name} API`,
          type: 'n8n-nodes-base.httpRequest',
          typeVersion: 3,
          position: [650, 300]
        }
      ],
      connections: {
        'Start': {
          main: [[{ node: 'Set Variables', type: 'main', index: 0 }]]
        },
        'Set Variables': {
          main: [[{ node: `${tool.tool_name} API`, type: 'main', index: 0 }]]
        }
      }
    }, null, 2);
  },

  generateLangflowWorkflow(tool: Tool): string {
    return JSON.stringify({
      name: `${tool.tool_name} Flow`,
      description: tool.summary,
      data: {
        nodes: [
          {
            id: 'input-1',
            type: 'ChatInput',
            position: { x: 100, y: 200 },
            data: {
              node: {
                template: {
                  input_value: {
                    value: `Using ${tool.tool_name}`
                  }
                }
              }
            }
          },
          {
            id: 'prompt-1',
            type: 'Prompt',
            position: { x: 400, y: 200 },
            data: {
              node: {
                template: {
                  template: {
                    value: `Process with ${tool.tool_name}: {input}`
                  }
                }
              }
            }
          },
          {
            id: 'llm-1',
            type: 'ChatOpenAI',
            position: { x: 700, y: 200 },
            data: {
              node: {
                template: {
                  model_name: {
                    value: 'gpt-3.5-turbo'
                  }
                }
              }
            }
          },
          {
            id: 'output-1',
            type: 'ChatOutput',
            position: { x: 1000, y: 200 },
            data: {}
          }
        ],
        edges: [
          { id: 'e1', source: 'input-1', target: 'prompt-1' },
          { id: 'e2', source: 'prompt-1', target: 'llm-1' },
          { id: 'e3', source: 'llm-1', target: 'output-1' }
        ]
      }
    }, null, 2);
  },

  generateZapierTemplate(tool: Tool): object {
    const categories = tool.categories as any;
    return {
      title: `${tool.tool_name} Automation`,
      description: tool.summary,
      template_url: `https://zapier.com/apps/${tool.tool_name.toLowerCase().replace(/\s+/g, '-')}/integrations`,
      steps: [
        {
          step: 1,
          type: 'Trigger',
          app: tool.tool_name,
          description: `When a new event occurs in ${tool.tool_name}`,
          setup: [
            `Connect your ${tool.tool_name} account`,
            'Select trigger event type',
            'Configure trigger filters'
          ]
        },
        {
          step: 2,
          type: 'Action',
          app: categories.common_pairings?.[0] || 'Your App',
          description: 'Perform an action with the triggered data',
          setup: [
            'Connect your destination app',
            'Choose action type',
            'Map fields from trigger data'
          ]
        },
        {
          step: 3,
          type: 'Test',
          description: 'Test your Zap to ensure it works correctly',
          setup: [
            'Run test with sample data',
            'Verify output in destination app',
            'Turn on your Zap'
          ]
        }
      ],
      common_pairings: categories.common_pairings || [],
      tips: [
        'Use filters to process only relevant data',
        'Add delays if API rate limits are a concern',
        'Set up error notifications for failed Zaps'
      ]
    };
  },

  validateWorkflowJSON(json: string, platform: 'n8n' | 'langflow'): { valid: boolean; error?: string } {
    try {
      const parsed = JSON.parse(json);

      if (platform === 'n8n') {
        if (!parsed.nodes || !Array.isArray(parsed.nodes)) {
          return { valid: false, error: 'Missing or invalid nodes array' };
        }
        if (!parsed.connections || typeof parsed.connections !== 'object') {
          return { valid: false, error: 'Missing or invalid connections object' };
        }
      } else if (platform === 'langflow') {
        if (!parsed.data || !parsed.data.nodes || !Array.isArray(parsed.data.nodes)) {
          return { valid: false, error: 'Missing or invalid nodes array' };
        }
        if (!parsed.data.edges || !Array.isArray(parsed.data.edges)) {
          return { valid: false, error: 'Missing or invalid edges array' };
        }
      }

      return { valid: true };
    } catch (error) {
      return { valid: false, error: 'Invalid JSON format' };
    }
  }
};
