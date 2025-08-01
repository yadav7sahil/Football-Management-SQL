-- ##########################
-- 3. Queries for Functionalities
-- ##########################

-- 3.1 View League Standings
SELECT
  t.name AS team,
  lt.played,
  lt.wins,
  lt.draws,
  lt.losses,
  lt.goals_for,
  lt.goals_against,
  lt.points
FROM League_Team lt
JOIN Team t ON lt.team_id = t.team_id
WHERE lt.league_id = 1
ORDER BY lt.points DESC, (lt.goals_for - lt.goals_against) DESC;

-- 3.2 Top Goal Scorers in a League
SELECT p.full_name, COUNT(*) AS goals_scored
FROM Event e
JOIN Match m ON e.match_id = m.match_id
JOIN Player p ON e.player_id = p.player_id
WHERE e.event_type = 'Goal' AND m.league_id = 1
GROUP BY p.full_name
ORDER BY goals_scored DESC
LIMIT 10;

-- 3.3 Match Event Summary (Goals, Cards, etc.)
SELECT
  m.match_id,
  ht.name AS home_team,
  at.name AS away_team,
  m.home_team_goals,
  m.away_team_goals,
  e.event_minute,
  e.event_type,
  p.full_name AS player,
  e.description
FROM Match m
LEFT JOIN Team ht ON m.home_team_id = ht.team_id
LEFT JOIN Team at ON m.away_team_id = at.team_id
LEFT JOIN Event e ON m.match_id = e.match_id
LEFT JOIN Player p ON e.player_id = p.player_id
WHERE m.match_id = 1
ORDER BY e.event_minute;

-- 3.4 Players with Most Yellow/Red Cards
SELECT
  p.full_name,
  SUM(CASE WHEN e.event_type = 'Yellow Card' THEN 1 ELSE 0 END) AS yellow_cards,
  SUM(CASE WHEN e.event_type = 'Red Card' THEN 1 ELSE 0 END) AS red_cards
FROM Event e
JOIN Player p ON e.player_id = p.player_id
GROUP BY p.full_name
ORDER BY red_cards DESC, yellow_cards DESC;

-- 3.5 Schedule Matches (Simple Match Creation)
INSERT INTO Match (league_id, match_date, home_team_id, away_team_id, home_team_goals, away_team_goals, venue)
VALUES (1, '2025-02-15 17:30:00', 1, 2, 0, 0, 'Old Trafford');

-- 3.6 Player Performance Tracking (Goals scored per player)
SELECT
  p.full_name,
  COUNT(*) AS goals_scored
FROM Event e
JOIN Player p ON e.player_id = p.player_id
WHERE e.event_type = 'Goal'
GROUP BY p.full_name
ORDER BY goals_scored DESC;
