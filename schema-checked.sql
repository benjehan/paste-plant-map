-- Add P&C review tracking columns to mines table
ALTER TABLE mines ADD COLUMN IF NOT EXISTS checked_by TEXT;
ALTER TABLE mines ADD COLUMN IF NOT EXISTS checked_at TIMESTAMPTZ;
ALTER TABLE mines ADD COLUMN IF NOT EXISTS checked_region TEXT;

-- Allow anon to update these fields (already has select, need update for checked fields)
-- If RLS is on, you may need a policy. For now this should work with existing anon access.
