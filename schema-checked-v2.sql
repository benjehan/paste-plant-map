-- Allow anon role to update the checked fields on mines
CREATE POLICY "anon_update_checked" ON mines
  FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (true);

-- If a general update policy already exists and is blocking, try this instead:
-- ALTER POLICY "existing_policy_name" ON mines USING (true) WITH CHECK (true);

-- Pre-populate checked status from existing updated_by data:
-- Mark mines that have been updated by a known person as "checked"
UPDATE mines 
SET checked_by = updated_by, 
    checked_at = CASE 
      WHEN last_updated IS NOT NULL THEN last_updated::timestamptz 
      ELSE NOW() 
    END,
    checked_region = NULL
WHERE updated_by IS NOT NULL 
  AND updated_by != 'None'
  AND checked_by IS NULL;
