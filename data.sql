-- Leagues
INSERT INTO League (name, country, season) VALUES
('Premier League', 'England', '2024/2025'),
('La Liga', 'Spain', '2024/2025');

-- Teams
INSERT INTO Team (name, city, founded_year) VALUES
('Manchester United', 'Manchester', 1878),
('Liverpool', 'Liverpool', 1892),
('Real Madrid', 'Madrid', 1902),
('Barcelona', 'Barcelona', 1899);

-- Players
INSERT INTO Player (full_name, date_of_birth, nationality, position) VALUES
('Cristiano Ronaldo', '1985-02-05', 'Portuguese', 'Forward'),
('Lionel Messi', '1987-06-24', 'Argentinian', 'Forward'),
('Kevin De Bruyne', '1991-06-28', 'Belgian', 'Midfielder'),
('Sergio Ramos', '1986-03-30', 'Spanish', 'Defender');

-- League_Team (associate teams to Premier League)
INSERT INTO League_Team (league_id, team_id) VALUES
(1, 1), -- Man Utd
(1, 2), -- Liverpool
(2, 3), -- Real Madrid
(2, 4); -- Barcelona

-- Squads (simplified)
INSERT INTO Squad (player_id, team_id, join_date) VALUES
(1, 1, '2024-07-01'),
(2, 4, '2024-07-01'),
(3, 2, '2024-07-01'),
(4, 3, '2024-07-01');

-- Match example
INSERT INTO Match (league_id, match_date, home_team_id, away_team_id, home_team_goals, away_team_goals, venue)
VALUES (1, '2025-02-15 17:30:00', 1, 2, 2, 1, 'Old Trafford');

-- Events in that match
INSERT INTO Event (match_id, event_minute, event_type, player_id, assisting_player_id, related_team_id, description)
VALUES
(1, 23, 'Goal', 1, NULL, 1, 'Opened scoring with a header'),
(1, 45, 'Goal', 3, NULL, 2, 'Equalizer from outside box'),
(1, 78, 'Goal', 1, 3, 1, 'Winning goal assisted by midfielder');
