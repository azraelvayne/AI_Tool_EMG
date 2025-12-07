# AI Tool Ecosystem Map - Architecture Documentation

## Project Overview

**AI Tool Ecosystem Map** is a persona-driven learning platform that helps users discover, understand, and master AI tools through a structured 6-dimensional ecosystem approach.

### Current Phase
**Phase 3 - Consolidation & Expansion** (Version 3.0)
- Database: 100+ curated tools (70 existing + 30 newly added)
- 6 user personas with goal-driven learning paths
- Multilingual support (English & Traditional Chinese)

---

## Core Architecture: The 6D Ecosystem

The platform is built on a **6-Dimensional (6D) Ecosystem** architecture that bridges user needs with system capabilities.

### 6D Architecture Definition

| Layer | Name | Orientation | Definition (User Story) |
|:---:|:---:|:---:|:---|
| **① Persona** | 角色層 | User-Oriented | Who am I? (Identity & motivation) |
| **② Goal** | 目標層 | User-Oriented | What do I want to achieve? (Tasks & use cases) |
| **③ Stack** | 工具層 | User-Oriented | What tools do I use? (Specific software) |
| **④ Creation** | 創作層 | System-Oriented | What content do I create? (Generated outputs) |
| **⑤ Operation** | 營運層 | System-Oriented | How do I promote & operate? (Automation/CRM) |
| **⑥ Management** | 管理層 | System-Oriented | How do I integrate & monitor? (Data flow/Projects) |

### Architecture Principles

1. **User-Oriented Layers (1-3)**: Start with the user's identity, goals, and tool selection
2. **System-Oriented Layers (4-6)**: Support the user through content creation, operations, and management
3. **Progressive Discovery**: Users navigate from persona → goal → stack → implementation
4. **Role-Based Learning**: Each persona has tailored goals and recommended tool stacks

---

## Technology Stack

### Frontend
- **Framework**: React 18.3 with TypeScript
- **Build Tool**: Vite 5.4
- **Styling**: Tailwind CSS 3.4
- **Animations**: Framer Motion 12.x
- **Icons**: Lucide React
- **Routing**: Single-page application with view-mode state management

### Backend & Database
- **Database**: Supabase (PostgreSQL 15)
- **ORM**: Direct SQL queries via Supabase client
- **Real-time**: Supabase subscriptions (future feature)
- **Authentication**: localStorage-based (no server auth yet)

### State Management
- **Global State**: React Context API (`AppContext`)
- **Local State**: React useState/useEffect hooks
- **Persistence**: localStorage with debounce (300ms)
- **Caching**: In-memory tool/category caching

### Internationalization (i18n)

The platform uses a **Dual Translation System**:

#### 1. UI Translation (i18next)
- **Location**: `src/locales/[lang]/common.json`
- **Purpose**: Button labels, navigation, system messages
- **Languages**: `en`, `zh-TW`
- **Implementation**: React-i18next hooks

#### 2. Content Translation (Database)
- **Location**: Supabase `tool_translations` table
- **Purpose**: Tool descriptions, use cases, inspiration
- **Languages**: `en`, `zh-TW`
- **Implementation**: Dynamic query based on current language

**Why Two Systems?**
- UI text changes frequently during development → JSON files for quick iteration
- Content data is extensive and user-generated → Database for scalability
- Language code standard: Always use `zh-TW` (not `zh` or `zh-CN`)

---

## Database Schema

### Core Tables

#### `tools`
Primary tool information with categories and metadata
```sql
- id (uuid, PK)
- tool_name (text)
- summary (text)
- source_slug (text, unique)
- categories (jsonb)  -- 6D classification
- description_styles (jsonb)
- use_case_templates (jsonb)
- icon_url (text)
- is_curated (boolean)
- curation_batch (text)
- created_at, updated_at (timestamptz)
```

#### `tool_translations`
Multilingual content for tools
```sql
- id (uuid, PK)
- tool_id (uuid, FK)
- language_code (text: 'en' | 'zh-TW')
- summary (text)
- description_styles (jsonb)
```

#### `personas`
User role definitions
```sql
- id (uuid, PK)
- persona_key (text, unique)
- name_en, name_zh_tw (text)
- description_en, description_zh_tw (text)
- skill_level (text)
- learning_focus (jsonb)
- display_order (int)
```

#### `goals`
Learning objectives linked to personas
```sql
- id (uuid, PK)
- goal_key (text, unique)
- title_en, title_zh_tw (text)
- description_en, description_zh_tw (text)
- difficulty (text)
- expected_skills (jsonb)
```

#### `tool_stacks`
Curated tool combinations for specific goals
```sql
- id (uuid, PK)
- stack_key (text, unique)
- name_en, name_zh_tw (text)
- tool_ids (jsonb array)
- flow_map (text)
- difficulty (text)
```

#### `inspirations`
Step-by-step tutorials and examples
```sql
- id (uuid, PK)
- inspiration_key (text, unique)
- title_en, title_zh_tw (text)
- steps (jsonb array)
- stack_id (uuid, FK)
- resource_links (jsonb)
```

### Relationship Tables
- `persona_goals`: Maps personas to their recommended goals
- `goal_stacks`: Links goals to tool stacks
- `goal_inspirations`: Connects goals with inspiration examples
- `tool_pairings`: Defines tool compatibility relationships

---

## Data Flow Architecture

### User Journey Flow
```
1. User selects Persona
   ↓
2. Views recommended Goals
   ↓
3. Selects a Goal
   ↓
4. Browses Tool Stacks for that Goal
   ↓
5. Explores individual Tools
   ↓
6. Views Inspirations (use cases)
   ↓
7. Applies filters and exports selected tools
```

### Data Loading Strategy
1. **Initial Load**: Fetch tools and categories on app mount
2. **Language Switch**: Re-fetch with new language code
3. **Filter Application**: Client-side filtering on cached data
4. **Favorites**: localStorage with debounce (no server sync)
5. **Search**: Real-time filtering with context state

---

## Component Architecture

### Page Components (`src/pages/`)
- `PersonaHomePage`: Main entry point with persona cards
- `PersonaDetailPage`: Shows goals for selected persona
- `GoalDetailPage`: Displays stacks and inspirations for a goal
- `ToolsExplorerPage`: Filterable tool browser
- `InspirationBrowsePage`: Browse all inspirations
- `InspirationDetailPage`: Step-by-step tutorial view
- `FavoritesPage`: User's saved tools
- `CreativeUseCasesPage`: Discover creative use cases
- `LearnPage`: Learning resources

### Layout Components (`src/components/`)
- `ToolsExplorerLayout`: Main tool browsing interface
- `FilterPanel`: Category filtering sidebar
- `ToolCard`: Individual tool display card
- `PersonaCard`: Persona selection card
- `InspirationCard`: Use case preview card

### Modal Components
- `ToolDetailModal`: Full tool information popup
- `AIRecommendationModal`: AI-powered tool suggestions
- `ExportModal`: Multi-format export (JSON, CSV, Notion, etc.)
- `AboutModal`: Project information
- `PopularToolsModal`: Trending tools
- `FeaturedStacksModal`: Curated tool combinations

---

## State Management Details

### AppContext Provider
```typescript
{
  tools: Tool[]               // Cached tool list
  categories: CategoryMetadata[]
  filters: FilterState        // Active filters
  setFilters: (filters) => void
  favorites: string[]         // Tool IDs
  toggleFavorite: (id) => void
  userMode: UserMode          // 'creator' | 'developer' | 'learner'
  searchQuery: string
  loading: boolean
  refreshTools: () => Promise<void>
}
```

### localStorage Schema
```typescript
{
  favorites: string[]
  collections: Collection[]   // Future feature
  recent_searches: string[]
  ui_preferences: {
    mode: UserMode
    theme: 'light' | 'dark'
  }
  onboarding_completed: boolean
}
```

---

## Type System

### Legacy 4D Classification (Preserved)

The original 4D classification system is **still present** in `src/types/index.ts` and serves as the foundation for the 6D ecosystem:

- **Dimension 1**: Technical Layer (`ToolLayerType`)
- **Dimension 2**: n8n Category ecosystem
- **Dimension 3**: Use Case Scenarios
- **Dimension 4**: Integration Platform Compatibility

These types are preserved because:
1. They provide granular classification for advanced filtering
2. Future features may leverage this detailed taxonomy
3. Migration data uses these structures

### Current Active Types
- `Tool`: Core tool interface
- `ToolCategories`: 6D classification structure
- `Persona`, `Goal`, `ToolStack`, `Inspiration`: Learning path types
- `FilterState`, `ExtendedFilterState`: Filtering logic

---

## Performance Optimizations

### 1. Debounced localStorage Writes
```typescript
// src/lib/localStorage.ts
const debouncedSaveData = debounce(saveDataImmediate, 300);
```
Prevents excessive I/O during rapid user interactions (favorites, search)

### 2. Client-Side Filtering
Tools are fetched once and filtered in-memory to reduce database queries

### 3. Lazy Loading (Future)
Component-level code splitting for faster initial load

### 4. Image Optimization
Persona images stored in `public/personas/` with optimized file sizes

---

## Migration Strategy

### Database Migrations
- **Location**: `supabase/migrations/`
- **Format**: SQL files with timestamp prefixes
- **Naming**: `YYYYMMDD_HHMMSS_description.sql`
- **Documentation**: Each migration includes detailed header comments

### Latest Migration
**File**: `2025-12-07_1314_import_30_additional_tools.sql`
**Purpose**: Add 30 new tools (Airflow, fal, Prefect, Miro, Figma, etc.)
**Batch**: `v3.0-expansion-30`

To apply:
```bash
# Via Supabase Studio (Web UI)
1. Open Supabase Studio → SQL Editor
2. Paste migration content
3. Execute

# Via Supabase CLI (if installed)
supabase db push
```

---

## Future Architecture Considerations

### Phase 4 Plans
1. **User Authentication**: Supabase Auth for cross-device sync
2. **Collections Feature**: Implement UI for tool collections
3. **Real-time Collaboration**: Share favorites with team members
4. **AI Recommendations v2**: Integrate LLM-based suggestions
5. **Analytics**: Track user journeys and popular paths
6. **API Layer**: Expose public API for tool discovery

### Scalability Notes
- Current design supports 1000+ tools without refactoring
- Consider implementing pagination when tool count exceeds 500
- May need CDN for persona images at scale
- Database indexes already configured for common queries

---

## Development Guidelines

### Code Organization
- **One concern per file**: Avoid large monolithic components
- **Shared utilities**: Place in `src/lib/`
- **Type definitions**: Centralize in `src/types/index.ts`
- **Hooks**: Extract custom hooks to `src/hooks/`

### Naming Conventions
- Components: PascalCase (e.g., `ToolCard.tsx`)
- Utilities: camelCase (e.g., `localStorage.ts`)
- Hooks: camelCase with `use` prefix (e.g., `useFavorites.ts`)
- Types: PascalCase with meaningful names

### Translation Keys
- UI: `common.json` → `t('home.title')`
- Content: Database → Dynamic query by `language_code`
- Always provide both `en` and `zh-TW` translations

---

## Testing Strategy (Future)

### Recommended Testing Approach
1. **Unit Tests**: Utility functions in `src/lib/`
2. **Integration Tests**: Database queries and data transformations
3. **E2E Tests**: Critical user flows (persona → goal → tools)
4. **Visual Regression**: Snapshot testing for UI components

### Tools to Consider
- Jest + React Testing Library
- Cypress or Playwright for E2E
- Supabase local development for database tests

---

## Deployment

### Build Process
```bash
npm run build
# Output: dist/ directory
```

### Environment Variables
```bash
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_anon_key
```

### Hosting Recommendations
- **Vercel**: Best for Next.js/React, automatic deployments
- **Netlify**: Great for static sites, easy setup
- **Cloudflare Pages**: Fast CDN, generous free tier

---

## Troubleshooting

### Common Issues

**1. Translations not showing**
- Check `language_code` in database matches `zh-TW` (not `zh`)
- Verify `tool_translations` table has entries for both languages

**2. Filters not working**
- Ensure `AppContext` is properly wrapped around components
- Check `setFilters` is called with correct `FilterState` structure

**3. Personas not loading**
- Verify persona images exist in `public/personas/`
- Check filenames match database `icon_url` field

**4. Build fails**
- Run `npm install` to ensure all dependencies are installed
- Check for TypeScript errors: `npm run typecheck`

---

## Version History

- **v1.0**: Initial 4D classification system
- **v2.0**: Persona-driven learning platform
- **v3.0**: 6D ecosystem + 100 tools expansion (current)

---

## Contributors

This project follows the Single Source of Truth (SSOT) documentation approach. All architectural decisions are documented in this file and the SSOT master document.

For questions or contributions, please refer to the project README.md.

---

**Last Updated**: December 7, 2025
**Architecture Version**: 3.0
**Database Tools**: 100+
