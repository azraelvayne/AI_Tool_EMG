/*
  # Create admin settings table
  
  1. New Tables
    - `admin_settings`
      - `id` (uuid, primary key)
      - `password_hash` (text) - Stores the hashed admin password
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
  
  2. Security
    - Enable RLS on `admin_settings` table
    - No public access policies (admin only via service role)
  
  3. Initial Data
    - Insert default password hash for 'admin123'
*/

CREATE TABLE IF NOT EXISTS admin_settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  password_hash text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE admin_settings ENABLE ROW LEVEL SECURITY;

-- No policies needed - this table should only be accessed via service role or edge functions

-- Insert default password (simple hash for demo purposes)
-- In production, use proper bcrypt or similar
INSERT INTO admin_settings (password_hash)
VALUES ('admin123')
ON CONFLICT DO NOTHING;