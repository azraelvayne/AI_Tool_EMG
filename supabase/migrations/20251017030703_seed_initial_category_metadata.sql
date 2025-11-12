/*
  # Seed Category Metadata

  ## Purpose
  Populate category_metadata table with visual styling for all classification axes.

  ## Categories Seeded
  1. Purpose (Learning, Application, System oriented)
  2. Functional Role (Database, API, Automation, etc.)
  3. Tech Layer (Data Layer, Processing Layer, Frontend Layer, AI Layer)
  4. Data Flow Role (Input, Process, Storage, Output)
  5. Difficulty (No-code, Low-code, Code)
  6. Application Field (Knowledge Management, Automation, Content Creation, etc.)

  ## Color Scheme
  - Blues for database/storage
  - Greens for processing/automation
  - Oranges for frontend/creative
  - Teals for AI/intelligence
  - Avoiding purple/indigo per requirements
*/

-- Insert Purpose categories
INSERT INTO category_metadata (category_type, category_value, color_hex, icon_name, description, display_order) VALUES
('purpose', 'Learning Oriented', '#10B981', 'graduation-cap', 'Tools focused on education and skill development', 1),
('purpose', 'Application Oriented', '#3B82F6', 'zap', 'Tools for building and deploying applications', 2),
('purpose', 'System Oriented', '#64748B', 'server', 'Tools for infrastructure and system architecture', 3)
ON CONFLICT (category_type, category_value) DO NOTHING;

-- Insert Functional Role categories
INSERT INTO category_metadata (category_type, category_value, color_hex, icon_name, description, display_order) VALUES
('functional_role', 'Database', '#0EA5E9', 'database', 'Data storage and management systems', 1),
('functional_role', 'API', '#06B6D4', 'plug', 'Interface and integration layers', 2),
('functional_role', 'Automation', '#10B981', 'workflow', 'Process automation and orchestration', 3),
('functional_role', 'Frontend', '#F59E0B', 'layout', 'User interface and presentation layer', 4),
('functional_role', 'AI Assistant', '#14B8A6', 'brain', 'Artificial intelligence and language models', 5),
('functional_role', 'Content Management', '#F97316', 'file-text', 'Content creation and organization', 6),
('functional_role', 'Collaboration', '#8B5CF6', 'users', 'Team communication and coordination', 7),
('functional_role', 'Analytics', '#EC4899', 'bar-chart', 'Data analysis and visualization', 8)
ON CONFLICT (category_type, category_value) DO NOTHING;

-- Insert Tech Layer categories
INSERT INTO category_metadata (category_type, category_value, color_hex, icon_name, description, display_order) VALUES
('tech_layer', 'Data Layer', '#0EA5E9', 'layers', 'Storage, databases, and data persistence', 1),
('tech_layer', 'Processing Layer', '#10B981', 'cpu', 'Business logic, APIs, and data processing', 2),
('tech_layer', 'Frontend Layer', '#F59E0B', 'monitor', 'User interfaces and visual presentation', 3),
('tech_layer', 'AI Layer', '#14B8A6', 'sparkles', 'Machine learning and AI capabilities', 4),
('tech_layer', 'Integration Layer', '#06B6D4', 'link', 'Connectors and middleware', 5)
ON CONFLICT (category_type, category_value) DO NOTHING;

-- Insert Data Flow Role categories
INSERT INTO category_metadata (category_type, category_value, color_hex, icon_name, description, display_order) VALUES
('data_flow_role', 'Input', '#10B981', 'arrow-down-circle', 'Data collection and ingestion', 1),
('data_flow_role', 'Process', '#3B82F6', 'settings', 'Data transformation and processing', 2),
('data_flow_role', 'Storage', '#0EA5E9', 'hard-drive', 'Data persistence and retrieval', 3),
('data_flow_role', 'Output', '#F59E0B', 'arrow-up-circle', 'Data presentation and export', 4)
ON CONFLICT (category_type, category_value) DO NOTHING;

-- Insert Difficulty categories
INSERT INTO category_metadata (category_type, category_value, color_hex, icon_name, description, display_order) VALUES
('difficulty', 'No-code', '#10B981', 'smile', 'Visual interfaces, no coding required', 1),
('difficulty', 'Low-code', '#3B82F6', 'code', 'Minimal coding with templates', 2),
('difficulty', 'Code', '#64748B', 'terminal', 'Programming knowledge required', 3)
ON CONFLICT (category_type, category_value) DO NOTHING;

-- Insert Application Field categories
INSERT INTO category_metadata (category_type, category_value, color_hex, icon_name, description, display_order) VALUES
('application_field', 'Knowledge Management', '#3B82F6', 'book-open', 'Organizing and accessing information', 1),
('application_field', 'Automation', '#10B981', 'zap', 'Workflow automation and efficiency', 2),
('application_field', 'Content Creation', '#F59E0B', 'pen-tool', 'Creating and editing content', 3),
('application_field', 'Data Analysis', '#EC4899', 'trending-up', 'Insights and reporting', 4),
('application_field', 'Web Development', '#06B6D4', 'globe', 'Building web applications', 5),
('application_field', 'AI Applications', '#14B8A6', 'cpu', 'AI-powered solutions', 6),
('application_field', 'Collaboration', '#8B5CF6', 'users', 'Team productivity tools', 7)
ON CONFLICT (category_type, category_value) DO NOTHING;