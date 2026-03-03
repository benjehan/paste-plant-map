-- Mine edits table for P&C reviewer approval workflow
create table if not exists mine_edits (
  id uuid default gen_random_uuid() primary key,
  mine_id uuid references mines(id) on delete cascade,
  edit_type text not null check (edit_type in ('update', 'add', 'delete')),
  field_changes jsonb not null default '{}',
  new_mine_data jsonb,
  editor_name text not null,
  editor_region text,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  admin_notes text,
  created_at timestamptz default now(),
  reviewed_at timestamptz,
  reviewed_by text
);

-- RLS: anon can insert (P&C reviewers), service role can do everything
alter table mine_edits enable row level security;
create policy "Anyone can read edits" on mine_edits for select to anon using (true);
create policy "Anyone can insert edits" on mine_edits for insert to anon with check (true);
create policy "Service role full access edits" on mine_edits for all to service_role using (true);
create policy "Authenticated full access edits" on mine_edits for all to authenticated using (true);

-- Index for quick pending lookups
create index if not exists idx_mine_edits_status on mine_edits(status);
create index if not exists idx_mine_edits_mine_id on mine_edits(mine_id);
