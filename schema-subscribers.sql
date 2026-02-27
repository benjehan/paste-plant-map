create table subscribers (
  id uuid default gen_random_uuid() primary key,
  email text not null unique,
  name text,
  subscribed_at timestamptz default now()
);
alter table subscribers enable row level security;
create policy "Anyone can subscribe" on subscribers for insert to anon with check (true);
create policy "Service role full access subs" on subscribers for all to service_role using (true);
