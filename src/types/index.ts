export interface ToolCategories {
  purpose: string[];
  functional_role: string[];
  application_field: string[];
  tech_layer: string[];
  data_flow_role: string[];
  difficulty: string;
  common_pairings: string[];
}

export interface DescriptionStyles {
  encyclopedia: string;
  guide: string;
  strategy: string;
  inspiration: string[];
}

export interface UseCaseTemplate {
  goal: string;
  method: string;
  tool_stack: string[];
  steps: string[];
}

export interface Tool {
  id?: string;
  tool_name: string;
  summary: string;
  categories: ToolCategories;
  description_styles: DescriptionStyles;
  use_case_templates: UseCaseTemplate[];
  display_priority?: number;
  popularity_score?: number;
  icon_url?: string;
  is_verified?: boolean;
  generation_source?: string;
  created_at?: string;
  updated_at?: string;
}

export interface CategoryMetadata {
  id: string;
  category_type: string;
  category_value: string;
  color_hex: string;
  icon_name: string;
  description: string;
  display_order: number;
  translated_value?: string;
}

export interface CategoryTranslation {
  id: string;
  category_metadata_id: string;
  language_code: 'en' | 'zh-TW';
  translated_value: string;
  created_at?: string;
}

export interface ToolTranslation {
  id: string;
  tool_id: string;
  language_code: 'en' | 'zh-TW';
  summary: string;
  description_styles: DescriptionStyles;
  created_at?: string;
}

export interface ToolPairing {
  id: string;
  tool_id_1: string;
  tool_id_2: string;
  relationship_type: 'integrates_with' | 'alternative_to' | 'complements';
  strength: number;
  description: string;
}

export interface FeaturedStack {
  id: string;
  stack_name: string;
  description: string;
  tool_ids: string[];
  use_case: string;
  difficulty_level: string;
  display_order: number;
  tagline?: string;
  target_audience?: string;
  estimated_setup_time?: string;
  is_editor_choice?: boolean;
}

export interface UserInteraction {
  id?: string;
  tool_id: string;
  interaction_type: 'view' | 'favorite' | 'generate';
  session_id: string;
  created_at?: string;
}

// Legacy filter types (backward compatible)
export type FilterType = 'purpose' | 'functional_role' | 'tech_layer' | 'data_flow_role' | 'difficulty' | 'application_field';

export interface FilterState {
  purpose: string[];
  functional_role: string[];
  tech_layer: string[];
  data_flow_role: string[];
  difficulty: string[];
  application_field: string[];
}

// Extended filter state combining legacy and 4D filters
export interface ExtendedFilterState extends FilterState {
  layers?: ToolLayerType[];
  n8n_categories?: string[];
  difficulty_levels?: DifficultyLevel[];
  integration_platforms?: IntegrationPlatform[];
}

export interface ExportFormat {
  type: 'json' | 'csv' | 'prompt' | 'notion' | 'airtable' | 'n8n' | 'canva';
  data: string;
  filename: string;
}

export type UserMode = 'creator' | 'developer' | 'learner';

export interface LocalStorageData {
  favorites: string[];
  collections: Collection[];
  recent_searches: string[];
  ui_preferences: {
    mode: UserMode;
    theme: 'light' | 'dark';
  };
  onboarding_completed: boolean;
}

export interface Collection {
  id: string;
  name: string;
  tool_ids: string[];
  created_at: string;
}

// ============================================================================
// 4D CLASSIFICATION SYSTEM TYPES
// ============================================================================

// DIMENSION 1: Layer (technical layer where tool operates)
export type ToolLayerType = 'Data' | 'Processing' | 'AI' | 'Frontend' | 'Integration';

export interface ToolLayer {
  id: string;
  tool_id: string;
  layer: ToolLayerType;
  display_order: number;
  created_at?: string;
}

// DIMENSION 2: n8n Category (18 ecosystem categories)
export interface ToolCategoryMapping {
  id: string;
  tool_id: string;
  n8n_category: string;
  sub_category?: string;
  tags: string[];
  created_at?: string;
}

// DIMENSION 3: Use Case Scenarios (real-world applications)
export type DifficultyLevel = 'beginner' | 'intermediate' | 'advanced';

export interface ToolUseCase {
  id: string;
  tool_id: string;
  usecase_key: string;
  usecase_name: string;
  usecase_description: string;
  difficulty_level: DifficultyLevel;
  estimated_setup_time: string;
  display_order: number;
  created_at?: string;
}

// DIMENSION 4: Integration Platform Compatibility
export type IntegrationPlatform = 'n8n' | 'Zapier' | 'Make' | 'Flowise' | 'Webflow' | 'Glide' | 'Bubble' | 'Rest API';
export type IntegrationType = 'trigger' | 'action' | 'bi-directional' | 'webhook' | 'api';

export interface ToolIntegration {
  id: string;
  tool_id: string;
  platform: IntegrationPlatform;
  integration_type: IntegrationType;
  documentation_url?: string;
  strength: number;
  created_at?: string;
}

// Enhanced Tool interface with 4D classification data
export interface ToolWith4D extends Tool {
  layers?: ToolLayer[];
  category_mappings?: ToolCategoryMapping[];
  use_cases?: ToolUseCase[];
  integrations?: ToolIntegration[];
}

// 4D Filter State for advanced filtering
export type Filter4DType = 'layer' | 'n8n_category' | 'difficulty' | 'integration_platform';

export interface Filter4DState {
  layers: ToolLayerType[];
  n8n_categories: string[];
  difficulty_levels: DifficultyLevel[];
  integration_platforms: IntegrationPlatform[];
}

// ============================================================================
// PERSONA-DRIVEN LEARNING PLATFORM TYPES
// ============================================================================

export type SkillLevel = 'beginner' | 'intermediate' | 'advanced';
export type ImplementationType = 'no-code' | 'low-code' | 'developer' | 'standard';

export interface Persona {
  id: string;
  persona_key: string;
  name_en: string;
  name_zh_tw: string;
  description_en: string;
  description_zh_tw: string;
  skill_level: SkillLevel;
  learning_focus: string[];
  recommended_goals: string[];
  icon_url?: string;
  display_order: number;
  created_at?: string;
}

export interface Goal {
  id: string;
  goal_key: string;
  title_en: string;
  title_zh_tw: string;
  description_en: string;
  description_zh_tw: string;
  difficulty: SkillLevel;
  learning_focus: string[];
  expected_skills: string[];
  outcome_en: string;
  outcome_zh_tw: string;
  display_order: number;
  created_at?: string;
}

export interface ToolStack {
  id: string;
  stack_key: string;
  name_en: string;
  name_zh_tw: string;
  description_en: string;
  description_zh_tw: string;
  tool_ids: string[];
  flow_map: string;
  diagram_url?: string;
  difficulty: SkillLevel;
  integration_method: string;
  setup_complexity: 'low' | 'medium' | 'high';
  estimated_time: string;
  created_at?: string;
}

export interface ResourceLink {
  name: string;
  url: string;
}

export interface Inspiration {
  id: string;
  inspiration_key: string;
  title_en: string;
  title_zh_tw: string;
  description_en: string;
  description_zh_tw: string;
  steps: string[];
  stack_id?: string;
  difficulty: SkillLevel;
  estimated_time: string;
  learning_focus: string[];
  expected_skills: string[];
  resource_links: ResourceLink[];
  outcome_demo?: string;
  visual_hint?: string;
  display_order: number;
  created_at?: string;
}

export interface PersonaGoal {
  id: string;
  persona_id: string;
  goal_id: string;
  display_order: number;
  created_at?: string;
}

export interface GoalStack {
  id: string;
  goal_id: string;
  stack_id: string;
  implementation_type: ImplementationType;
  display_order: number;
  created_at?: string;
}

export interface GoalInspiration {
  id: string;
  goal_id: string;
  inspiration_id: string;
  display_order: number;
  created_at?: string;
}

// Extended types with relationships
export interface PersonaWithGoals extends Persona {
  goals?: Goal[];
}

export interface GoalWithDetails extends Goal {
  personas?: Persona[];
  stacks?: ToolStack[];
  inspirations?: Inspiration[];
}

export interface InspirationWithDetails extends Inspiration {
  stack?: ToolStack;
  tools?: Tool[];
}

export interface ToolStackWithTools extends ToolStack {
  tools?: Tool[];
}
