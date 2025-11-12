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
  }
};
