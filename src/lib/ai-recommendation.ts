import type { Tool } from '../types';

interface RecommendationInput {
  query: string;
  userLevel?: 'beginner' | 'intermediate' | 'advanced';
  preferredCategories?: string[];
}

interface ToolWithScore extends Tool {
  score: number;
  matchReason: string;
}

interface RecommendationResult {
  stacks: {
    name: string;
    tools: Tool[];
    strategy: string;
    score: number;
  }[];
}

const WEIGHTS = {
  application_field: 4,
  functional_role: 3,
  tech_layer: 2,
  difficulty: 1,
};

const COMMON_WORKFLOWS = [
  {
    keywords: ['automation', 'workflow', 'automate', 'integration'],
    application_fields: ['Automation', 'Integration'],
    functional_roles: ['Automation', 'Integration'],
    tech_layers: ['Integration Layer', 'Processing Layer'],
    stackName: 'Automation Workflow Stack',
    strategy: 'Build automated workflows with no-code tools and integrations',
  },
  {
    keywords: ['content', 'create', 'writing', 'generate', 'blog', 'article'],
    application_fields: ['Content Creation', 'AI Applications'],
    functional_roles: ['AI Assistant', 'Content Management'],
    tech_layers: ['AI Layer', 'Frontend Layer'],
    stackName: 'AI Content Creation Stack',
    strategy: 'Generate and manage content using AI-powered tools',
  },
  {
    keywords: ['data', 'analyze', 'analytics', 'visualization', 'insights'],
    application_fields: ['Data Analysis', 'Analytics'],
    functional_roles: ['Database', 'Analytics'],
    tech_layers: ['Data Layer', 'Processing Layer'],
    stackName: 'Data Analytics Stack',
    strategy: 'Collect, process, and visualize data for insights',
  },
  {
    keywords: ['knowledge', 'learn', 'organize', 'notes', 'documentation'],
    application_fields: ['Knowledge Management', 'Collaboration'],
    functional_roles: ['Content Management', 'Database'],
    tech_layers: ['Data Layer', 'Frontend Layer'],
    stackName: 'Knowledge Management Stack',
    strategy: 'Organize and manage knowledge effectively',
  },
  {
    keywords: ['website', 'web', 'app', 'frontend', 'ui', 'interface'],
    application_fields: ['Web Development', 'Frontend'],
    functional_roles: ['Frontend', 'Content Management'],
    tech_layers: ['Frontend Layer', 'Integration Layer'],
    stackName: 'Web Development Stack',
    strategy: 'Build modern web applications and interfaces',
  },
  {
    keywords: ['chat', 'chatbot', 'assistant', 'conversational', 'ai'],
    application_fields: ['AI Applications', 'Automation'],
    functional_roles: ['AI Assistant', 'API'],
    tech_layers: ['AI Layer', 'Integration Layer'],
    stackName: 'AI Assistant Stack',
    strategy: 'Create intelligent conversational interfaces',
  },
];

export const aiRecommendation = {
  /**
   * Rule-based recommendation engine (v1.1 - no LLM)
   */
  generateRecommendations(
    query: string,
    allTools: Tool[],
    options: { userLevel?: string } = {}
  ): RecommendationResult {
    const normalizedQuery = query.toLowerCase();

    const matchedWorkflow = COMMON_WORKFLOWS.find((workflow) =>
      workflow.keywords.some((keyword) => normalizedQuery.includes(keyword))
    );

    if (matchedWorkflow) {
      return this.generateWorkflowBasedStacks(matchedWorkflow, allTools, options);
    }

    return this.generateGeneralStacks(allTools, options);
  },

  generateWorkflowBasedStacks(
    workflow: typeof COMMON_WORKFLOWS[0],
    allTools: Tool[],
    options: { userLevel?: string }
  ): RecommendationResult {
    const scoredTools = allTools.map((tool) => {
      const categories = tool.categories as any;
      let score = 0;
      let matchReasons: string[] = [];

      if (
        categories.application_field?.some((field: string) =>
          workflow.application_fields.includes(field)
        )
      ) {
        score += WEIGHTS.application_field;
        matchReasons.push('Application field match');
      }

      if (
        categories.functional_role?.some((role: string) =>
          workflow.functional_roles.includes(role)
        )
      ) {
        score += WEIGHTS.functional_role;
        matchReasons.push('Functional role match');
      }

      if (
        categories.tech_layer?.some((layer: string) =>
          workflow.tech_layers.includes(layer)
        )
      ) {
        score += WEIGHTS.tech_layer;
        matchReasons.push('Tech layer match');
      }

      if (options.userLevel && categories.difficulty) {
        const difficultyMatch = this.matchDifficulty(
          categories.difficulty,
          options.userLevel
        );
        if (difficultyMatch) {
          score += WEIGHTS.difficulty;
          matchReasons.push('Difficulty level match');
        }
      }

      return {
        ...tool,
        score,
        matchReason: matchReasons.join(', ') || 'General match',
      } as ToolWithScore;
    });

    const topTools = scoredTools
      .filter((t) => t.score > 0)
      .sort((a, b) => b.score - a.score)
      .slice(0, 15);

    const stack1 = topTools.slice(0, 5);
    const stack2 = topTools.slice(5, 10);
    const stack3 = topTools.slice(10, 15);

    return {
      stacks: [
        {
          name: `${workflow.stackName} (Recommended)`,
          tools: stack1,
          strategy: workflow.strategy,
          score: stack1.reduce((sum, t) => sum + t.score, 0) / stack1.length,
        },
        {
          name: `${workflow.stackName} (Alternative 1)`,
          tools: stack2.length > 0 ? stack2 : stack1,
          strategy: `Alternative approach: ${workflow.strategy}`,
          score: stack2.length > 0
            ? stack2.reduce((sum, t) => sum + t.score, 0) / stack2.length
            : 0,
        },
        {
          name: `${workflow.stackName} (Alternative 2)`,
          tools: stack3.length > 0 ? stack3 : stack1,
          strategy: `Extended approach: ${workflow.strategy}`,
          score: stack3.length > 0
            ? stack3.reduce((sum, t) => sum + t.score, 0) / stack3.length
            : 0,
        },
      ].filter((stack) => stack.tools.length > 0),
    };
  },

  generateGeneralStacks(
    allTools: Tool[],
    options: { userLevel?: string }
  ): RecommendationResult {
    const categorizedTools = this.categorizeTools(allTools);

    const stacks = [
      {
        name: 'Beginner-Friendly Stack',
        tools: categorizedTools.beginner.slice(0, 5),
        strategy: 'Start with no-code tools that are easy to learn and use',
        score: 8,
      },
      {
        name: 'Intermediate Stack',
        tools: categorizedTools.intermediate.slice(0, 5),
        strategy: 'Combine low-code tools for more advanced workflows',
        score: 7,
      },
      {
        name: 'Advanced Stack',
        tools: categorizedTools.advanced.slice(0, 5),
        strategy: 'Leverage code-based tools for maximum flexibility',
        score: 6,
      },
    ];

    return {
      stacks: stacks.filter((stack) => stack.tools.length > 0),
    };
  },

  categorizeTools(tools: Tool[]): {
    beginner: Tool[];
    intermediate: Tool[];
    advanced: Tool[];
  } {
    const result = {
      beginner: [] as Tool[],
      intermediate: [] as Tool[],
      advanced: [] as Tool[],
    };

    tools.forEach((tool) => {
      const categories = tool.categories as any;
      const difficulty = categories.difficulty?.toLowerCase() || '';

      if (difficulty.includes('no-code') || difficulty.includes('beginner')) {
        result.beginner.push(tool);
      } else if (difficulty.includes('low-code') || difficulty.includes('intermediate')) {
        result.intermediate.push(tool);
      } else {
        result.advanced.push(tool);
      }
    });

    return result;
  },

  matchDifficulty(toolDifficulty: string, userLevel: string): boolean {
    const normalized = toolDifficulty.toLowerCase();
    const level = userLevel.toLowerCase();

    if (level === 'beginner') {
      return normalized.includes('no-code') || normalized.includes('beginner');
    } else if (level === 'intermediate') {
      return normalized.includes('low-code') || normalized.includes('intermediate');
    } else {
      return normalized.includes('code') && !normalized.includes('no-code');
    }
  },

  /**
   * Feature flag check for LLM integration (v1.2+)
   */
  isLLMEnabled(): boolean {
    return false; // Will be enabled in v1.2
  },

  /**
   * Placeholder for future LLM integration
   */
  async generateLLMRecommendations(
    query: string,
    context: any
  ): Promise<RecommendationResult> {
    throw new Error('LLM recommendations not yet implemented (coming in v1.2)');
  },
};
