-- Добавляем внешние ключи в БД football

use football;


-- 1. Для таблицы клубов
-- Смотрим структуру таблицы
-- DESC clubs;

-- Добавляем внешние ключи
ALTER TABLE clubs
	ADD CONSTRAINT clubs_country_id_fk
		FOREIGN KEY (country_id) REFERENCES countrys(id);

-- 2. Для таблицы игроков
-- Смотрим структуру таблицы
-- DESC players;

-- Добавляем внешние ключи
ALTER TABLE players 
	ADD CONSTRAINT players_country_id_fk
		FOREIGN KEY (country_id) REFERENCES countrys(id),
	ADD CONSTRAINT players_club_id_fk
		FOREIGN KEY (club_id) REFERENCES clubs(id),
	ADD CONSTRAINT players_pos_id_fk
		FOREIGN KEY (pos_id) REFERENCES positions(id),
	ADD CONSTRAINT players_amplua_id_fk
		FOREIGN KEY (amplua_id) REFERENCES amplua(id);
	
-- 3. Для таблицы профилей
-- Смотрим структуру таблицы
-- DESC profiles;

-- Добавляем внешние ключи
ALTER TABLE profiles
	ADD CONSTRAINT profiles_player_id_fk
		FOREIGN KEY (player_id) REFERENCES players(id)
			ON DELETE CASCADE;

-- 6. Для таблицы профилей
-- Смотрим структуру таблицы
-- DESC amplua;

-- Добавляем внешние ключи
ALTER TABLE amplua
	ADD CONSTRAINT amplua_position_id_fk
		FOREIGN KEY (position_id) REFERENCES positions(id);
		
-- 7. Для таблицы чемпионата
-- Смотрим структуру таблицы
-- DESC championship;

-- Добавляем внешние ключи
ALTER TABLE championship
	ADD CONSTRAINT championship_country_id_fk
		FOREIGN KEY (country_id) REFERENCES countrys(id)
			ON DELETE CASCADE;

-- 8. Для таблицы игр
-- Смотрим структуру таблицы
-- DESC games;

-- Добавляем внешние ключи
ALTER TABLE games
	ADD CONSTRAINT games_club_owner_id_fk
		FOREIGN KEY (club_owner_id) REFERENCES clubs(id)
			ON DELETE CASCADE,			
	ADD CONSTRAINT games_club_guest_id_fk
		FOREIGN KEY (club_guest_id) REFERENCES clubs(id)
			ON DELETE CASCADE;

-- 9. Для таблицы событий матча
-- Смотрим структуру таблицы
-- DESC march_events;

-- Добавляем внешние ключи
ALTER TABLE march_events
	ADD CONSTRAINT march_events_game_id_fk
		FOREIGN KEY (game_id) REFERENCES games(id)
			ON DELETE CASCADE,			
	ADD CONSTRAINT march_events_player_id_fk
		FOREIGN KEY (player_id) REFERENCES players(id);
		