USE football;

-- Сгенерируем результаты чемпионата
-- Предположем, что в одном матче забивается не более 5 голов

UPDATE games SET
 	goals_o = FLOOR(0 + RAND()*6),
 	goals_g = FLOOR(0 + RAND()*6);
 
-- Таблица бомбардиров
SELECT
	CONCAT(players.last_name, ' ', players.first_name) Name,
	clubs.name Club,
	SUM(goal) AS total
FROM march_events
JOIN players JOIN clubs
ON player_id = players.id AND clubs.id = players.club_id
GROUP BY player_id
ORDER BY total
DESC LIMIT 10;

-- Таблица самых грубых игроков чемпионата
SELECT
	CONCAT(players.last_name, ' ', players.first_name) Name,
	clubs.name Club,
	SUM(red_card) as red_card
FROM march_events
JOIN players JOIN clubs
ON player_id = players.id AND clubs.id = players.club_id
GROUP BY player_id
ORDER BY red_card
DESC LIMIT 10;

-- Результаты 5го тура English_Premier_League
-- Вложенный:
SELECT 
	(SELECT clubs.name FROM clubs WHERE clubs.id = club_owner_id) AS host,
	goals_o '-', goals_g '-',	 
	(SELECT clubs.name FROM clubs WHERE clubs.id = club_guest_id) AS guest
FROM games
WHERE chemp_id = 1 AND tour = 5;

-- Результаты 38го тура English_Premier_League
-- JOIN:
SELECT clubs_owner.name host, goals_o '-', goals_g '-', clubs_guest.name guest
FROM games
JOIN clubs AS clubs_owner
	ON games.club_owner_id = clubs_owner.id 
JOIN clubs AS clubs_guest
	ON games.club_guest_id = clubs_guest.id
WHERE chemp_id = 1 AND tour = 38;