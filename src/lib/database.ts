import { supabase } from './supabase';
import type { Tool, CategoryMetadata, ToolPairing, FeaturedStack, UserInteraction, ToolTranslation } from '../types';

export const db = {
  // ============================================================================
  // CORE TOOL QUERIES (with strict data protection)
  // ============================================================================

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
    try {
      let query = supabase
        .from('tools')
        .select('*')
        .order('popularity_score', { ascending: false })
        .order('display_priority', { ascending: false });

      if (filters?.toolNames && filters.toolNames.length > 0) {
        query = query.in('tool_name', filters.toolNames);
      } else if (filters?.search) {
        query = query.or(`tool_name.ilike.%${filters.search}%,summary.ilike.%${filters.search}%`);
      }

      const { data, error } = await query;

      if (error) {
        console.error('[database.ts] Supabase query error in getTools:', error);
        throw new Error(`Database query failed: ${error.message}`);
      }

      let results = data || [];

      if (filters) {
        results = results.filter(tool => {
          const safeCategories = {
            purpose: tool.categories?.purpose || [],
            functional_role: tool.categories?.functional_role || [],
            tech_layer: tool.categories?.tech_layer || [],
            data_flow_role: tool.categories?.data_flow_role || [],
            difficulty: tool.categories?.difficulty || 'intermediate',
            application_field: tool.categories?.application_field || [],
            common_pairings: tool.categories?.common_pairings || []
          };

          if (filters.purpose?.length && !filters.purpose.some(p => safeCategories.purpose.includes(p))) {
            return false;
          }
          if (filters.functional_role?.length && !filters.functional_role.some(fr => safeCategories.functional_role.includes(fr))) {
            return false;
          }
          if (filters.tech_layer?.length && !filters.tech_layer.some(tl => safeCategories.tech_layer.includes(tl))) {
            return false;
          }
          if (filters.data_flow_role?.length && !filters.data_flow_role.some(dfr => safeCategories.data_flow_role.includes(dfr))) {
            return false;
          }
          if (filters.difficulty?.length && !filters.difficulty.includes(safeCategories.difficulty)) {
            return false;
          }
          if (filters.application_field?.length && !filters.application_field.some(af => safeCategories.application_field.includes(af))) {
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
          difficulty: 'intermediate',
          purpose: [],
          data_flow_role: [],
          application_field: [],
          common_pairings: []
        },
        tool_name: tool.tool_name || 'Unnamed Tool',
        summary: tool.summary || '',
        tool_description: tool.tool_description || '',
        logo_url: tool.logo_url || null,
        website_url: tool.website_url || null
      })) as Tool[];
    } catch (error) {
      console.error('[database.ts] Error in getTools:', error);
      return [];
    }
  },

  async getToolById(id: string): Promise<Tool | null> {
    try {
      const { data, error } = await supabase
        .from('tools')
        .select('*')
        .eq('id', id)
        .maybeSingle();

      if (error) throw error;
      if (!data) return null;

      return {
        ...data,
        categories: data.categories || {
          functional_role: [],
          tech_layer: [],
          difficulty: 'intermediate',
          purpose: [],
          data_flow_role: [],
          application_field: [],
          common_pairings: []
        }
      } as Tool;
    } catch (error) {
      console.error('[database.ts] Error in getToolById:', error);
      return null;
    }
  },

  async getToolByName(toolName: string): Promise<Tool | null> {
    try {
      const { data, error } = await supabase
        .from('tools')
        .select('*')
        .eq('tool_name', toolName)
        .maybeSingle();

      if (error) throw error;
      return data as Tool | null;
    } catch (error) {
      console.error('[database.ts] Error in getToolByName:', error);
      return null;
    }
  },

  // ============================================================================
  // TRANSLATION QUERIES (Batch Query Strategy)
  // ============================================================================

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
    try {
      console.log('[database.ts] getToolsWithTranslations called with language:', language);

      const tools = await this.getTools(filters);

      console.log('[database.ts] Retrieved', tools.length, 'tools from getTools');

      if (language === 'en' || tools.length === 0) {
        return tools;
      }

      const toolIds = tools.map(t => t.id).filter(Boolean);

      const { data: translations } = await supabase
        .from('tool_translations')
        .select('*')
        .eq('language_code', language)
        .in('tool_id', toolIds);

      console.log('[database.ts] Retrieved', translations?.length || 0, 'translations');

      const transMap = new Map(
        (translations || []).map(t => [t.tool_id, t])
      );

      return tools.map(tool => {
        const translation = transMap.get(tool.id!);
        if (translation) {
          return {
            ...tool,
            tool_name: translation.name || tool.tool_name,
            summary: translation.summary || tool.summary,
            tool_description: translation.short_description || tool.tool_description,
            description_styles: translation.description_styles
          };
        }
        return tool;
      });
    } catch (error) {
      console.error('[database.ts] Error in getToolsWithTranslations:', error);
      return this.getTools(filters);
    }
  },

  // ============================================================================
  // CATEGORY METADATA (Separate Query Strategy - NO JOIN)
  // ============================================================================

  async getCategoryMetadata(language: string = 'en'): Promise<CategoryMetadata[]> {
    try {
      console.log('[database.ts] getCategoryMetadata called with language:', language);

      const { data: categories, error } = await supabase
        .from('category_metadata')
        .select('*')
        .order('category_type')
        .order('display_order');

      if (error) throw error;
      if (!categories) return [];

      console.log('[database.ts] Retrieved', categories.length, 'categories');

      if (language === 'en') {
        return categories.map(cat => ({
          ...cat,
          translated_value: cat.category_value
        }));
      }

      const { data: translations } = await supabase
        .from('category_metadata_translations')
        .select('*')
        .eq('language_code', language);

      console.log('[database.ts] Retrieved', translations?.length || 0, 'category translations');

      const transMap = new Map(
        (translations || []).map(t => [t.category_metadata_id, t.translated_value])
      );

      return categories.map(cat => ({
        ...cat,
        translated_value: transMap.get(cat.id) || cat.category_value
      }));
    } catch (error) {
      console.error('[database.ts] Error in getCategoryMetadata:', error);
      return [];
    }
  },

  // ============================================================================
  // POPULAR TOOLS (Optimized with Batch Query)
  // ============================================================================

  async getPopularTools(limit: number = 20, language: string = 'en'): Promise<Tool[]> {
    try {
      const { data, error } = await supabase
        .from('tools')
        .select('*')
        .order('popularity_score', { ascending: false })
        .order('display_priority', { ascending: false })
        .limit(limit);

      if (error) throw error;

      let tools = (data || []).map(tool => ({
        ...tool,
        categories: tool.categories || {
          functional_role: [],
          tech_layer: [],
          difficulty: 'intermediate',
          purpose: [],
          data_flow_role: [],
          application_field: [],
          common_pairings: []
        }
      })) as Tool[];

      if (language === 'en' || tools.length === 0) {
        return tools;
      }

      const toolIds = tools.map(t => t.id).filter(Boolean);
      const { data: translations } = await supabase
        .from('tool_translations')
        .select('*')
        .eq('language_code', language)
        .in('tool_id', toolIds);

      const transMap = new Map(
        (translations || []).map(t => [t.tool_id, t])
      );

      return tools.map(tool => {
        const translation = transMap.get(tool.id!);
        if (translation) {
          return {
            ...tool,
            tool_name: translation.name || tool.tool_name,
            summary: translation.summary || tool.summary,
            tool_description: translation.short_description || tool.tool_description
          };
        }
        return tool;
      });
    } catch (error) {
      console.error('[database.ts] Error in getPopularTools:', error);
      return [];
    }
  },

  // ============================================================================
  // FEATURED STACKS
  // ============================================================================

  async getFeaturedStacks(): Promise<FeaturedStack[]> {
    try {
      const { data, error } = await supabase
        .from('featured_stacks')
        .select('*')
        .order('display_order');

      if (error) throw error;
      return data as FeaturedStack[];
    } catch (error) {
      console.error('[database.ts] Error in getFeaturedStacks:', error);
      return [];
    }
  },

  async getFeaturedStacksWithTools(language: string = 'en'): Promise<Array<FeaturedStack & { tools: Tool[] }>> {
    try {
      const stacks = await this.getFeaturedStacks();

      const stacksWithTools = await Promise.all(
        stacks.map(async (stack) => {
          const toolIds = stack.tool_ids as unknown as string[];

          const { data: toolsData } = await supabase
            .from('tools')
            .select('*')
            .in('id', toolIds);

          let tools = (toolsData || []).map(tool => ({
            ...tool,
            categories: tool.categories || {
              functional_role: [],
              tech_layer: [],
              difficulty: 'intermediate',
              purpose: [],
              data_flow_role: [],
              application_field: [],
              common_pairings: []
            }
          })) as Tool[];

          if (language !== 'en' && tools.length > 0) {
            const { data: translations } = await supabase
              .from('tool_translations')
              .select('*')
              .eq('language_code', language)
              .in('tool_id', toolIds);

            const transMap = new Map(
              (translations || []).map(t => [t.tool_id, t])
            );

            tools = tools.map(tool => {
              const translation = transMap.get(tool.id!);
              if (translation) {
                return {
                  ...tool,
                  tool_name: translation.name || tool.tool_name,
                  summary: translation.summary || tool.summary
                };
              }
              return tool;
            });
          }

          return {
            ...stack,
            tools
          };
        })
      );

      return stacksWithTools;
    } catch (error) {
      console.error('[database.ts] Error in getFeaturedStacksWithTools:', error);
      return [];
    }
  },

  // ============================================================================
  // TOOL PAIRINGS & CRUD OPERATIONS
  // ============================================================================

  async getToolPairings(toolId: string): Promise<ToolPairing[]> {
    try {
      const { data, error } = await supabase
        .from('tool_pairings')
        .select('*')
        .or(`tool_id_1.eq.${toolId},tool_id_2.eq.${toolId}`)
        .order('strength', { ascending: false });

      if (error) throw error;
      return data as ToolPairing[];
    } catch (error) {
      console.error('[database.ts] Error in getToolPairings:', error);
      return [];
    }
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

  // ============================================================================
  // USER INTERACTIONS
  // ============================================================================

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

  async searchTools(query: string): Promise<Tool[]> {
    return this.getTools({ search: query });
  },

  // ============================================================================
  // PERSONA-DRIVEN LEARNING PLATFORM (Separate Query Strategy)
  // ============================================================================

  async getPersonas(language: string = 'en'): Promise<import('../types').Persona[]> {
    try {
      const { data, error } = await supabase
        .from('personas')
        .select('*')
        .order('display_order');

      if (error) throw error;
      return data as import('../types').Persona[];
    } catch (error) {
      console.error('[database.ts] Error in getPersonas:', error);
      return [];
    }
  },

  async getPersonaByKey(personaKey: string, language: string = 'en'): Promise<import('../types').Persona | null> {
    try {
      const { data, error } = await supabase
        .from('personas')
        .select('*')
        .eq('persona_key', personaKey)
        .maybeSingle();

      if (error) throw error;
      return data as import('../types').Persona | null;
    } catch (error) {
      console.error('[database.ts] Error in getPersonaByKey:', error);
      return null;
    }
  },

  async getPersonaWithGoals(personaId: string, language: string = 'en'): Promise<import('../types').PersonaWithGoals | null> {
    try {
      const { data: persona, error: personaError } = await supabase
        .from('personas')
        .select('*')
        .eq('id', personaId)
        .maybeSingle();

      if (personaError) throw personaError;
      if (!persona) return null;

      const { data: personaGoalsData } = await supabase
        .from('persona_goals')
        .select('goal_id, display_order')
        .eq('persona_id', personaId)
        .order('display_order');

      if (!personaGoalsData || personaGoalsData.length === 0) {
        return { ...persona, goals: [] } as import('../types').PersonaWithGoals;
      }

      const goalIds = personaGoalsData.map(pg => pg.goal_id);
      const { data: goals } = await supabase
        .from('goals')
        .select('*')
        .in('id', goalIds);

      return {
        ...persona,
        goals: goals || []
      } as import('../types').PersonaWithGoals;
    } catch (error) {
      console.error('[database.ts] Error in getPersonaWithGoals:', error);
      return null;
    }
  },

  async getGoals(language: string = 'en'): Promise<import('../types').Goal[]> {
    try {
      const { data, error } = await supabase
        .from('goals')
        .select('*')
        .order('display_order');

      if (error) throw error;
      return data as import('../types').Goal[];
    } catch (error) {
      console.error('[database.ts] Error in getGoals:', error);
      return [];
    }
  },

  async getGoalByKey(goalKey: string, language: string = 'en'): Promise<import('../types').Goal | null> {
    try {
      const { data, error } = await supabase
        .from('goals')
        .select('*')
        .eq('goal_key', goalKey)
        .maybeSingle();

      if (error) throw error;
      return data as import('../types').Goal | null;
    } catch (error) {
      console.error('[database.ts] Error in getGoalByKey:', error);
      return null;
    }
  },

  async getGoalWithDetails(goalId: string, language: string = 'en'): Promise<import('../types').GoalWithDetails | null> {
    try {
      const { data: goal } = await supabase
        .from('goals')
        .select('*')
        .eq('id', goalId)
        .maybeSingle();

      if (!goal) return null;

      const { data: goalStacksData } = await supabase
        .from('goal_stacks')
        .select('stack_id, implementation_type, display_order')
        .eq('goal_id', goalId)
        .order('display_order');

      let stacks: any[] = [];
      if (goalStacksData && goalStacksData.length > 0) {
        const stackIds = goalStacksData.map(gs => gs.stack_id);
        const { data: stacksData } = await supabase
          .from('tool_stacks')
          .select('*')
          .in('id', stackIds);
        stacks = stacksData || [];
      }

      const { data: goalInspirationsData } = await supabase
        .from('goal_inspirations')
        .select('inspiration_id, display_order')
        .eq('goal_id', goalId)
        .order('display_order');

      let inspirations: any[] = [];
      if (goalInspirationsData && goalInspirationsData.length > 0) {
        const inspirationIds = goalInspirationsData.map(gi => gi.inspiration_id);
        const { data: inspirationsData } = await supabase
          .from('inspirations')
          .select('*')
          .in('id', inspirationIds);
        inspirations = inspirationsData || [];
      }

      const { data: personaGoalsData } = await supabase
        .from('persona_goals')
        .select('persona_id')
        .eq('goal_id', goalId);

      let personas: any[] = [];
      if (personaGoalsData && personaGoalsData.length > 0) {
        const personaIds = personaGoalsData.map(pg => pg.persona_id);
        const { data: personasData } = await supabase
          .from('personas')
          .select('*')
          .in('id', personaIds);
        personas = personasData || [];
      }

      return {
        ...goal,
        stacks,
        inspirations,
        personas
      } as import('../types').GoalWithDetails;
    } catch (error) {
      console.error('[database.ts] Error in getGoalWithDetails:', error);
      return null;
    }
  },

  async getToolStacks(language: string = 'en'): Promise<import('../types').ToolStack[]> {
    try {
      const { data, error } = await supabase
        .from('tool_stacks')
        .select('*')
        .order('difficulty');

      if (error) throw error;
      return data as import('../types').ToolStack[];
    } catch (error) {
      console.error('[database.ts] Error in getToolStacks:', error);
      return [];
    }
  },

  async getToolStackByKey(stackKey: string, language: string = 'en'): Promise<import('../types').ToolStack | null> {
    try {
      const { data, error } = await supabase
        .from('tool_stacks')
        .select('*')
        .eq('stack_key', stackKey)
        .maybeSingle();

      if (error) throw error;
      return data as import('../types').ToolStack | null;
    } catch (error) {
      console.error('[database.ts] Error in getToolStackByKey:', error);
      return null;
    }
  },

  async getToolStackWithTools(stackId: string, language: string = 'en'): Promise<import('../types').ToolStackWithTools | null> {
    try {
      const { data: stack } = await supabase
        .from('tool_stacks')
        .select('*')
        .eq('id', stackId)
        .maybeSingle();

      if (!stack) return null;

      const toolIds = stack.tool_ids as unknown as string[];
      if (!toolIds || toolIds.length === 0) {
        return { ...stack, tools: [] } as import('../types').ToolStackWithTools;
      }

      const { data: toolsData } = await supabase
        .from('tools')
        .select('*')
        .in('id', toolIds);

      let tools = (toolsData || []).map(tool => ({
        ...tool,
        categories: tool.categories || {
          functional_role: [],
          tech_layer: [],
          difficulty: 'intermediate',
          purpose: [],
          data_flow_role: [],
          application_field: [],
          common_pairings: []
        }
      })) as Tool[];

      if (language !== 'en' && tools.length > 0) {
        const { data: translations } = await supabase
          .from('tool_translations')
          .select('*')
          .eq('language_code', language)
          .in('tool_id', toolIds);

        const transMap = new Map(
          (translations || []).map(t => [t.tool_id, t])
        );

        tools = tools.map(tool => {
          const translation = transMap.get(tool.id!);
          if (translation) {
            return {
              ...tool,
              tool_name: translation.name || tool.tool_name,
              summary: translation.summary || tool.summary
            };
          }
          return tool;
        });
      }

      return {
        ...stack,
        tools
      } as import('../types').ToolStackWithTools;
    } catch (error) {
      console.error('[database.ts] Error in getToolStackWithTools:', error);
      return null;
    }
  },

  async getInspirations(language: string = 'en'): Promise<import('../types').Inspiration[]> {
    try {
      const { data, error } = await supabase
        .from('inspirations')
        .select('*')
        .order('display_order');

      if (error) throw error;
      return data as import('../types').Inspiration[];
    } catch (error) {
      console.error('[database.ts] Error in getInspirations:', error);
      return [];
    }
  },

  async getInspirationByKey(inspirationKey: string, language: string = 'en'): Promise<import('../types').Inspiration | null> {
    try {
      const { data, error } = await supabase
        .from('inspirations')
        .select('*')
        .eq('inspiration_key', inspirationKey)
        .maybeSingle();

      if (error) throw error;
      return data as import('../types').Inspiration | null;
    } catch (error) {
      console.error('[database.ts] Error in getInspirationByKey:', error);
      return null;
    }
  },

  async getInspirationWithDetails(inspirationId: string, language: string = 'en'): Promise<import('../types').InspirationWithDetails | null> {
    try {
      const { data: inspiration } = await supabase
        .from('inspirations')
        .select('*')
        .eq('id', inspirationId)
        .maybeSingle();

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
    } catch (error) {
      console.error('[database.ts] Error in getInspirationWithDetails:', error);
      return null;
    }
  },

  async getGoalsByPersona(personaKey: string, language: string = 'en'): Promise<import('../types').Goal[]> {
    try {
      const persona = await this.getPersonaByKey(personaKey, language);
      if (!persona) return [];

      const { data: personaGoalsData } = await supabase
        .from('persona_goals')
        .select('goal_id, display_order')
        .eq('persona_id', persona.id)
        .order('display_order');

      if (!personaGoalsData || personaGoalsData.length === 0) return [];

      const goalIds = personaGoalsData.map(pg => pg.goal_id);
      const { data: goals } = await supabase
        .from('goals')
        .select('*')
        .in('id', goalIds);

      return goals || [];
    } catch (error) {
      console.error('[database.ts] Error in getGoalsByPersona:', error);
      return [];
    }
  },

  async getInspirationsByGoal(goalKey: string, language: string = 'en'): Promise<import('../types').Inspiration[]> {
    try {
      const goal = await this.getGoalByKey(goalKey, language);
      if (!goal) return [];

      const { data: goalInspirationsData } = await supabase
        .from('goal_inspirations')
        .select('inspiration_id, display_order')
        .eq('goal_id', goal.id)
        .order('display_order');

      if (!goalInspirationsData || goalInspirationsData.length === 0) return [];

      const inspirationIds = goalInspirationsData.map(gi => gi.inspiration_id);
      const { data: inspirations } = await supabase
        .from('inspirations')
        .select('*')
        .in('id', inspirationIds);

      return inspirations || [];
    } catch (error) {
      console.error('[database.ts] Error in getInspirationsByGoal:', error);
      return [];
    }
  },

  async getStacksByGoal(goalKey: string, language: string = 'en'): Promise<import('../types').ToolStack[]> {
    try {
      const goal = await this.getGoalByKey(goalKey, language);
      if (!goal) return [];

      const { data: goalStacksData } = await supabase
        .from('goal_stacks')
        .select('stack_id, implementation_type, display_order')
        .eq('goal_id', goal.id)
        .order('display_order');

      if (!goalStacksData || goalStacksData.length === 0) return [];

      const stackIds = goalStacksData.map(gs => gs.stack_id);
      const { data: stacks } = await supabase
        .from('tool_stacks')
        .select('*')
        .in('id', stackIds);

      return stacks || [];
    } catch (error) {
      console.error('[database.ts] Error in getStacksByGoal:', error);
      return [];
    }
  },

  async getFeaturedInspirations(limit: number = 6, language: string = 'en'): Promise<import('../types').Inspiration[]> {
    try {
      const { data, error } = await supabase
        .from('inspirations')
        .select('*')
        .order('display_order')
        .limit(limit);

      if (error) throw error;
      return data as import('../types').Inspiration[];
    } catch (error) {
      console.error('[database.ts] Error in getFeaturedInspirations:', error);
      return [];
    }
  },

  // ============================================================================
  // CREATIVE USE CASES
  // ============================================================================

  async getCreativeUseCases(filters?: {
    difficulty?: string;
    tag?: string;
    search?: string;
  }): Promise<any[]> {
    try {
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
    } catch (error) {
      console.error('[database.ts] Error in getCreativeUseCases:', error);
      return [];
    }
  },

  async getCreativeUseCaseBySlug(slug: string): Promise<any | null> {
    try {
      const { data, error } = await supabase
        .from('creative_use_cases')
        .select('*')
        .eq('slug', slug)
        .maybeSingle();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('[database.ts] Error in getCreativeUseCaseBySlug:', error);
      return null;
    }
  },

  // ============================================================================
  // EXPORT TEMPLATES
  // ============================================================================

  async getExportTemplates(toolId: string): Promise<any[]> {
    try {
      const { data, error } = await supabase
        .from('export_templates')
        .select('*')
        .eq('tool_id', toolId)
        .order('platform');

      if (error) throw error;
      return data || [];
    } catch (error) {
      console.error('[database.ts] Error in getExportTemplates:', error);
      return [];
    }
  },

  async getExportTemplateByPlatform(toolId: string, platform: string): Promise<any | null> {
    try {
      const { data, error } = await supabase
        .from('export_templates')
        .select('*')
        .eq('tool_id', toolId)
        .eq('platform', platform)
        .maybeSingle();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('[database.ts] Error in getExportTemplateByPlatform:', error);
      return null;
    }
  }
};
