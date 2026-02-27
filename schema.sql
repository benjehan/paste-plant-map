-- Paste Plant Map — Supabase Schema
-- Run this in Supabase SQL Editor

-- mine_submissions table
create table mine_submissions (
  id uuid default gen_random_uuid() primary key,
  mine_name text not null,
  company text,
  country text,
  region text,
  fill_type text default 'Paste',
  tpd integer,
  plants integer default 1,
  commodity text,
  commissioned_year integer,
  designer text,
  lat numeric,
  lng numeric,
  notes text,
  source_reference text,
  submitter_name text not null,
  submitter_email text,
  submission_type text default 'new' check (submission_type in ('new', 'correction')),
  existing_mine_name text,
  status text default 'pending' check (status in ('pending', 'approved', 'rejected')),
  admin_notes text,
  created_at timestamptz default now(),
  reviewed_at timestamptz
);

-- RLS: anyone can insert (anon), only service_role can read/update/delete
alter table mine_submissions enable row level security;
create policy "Anyone can submit" on mine_submissions for insert to anon with check (true);
create policy "Service role full access" on mine_submissions for all to service_role using (true);

-- paste_news table for news feed
create table paste_news (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  url text not null,
  source text,
  snippet text,
  published_at timestamptz,
  created_at timestamptz default now()
);

alter table paste_news enable row level security;
create policy "Anyone can read news" on paste_news for select to anon using (true);
create policy "Service role full access news" on paste_news for all to service_role using (true);
