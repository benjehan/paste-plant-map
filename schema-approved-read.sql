create policy "Anyone can read approved submissions"
  on mine_submissions
  for select
  to anon
  using (status = 'approved');
