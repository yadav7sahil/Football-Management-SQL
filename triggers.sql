-- ##########################
-- 4. Triggers for Functionality
-- ##########################

-- 4.1 Trigger to Update League Standings After a Match
CREATE OR REPLACE FUNCTION update_standings_after_match() RETURNS trigger AS $$
BEGIN
  -- Update home team stats
  UPDATE League_Team
  SET played = played + 1,
      goals_for = goals_for + NEW.home_team_goals,
      goals_against = goals_against + NEW.away_team_goals,
      wins = wins + CASE WHEN NEW.home_team_goals > NEW.away_team_goals THEN 1 ELSE 0 END,
      draws = draws + CASE WHEN NEW.home_team_goals = NEW.away_team_goals THEN 1 ELSE 0 END,
      losses = losses + CASE WHEN NEW.home_team_goals < NEW.away_team_goals THEN 1 ELSE 0 END,
      points = points + CASE
                          WHEN NEW.home_team

