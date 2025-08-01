-- 1. Leagues
CREATE TABLE League (
  league_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(100),
  season VARCHAR(20) NOT NULL    -- e.g., '2024/2025'
);

-- 2. Teams
CREATE TABLE Team (
  team_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  city VARCHAR(100),
  founded_year INT
);

-- 3. Players
CREATE TABLE Player (
  player_id SERIAL PRIMARY KEY,
  full_name VARCHAR(150) NOT NULL,
  date_of_birth DATE,
  nationality VARCHAR(100),
  position VARCHAR(50)  -- e.g., 'Forward', 'Midfielder'
);

-- 4. Team in League (association, since teams participate in a league season)
CREATE TABLE League_Team (
  league_team_id SERIAL PRIMARY KEY,
  league_id INT REFERENCES League(league_id) ON DELETE CASCADE,
  team_id INT REFERENCES Team(team_id) ON DELETE CASCADE,
  points INT DEFAULT 0,
  played INT DEFAULT 0,
  wins INT DEFAULT 0,
  draws INT DEFAULT 0,
  losses INT DEFAULT 0,
  goals_for INT DEFAULT 0,
  goals_against INT DEFAULT 0
);

-- 5. Squad membership (which players are in which team and since when)
CREATE TABLE Squad (
  squad_id SERIAL PRIMARY KEY,
  player_id INT REFERENCES Player(player_id) ON DELETE CASCADE,
  team_id INT REFERENCES Team(team_id) ON DELETE CASCADE,
  join_date DATE,
  leave_date DATE  -- nullable if still in team
);

-- 6. Matches
CREATE TABLE Match (
  match_id SERIAL PRIMARY KEY,
  league_id INT REFERENCES League(league_id) ON DELETE CASCADE,
  match_date TIMESTAMP NOT NULL,
  home_team_id INT REFERENCES Team(team_id),
  away_team_id INT REFERENCES Team(team_id),
  home_team_goals INT DEFAULT 0,
  away_team_goals INT DEFAULT 0,
  venue VARCHAR(150)
);

-- 7. Events (goals, yellow/red cards, substitutions)
CREATE TABLE Event (
  event_id SERIAL PRIMARY KEY,
  match_id INT REFERENCES Match(match_id) ON DELETE CASCADE,
  event_minute INT CHECK (event_minute >= 0),
  event_type VARCHAR(50) NOT NULL,  -- 'Goal', 'Yellow Card', 'Red Card', 'Substitution'
  player_id INT REFERENCES Player(player_id),
  assisting_player_id INT,           -- nullable, for goals
  related_team_id INT REFERENCES Team(team_id),  -- team associated with event
  description TEXT
);
