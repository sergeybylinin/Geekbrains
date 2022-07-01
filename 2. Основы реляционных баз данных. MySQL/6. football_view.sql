USE football;

--  Подробная таблица таблица English_Premier_League
DROP VIEW IF EXISTS english_premier_league;
CREATE VIEW english_premier_league AS SELECT 
	DISTINCT clubs.name as Club, 
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id AND goals_o > goals_g) AS won_owner, -- Победы дома
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id AND goals_o < goals_g) AS won_guest, -- Победы в гостях
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id AND goals_o = goals_g) AS drawn_owner, --  Нечьи дома
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id AND goals_o = goals_g) AS drawn_guest, --  Нечьи в гостях
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id AND goals_o < goals_g) AS lost_owner, -- Поражения дома
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id AND goals_o > goals_g) AS lost_guest,-- Поражения в гостях
	(SELECT SUM(goals_o) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id) AS for_owner, -- Забитые мячи дома
	(SELECT SUM(goals_g) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id) AS for_guest,-- Забитые мячи в гостях
	(SELECT SUM(goals_g) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id) AS against_owner,-- Пропущенные мячи дома
	(SELECT SUM(goals_o) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id) AS against_guest -- Пропущенные мячи в гостях
FROM clubs
JOIN games
	ON clubs.id = club_owner_id OR clubs.id = club_guest_id;

-- SELECT * FROM english_premier_league;

-- Отсортированная турнирная таблица English_Premier_League
DROP VIEW IF EXISTS champ_epl;
CREATE VIEW champ_epl AS SELECT
	Club 'Клуб',
	won_owner + won_guest + drawn_owner + drawn_guest + lost_owner + lost_guest 'И',
	won_owner + won_guest 'В',
	drawn_owner + drawn_guest 'Н',
	lost_owner + lost_guest 'П',
	CONCAT(for_owner + for_guest, ' - ', against_owner + against_guest) 'М',
	won_owner *3 + won_guest * 3 + drawn_owner + drawn_guest AS O
FROM english_premier_league
ORDER BY O DESC;

SELECT * FROM champ_epl;

