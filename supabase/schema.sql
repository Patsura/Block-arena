-- BLOCK ARENA 2.0 — Supabase schema
-- Выполнить в Supabase → SQL Editor → Run.

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nickname text not null default 'Block Player',
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.saves (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  trophies integer not null default 0,
  updated_at timestamptz not null default now()
);

create table if not exists public.leaderboard (
  user_id uuid primary key references auth.users(id) on delete cascade,
  nickname text not null default 'Block Player',
  trophies integer not null default 0,
  wins integer not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.saves enable row level security;
alter table public.leaderboard enable row level security;

-- profiles: каждый видит профили, но меняет только свой
create policy "profiles_select_all" on public.profiles for select using (true);
create policy "profiles_insert_own" on public.profiles for insert with check (auth.uid() = id);
create policy "profiles_update_own" on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);

-- saves: приватное облачное сохранение
create policy "saves_select_own" on public.saves for select using (auth.uid() = user_id);
create policy "saves_insert_own" on public.saves for insert with check (auth.uid() = user_id);
create policy "saves_update_own" on public.saves for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- leaderboard: читать можно всем, писать только за себя
create policy "leaderboard_select_all" on public.leaderboard for select using (true);
create policy "leaderboard_insert_own" on public.leaderboard for insert with check (auth.uid() = user_id);
create policy "leaderboard_update_own" on public.leaderboard for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
