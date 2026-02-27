create table mines (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  company text,
  country text,
  region text,
  lat numeric,
  lng numeric,
  type text default 'Paste',
  tpd integer,
  ore_tpd integer,
  plants integer default 1,
  notes text,
  commodity text,
  status text default 'operating',
  confidence text default 'likely',
  source text,
  source_label text,
  year_commissioned integer,
  designer text,
  last_updated date,
  updated_by text,
  created_at timestamptz default now()
);

-- RLS: anyone can read, only admins can write
alter table mines enable row level security;
create policy "Anyone can read mines" on mines for select to anon using (true);
create policy "Admins can manage mines" on mines for all to authenticated using (exists (select 1 from admin_users where admin_users.id = auth.uid()));
-- Service role always has full access
create policy "Service role full access mines" on mines for all to service_role using (true);
