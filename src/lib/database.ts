import { supabase } from './supabase';
import type { Tool, CategoryMetadata, ToolPairing, FeaturedStack, UserInteraction, ToolTranslation } from '../types';

export const db = {
  async getTools(filters?: {
    search?: string;
    toolNames?: string[];
    purpose?: string[];
    functional_role?: string[];
    tech_layer?: string[];
    data_flow_role?: string[];
    difficulty?: string[];
    application_field?: string[];
  }): Promise<Tool[]> {
    let query = supabase
      .from('tools')
      .select('*')
      .order('popularity_score', { ascending: false })
      .order('display_priority', { ascending: false });

    if (filters?.toolNames && filters.toolNames.length > 0) {
      const toolNameConditions = filters.toolNames
        .map(name => `(tool_name.eq.${name},source_slug.eq.${name})`)
        .join(',');
      query = query.or(toolNameConditions);
    } else if (filters?.search) {
      query = query.or(`tool_name.ilike.%${filters.search}%,summary.ilike.%${filters.search}%`);
    }

    const { data, error } = await query;

    if (error) throw error;

    let results = data || [];

    if (filters) {
      results = results.filter(tool => {
        const categories = tool.categories as any;

        if (filters.purpose?.length && !filters.purpose.some(p => categories?.purpose?.includes(p))) {
          return false;
        }
        if (filters.functional_role?.length && !filters.functional_role.some(fr => categories?.functional_role?.includes(fr))) {
          return false;
        }
        if (filters.tech_layer?.length && !filters.tech_layer.some(tl => categories?.tech_layer?.includes(tl))) {
          return false;
        }
        if (filters.data_flow_role?.length && !filters.data_flow_role.some(dfr => categories?.data_flow_role?.includes(dfr))) {
          return false;
        }
        if (filters.difficulty?.length && !filters.difficulty.includes(categories?.difficulty)) {
          return false;
        }
        if (filters.application_field?.length && !filters.application_field.some(af => categories?.application_field?.includes(af))) {
          return false;
        }

        return true;
      });
    }

    return results.map(tool => ({
      ...tool,
      categories: tool.categories || {
        functional_role: [],
        tech_layer: [],
        difficulty: null,
        purpose: [],
        data_flow_role: [],
        application_field: [],
        common_pairings: []
      }
    })) as Tool[];
  },

  async getToolByName(toolName: string): Promise<Tool | null> {
    const { data, error } = await supabase
      .from('tools')
      .select('*')
      .eq('tool_name', toolName)
      .maybeSingle();

    if (error) throw error;
    return data as Tool | null;
  },

  async getToolById(id: string): Promise<Tool | null> {
    const { data, error } = await supabase
      .from('tools')
      .select('*')
      .eq('id', id)
      .maybeSingle();

    if (error) throw error;
    return data as Tool | null;
  },

  async createTool(tool: Omit<Tool, 'id' | 'created_at' | 'updated_at'>): Promise<Tool> {
    const { data, error } = await supabase
      .from('tools')
      .insert([tool])
      .select()
      .single();

    if (error) throw error;
    return data as Tool;
  },

  async updateTool(id: string, updates: Partial<Tool>): Promise<Tool> {
    const { data, error } = await supabase
      .from('tools')
      .update(updates)
      .eq('id', id)
      .select()
      .single();

    if (error) throw error;
    return data as Tool;
  },

  async getCategoryMetadata(language: string = 'en'): Promise<CategoryMetadata[]> {
    const { data, error } = await supabase
      .from('category_metadata')
      .select(`
        *,
        category_metadata_translations!inner(
          language_code,
          translated_value
        )
      `)
      .order('category_type')
      .order('display_order');

    if (error) throw error;

    return (data || []).map((item: any) => {
      const translation = item.category_metadata_translations?.find(
        (t: any) => t.language_code === language
      );
      return {
        id: item.id,
        category_type: item.category_type,
        category_value: item.category_value,
        color_hex: item.color_hex,
        icon_name: item.icon_name,
        description: item.description,
        display_order: item.display_order,
        translated_value: translation?.translated_value || item.category_value
      };
    });
  },

  async getToolPairings(toolId: string): Promise<ToolPairing[]> {
    const { data, error } = await supabase
      .from('tool_pairings')
      .select('*')
      .or(`tool_id_1.eq.${toolId},tool_id_2.eq.${toolId}`)
      .order('strength', { ascending: false });

    if (error) throw error;
    return data as ToolPairing[];
  },

  async getFeaturedStacks(): Promise<FeaturedStack[]> {
    const { data, error } = await supabase
      .from('featured_stacks')
      .select('*')
      .order('display_order');

    if (error) throw error;
    return data as FeaturedStack[];
  },

  async trackInteraction(interaction: Omit<UserInteraction, 'id' | 'created_at'>): Promise<void> {
    const { error } = await supabase
      .from('user_interactions')
      .insert([interaction]);

    if (error) throw error;

    await this.updatePopularityScore(interaction.tool_id);
  },

  async updatePopularityScore(toolId: string): Promise<void> {
    const { data: interactions } = await supabase
      .from('user_interactions')
      .select('interaction_type')
      .eq('tool_id', toolId);

    if (!interactions) return;

    const weights = { view: 1, favorite: 3, generate: 5 };
    const score = interactions.reduce((sum, i) => sum + (weights[i.interaction_type as keyof typeof weights] || 0), 0);

    await supabase
      .from('tools')
      .update({ popularity_score: score })
      .eq('id', toolId);
  },

  async searchTools(query: string): Promise<Tool[]> {
    return this.getTools({ search: query });
  },

  async getToolTranslation(toolId: string, language: string): Promise<ToolTranslation | null> {
    const { data, error } = await supabase
      .from('tool_translations')
      .select('*')
      .eq('tool_id', toolId)
      .eq('language_code', language)
      .maybeSingle();

    if (error) throw error;
    return data as ToolTranslation | null;
  },

  async getToolsWithTranslations(language: string = 'en', filters?: {
    search?: string;
    toolNames?: string[];
    purpose?: string[];
    functional_role?: string[];
    tech_layer?: string[];
    data_flow_role?: string[];
    difficulty?: string[];
    application_field?: string[];
  }): Promise<Tool[]> {
    const tools = await this.getTools(filters);

    if (language === 'en') {
      return tools;
    }

    const toolsWithTranslations = await Promise.all(
      tools.map(async (tool) => {
        const translation = await this.getToolTranslation(tool.id!, language);
        if (translation) {
          return {
            ...tool,
            summary: translation.summary,
            description_styles: translation.description_styles
          };
        }
        return tool;
      })
    );

    return toolsWithTranslations;
  },

  async getPopularTools(limit: number = 20, language: string = 'en'): Promise<Tool[]> {
    const { data, error } = await supabase
      .from('tools')
      .select('*')
      .order('popularity_score', { ascending: false })
      .order('display_priority', { ascending: false })
      .limit(limit);

    if (error) throw error;

    const tools = data as Tool[];

    if (language === 'en') {
      return tools;
    }

    const toolsWithTranslations = await Promise.all(
      tools.map(async (tool) => {
        const translation = await this.getToolTranslation(tool.id!, language);
        if (translation) {
          return {
            ...tool,
            summary: translation.summary,
            description_styles: translation.description_styles
          };
        }
        return tool;
      })
    );

    return toolsWithTranslations;
  },

  async getFeaturedStacksWithTools(language: string = 'en'): Promise<Array<FeaturedStack & { tools: Tool[] }>> {
    const stacks = await this.getFeaturedStacks();

    const stacksWithTools = await Promise.all(
      stacks.map(async (stack) => {
        const toolIds = stack.tool_ids as unknown as string[];

        const tools = await Promise.all(
          toolIds.map(async (toolId) => {
            const tool = await this.getToolById(toolId);
            if (!tool) return null;

            if (language === 'en') return tool;

            const translation = await this.getToolTranslation(toolId, language);
            if (translation) {
              return {
                ...tool,
                summary: translation.summary,
                description_styles: translation.description_styles
              };
            }
            return tool;
          })
        );

        return {
          ...stack,
          tools: tools.filter((t): t is Tool => t !== null)
        };
      })
    );

    return stacksWithTools;
  },

  async trackView(toolId: string, sessionId: string): Promise<void> {
    await this.trackInteraction({
      tool_id: toolId,
      interaction_type: 'view',
      session_id: sessionId
    });
  },

  async trackFavoriteAction(toolId: string, sessionId: string): Promise<void> {
    await this.trackInteraction({
      tool_id: toolId,
      interaction_type: 'favorite',
      session_id: sessionId
    });
  },

  async trackGenerate(toolId: string, sessionId: string): Promise<void> {
    await this.trackInteraction({
      tool_id: toolId,
      interaction_type: 'generate',
      session_id: sessionId
    });
  },

  // ============================================================================
  // PERSONA-DRIVEN LEARNING PLATFORM QUERIES
  // ============================================================================

  async getPersonas(language: string = 'en'): Promise<import('../types').Persona[]> {
    const { data, error } = await supabase
      .from('personas')
      .select('*')
      .order('display_order');

    if (error) throw error;
    return data as import('../types').Persona[];
  },

  async getPersonaByKey(personaKey: string, language: string = 'en'): Promise<import('../types').Persona | null> {
    const { data, error } = await supabase
      .from('personas')
      .select('*')
      .eq('persona_key', personaKey)
      .maybeSingle();

    if (error) throw error;
    return data as import('../types').Persona | null;
  },

  async getPersonaWithGoals(personaId: string, language: string = 'en'): Promise<import('../types').PersonaWithGoals | null> {
    const { data: persona, error: personaError } = await supabase
      .from('personas')
      .select('*')
      .eq('id', personaId)
      .maybeSingle();

    if (personaError) throw personaError;
    if (!persona) return null;

    const { data: personaGoals, error: goalsError } = await supabase
      .from('persona_goals')
      .select(`
        goal_id,
        display_order,
        goals (*)
      `)
      .eq('persona_id', personaId)
      .order('display_order');

    if (goalsError) throw goalsError;

    return {
      ...persona,
      goals: personaGoals?.map((pg: any) => pg.goals) || []
    } as import('../types').PersonaWithGoals;
  },

  async getGoals(language: string = 'en'): Promise<import('../types').Goal[]> {
    const { data, error } = await supabase
      .from('goals')
      .select('*')
      .order('display_order');

    if (error) throw error;
    return data as import('../types').Goal[];
  },

  async getGoalByKey(goalKey: string, language: string = 'en'): Promise<import('../types').Goal | null> {
    const { data, error } = await supabase
      .from('goals')
      .select('*')
      .eq('goal_key', goalKey)
      .maybeSingle();

    if (error) throw error;
    return data as import('../types').Goal | null;
  },

  async getGoalWithDetails(goalId: string, language: string = 'en'): Promise<import('../types').GoalWithDetails | null> {
    const { data: goal, error: goalError } = await supabase
      .from('goals')
      .select('*')
      .eq('id', goalId)
      .maybeSingle();

    if (goalError) throw goalError;
    if (!goal) return null;

    const { data: goalStacks, error: stacksError } = await supabase
      .from('goal_stacks')
      .select(`
        stack_id,
        implementation_type,
        display_order,
        tool_stacks (*)
      `)
      .eq('goal_id', goalId)
      .order('display_order');

    if (stacksError) throw stacksError;

    const { data: goalInspirations, error: inspirationsError } = await supabase
      .from('goal_inspirations')
      .select(`
        inspiration_id,
        display_order,
        inspirations (*)
      `)
      .eq('goal_id', goalId)
      .order('display_order');

    if (inspirationsError) throw inspirationsError;

    const { data: personaGoals, error: personasError } = await supabase
      .from('persona_goals')
      .select(`
        persona_id,
        personas (*)
      `)
      .eq('goal_id', goalId);

    if (personasError) throw personasError;

    return {
      ...goal,
      stacks: goalStacks?.map((gs: any) => gs.tool_stacks) || [],
      inspirations: goalInspirations?.map((gi: any) => gi.inspirations) || [],
      personas: personaGoals?.map((pg: any) => pg.personas) || []
    } as import('../types').GoalWithDetails;
  },

  async getToolStacks(language: string = 'en'): Promise<import('../types').ToolStack[]> {
    const { data, error } = await supabase
      .from('tool_stacks')
      .select('*')
      .order('difficulty');

    if (error) throw error;
    return data as import('../types').ToolStack[];
  },

  async getToolStackByKey(stackKey: string, language: string = 'en'): Promise<import('../types').ToolStack | null> {
    const { data, error } = await supabase
      .from('tool_stacks')
      .select('*')
      .eq('stack_key', stackKey)
      .maybeSingle();

    if (error) throw error;
    return data as import('../types').ToolStack | null;
  },

  async getToolStackWithTools(stackId: string, language: string = 'en'): Promise<import('../types').ToolStackWithTools | null> {
    const { data: stack, error: stackError } = await supabase
      .from('tool_stacks')
      .select('*')
      .eq('id', stackId)
      .maybeSingle();

    if (stackError) throw stackError;
    if (!stack) return null;

    const toolIds = stack.tool_ids as unknown as string[];
    const tools = await Promise.all(
      toolIds.map(async (toolId) => {
        const tool = await this.getToolById(toolId);
        if (!tool) return null;

        if (language === 'en') return tool;

        const translation = await this.getToolTranslation(toolId, language);
        if (translation) {
          return {
            ...tool,
            summary: translation.summary,
            description_styles: translation.description_styles
          };
        }
        return tool;
      })
    );

    return {
      ...stack,
      tools: tools.filter((t): t is Tool => t !== null)
    } as import('../types').ToolStackWithTools;
  },

  async getInspirations(language: string = 'en'): Promise<import('../types').Inspiration[]> {
    const { data, error } = await supabase
      .from('inspirations')
      .select('*')
      .order('display_order');

    if (error) throw error;
    return data as import('../types').Inspiration[];
  },

  async getInspirationByKey(inspirationKey: string, language: string = 'en'): Promise<import('../types').Inspiration | null> {
    const { data, error } = await supabase
      .from('inspirations')
      .select('*')
      .eq('inspiration_key', inspirationKey)
      .maybeSingle();

    if (error) throw error;
    return data as import('../types').Inspiration | null;
  },

  async getInspirationWithDetails(inspirationId: string, language: string = 'en'): Promise<import('../types').InspirationWithDetails | null> {
    const { data: inspiration, error: inspirationError } = await supabase
      .from('inspirations')
      .select('*')
      .eq('id', inspirationId)
      .maybeSingle();

    if (inspirationError) throw inspirationError;
    if (!inspiration) return null;

    let stack = null;
    let tools: Tool[] = [];

    if (inspiration.stack_id) {
      const stackWithTools = await this.getToolStackWithTools(inspiration.stack_id, language);
      if (stackWithTools) {
        stack = stackWithTools;
        tools = stackWithTools.tools || [];
      }
    }

    return {
      ...inspiration,
      stack,
      tools
    } as import('../types').InspirationWithDetails;
  },

  async getGoalsByPersona(personaKey: string, language: string = 'en'): Promise<import('../types').Goal[]> {
    const persona = await this.getPersonaByKey(personaKey, language);
    if (!persona) return [];

    const { data, error } = await supabase
      .from('persona_goals')
      .select(`
        goal_id,
        display_order,
        goals (*)
      `)
      .eq('persona_id', persona.id)
      .order('display_order');

    if (error) throw error;
    return data?.map((pg: any) => pg.goals) || [];
  },

  async getInspirationsByGoal(goalKey: string, language: string = 'en'): Promise<import('../types').Inspiration[]> {
    const goal = await this.getGoalByKey(goalKey, language);
    if (!goal) return [];

    const { data, error } = await supabase
      .from('goal_inspirations')
      .select(`
        inspiration_id,
        display_order,
        inspirations (*)
      `)
      .eq('goal_id', goal.id)
      .order('display_order');

    if (error) throw error;
    return data?.map((gi: any) => gi.inspirations) || [];
  },

  async getStacksByGoal(goalKey: string, language: string = 'en'): Promise<import('../types').ToolStack[]> {
    const goal = await this.getGoalByKey(goalKey, language);
    if (!goal) return [];

    const { data, error } = await supabase
      .from('goal_stacks')
      .select(`
        stack_id,
        implementation_type,
        display_order,
        tool_stacks (*)
      `)
      .eq('goal_id', goal.id)
      .order('display_order');

    if (error) throw error;
    return data?.map((gs: any) => gs.tool_stacks) || [];
  },

  async getFeaturedInspirations(limit: number = 6, language: string = 'en'): Promise<import('../types').Inspiration[]> {
    const { data, error } = await supabase
      .from('inspirations')
      .select('*')
      .order('display_order')
      .limit(limit);

    if (error) throw error;
    return data as import('../types').Inspiration[];
  },

  // ============================================================================
  // CREATIVE USE CASES QUERIES
  // ============================================================================

  async getCreativeUseCases(filters?: {
    difficulty?: string;
    tag?: string;
    search?: string;
  }): Promise<any[]> {
    let query = supabase
      .from('creative_use_cases')
      .select('*')
      .order('display_order');

    if (filters?.difficulty && filters.difficulty !== 'all') {
      query = query.eq('difficulty', filters.difficulty);
    }

    if (filters?.search) {
      query = query.or(`title.ilike.%${filters.search}%,description.ilike.%${filters.search}%,title_en.ilike.%${filters.search}%,description_en.ilike.%${filters.search}%,title_zh_tw.ilike.%${filters.search}%,description_zh_tw.ilike.%${filters.search}%`);
    }

    const { data, error } = await query;

    if (error) throw error;

    let results = data || [];

    if (filters?.tag && filters.tag !== 'all') {
      results = results.filter((useCase: any) =>
        useCase.use_case_tags?.includes(filters.tag)
      );
    }

    return results;
  },

  async getCreativeUseCaseBySlug(slug: string): Promise<any | null> {
    const { data, error } = await supabase
      .from('creative_use_cases')
      .select('*')
      .eq('slug', slug)
      .maybeSingle();

    if (error) throw error;
    return data;
  },

  // ============================================================================
  // EXPORT TEMPLATES QUERIES
  // ============================================================================

  async getExportTemplates(toolId: string): Promise<any[]> {
    const { data, error } = await supabase
      .from('export_templates')
      .select('*')
      .eq('tool_id', toolId)
      .order('platform');

    if (error) throw error;
    return data || [];
  },

  async getExportTemplateByPlatform(toolId: string, platform: string): Promise<any | null> {
    const { data, error } = await supabase
      .from('export_templates')
      .select('*')
      .eq('tool_id', toolId)
      .eq('platform', platform)
      .maybeSingle();

    if (error) throw error;
    return data;
  }
};
