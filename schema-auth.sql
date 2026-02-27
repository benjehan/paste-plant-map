-- Paste Plant Map — Auth Migration
-- Run this in Supabase SQL Editor AFTER schema.sql
-- 
-- SETUP STEPS:
-- 1. Run this SQL in the SQL Editor
-- 2. Go to Authentication > Users > Add User
--    Email: ben@minesmart.io, set a password
-- 3. Then run: INSERT INTO admin_users (id, email) SELECT id, email FROM auth.users WHERE email = 'ben@minesmart.io';

-- Admin users table
create table if not exists admin_users (
  id uuid references auth.users on delete cascade primary key,
  email text not null,
  role text default 'admin',
  created_at timestamptz default now()
);

alter table admin_users enable row level security;

-- Admin users can read their own record
create policy "Admin users can read own record"
  on admin_users for select to authenticated
  using (auth.uid() = id);

-- mine_submissions: authenticated admin SELECT
create policy "Admins can view submissions"
  on mine_submissions for select to authenticated
  using (exists (select 1 from admin_users where admin_users.id = auth.uid()));

-- mine_submissions: authenticated admin UPDATE
create policy "Admins can update submissions"
  on mine_submissions for update to authenticated
  using (exists (select 1 from admin_users where admin_users.id = auth.uid()));

-- mine_submissions: authenticated admin DELETE (optional)
create policy "Admins can delete submissions"
  on mine_submissions for delete to authenticated
  using (exists (select 1 from admin_users where admin_users.id = auth.uid()));

-- paste_news: authenticated admin full access
create policy "Admins can manage news"
  on paste_news for all to authenticated
  using (exists (select 1 from admin_users where admin_users.id = auth.uid()));
