USE football;

DELIMITER //

-- �������� ������� march_events 11� ������� �������� ������ �� ������ ���������� �����.
DROP PROCEDURE IF EXISTS write_march_events//
CREATE PROCEDURE write_march_events(IN id INT)
BEGIN
	-- �������� ������� march_events 11� ������� �������� ������ �� ������ ���������� �����.
	DECLARE i INT DEFAULT 0;
	WHILE i < 11 DO
	-- ������ �������� �������
		INSERT INTO march_events (game_id, player_id) VALUES (
			id, (
			SELECT players.id 
			FROM players JOIN games JOIN clubs
			ON players.club_id = clubs.id AND games.club_owner_id = clubs.id
			WHERE games.id = id 
			ORDER BY skill DESC
			LIMIT i, 1));
	-- ������ �������� �������
		INSERT INTO march_events (game_id, player_id) VALUES (
			id, (
			SELECT players.id 
			FROM players JOIN games JOIN clubs
			ON players.club_id = clubs.id AND games.club_guest_id = clubs.id
			WHERE games.id = id 
			ORDER BY skill DESC
			LIMIT i, 1));
		SET i = i + 1;
	END WHILE;
END//

-- ������� rand_player_game ��������� ������������� ������ �� ������� march_events �� ������ �����
-- �������� club ��������� �� ������� ������/�����
DROP FUNCTION IF EXISTS rand_player_game//
CREATE FUNCTION rand_player_game (id INT , club INT(1))
RETURNS INT READS SQL DATA
BEGIN
	RETURN (SELECT player_id
	FROM march_events 
	JOIN players JOIN games
	ON march_events.player_id = players.id AND march_events.game_id = games.id
	WHERE game_id = id AND
 		CASE	
			WHEN club =  1 THEN players.club_id = games.club_owner_id -- ��� ����������� �������
			WHEN club =  0 THEN players.club_id = games.club_guest_id -- ��� ������� ������
		END
	ORDER BY RAND()
	LIMIT 1);
END//

-- ��������� ���������� ������� march_events �����, ������� �������, ������ � ������� ��������
DROP PROCEDURE IF EXISTS update_march_events//
CREATE PROCEDURE update_march_events(IN id INT)
BEGIN
	DECLARE goal_owner INT DEFAULT 0;
	DECLARE goal_guest INT DEFAULT 0;
	DECLARE yellow_cards INT DEFAULT FLOOR(0 + RAND()*7); -- �� ����� 6 ������ �������� �� ����
	DECLARE red_cards INT DEFAULT FLOOR(0 + RAND()*2); -- �� ����� 1 ������� �������� �� ����
	-- ���� � �������� �������� �������
	WHILE goal_owner < (SELECT goals_o FROM games g WHERE g.id = id) DO
		SET @player_id = (SELECT rand_player_game(id, 1));
		UPDATE march_events SET
			goal = goal + 1
		WHERE game_id = id AND player_id = @player_id;
		SET @player_id = (SELECT rand_player_game(id, 1));
		UPDATE march_events SET
			assist = assist + 1
		WHERE game_id = id AND player_id = @player_id;
		SET goal_owner = goal_owner + 1;
	END WHILE;
	-- ���� � �������� �������� �������
	WHILE goal_guest < (SELECT goals_g FROM games g WHERE g.id = id) DO
		SET @player_id = (SELECT rand_player_game(id, 0));
		UPDATE march_events SET
			goal = goal + 1
		WHERE game_id = id AND player_id = @player_id;
		SET @player_id = (SELECT rand_player_game(id, 0));
		UPDATE march_events SET
			assist = assist + 1
		WHERE game_id = id AND player_id = @player_id;
		SET goal_guest = goal_guest + 1;
	END WHILE;
	-- ������ ��������
	WHILE yellow_cards > 0 DO
		SET @player_id = (SELECT rand_player_game(id, 1));
		UPDATE march_events SET
			yellow_card = yellow_card + 1
		WHERE game_id = id AND player_id = @player_id;
		SET @player_id = (SELECT rand_player_game(id, 0));
		UPDATE march_events SET
			yellow_card = yellow_card + 1
		WHERE game_id = id AND player_id = @player_id;
		SET yellow_cards = yellow_cards - 1;
	END WHILE;
	-- ������� ��������
	WHILE red_cards > 0 DO
		SET @player_id = (SELECT rand_player_game(id, 1));
		UPDATE march_events SET
			red_card = red_card + 1
		WHERE game_id = id AND player_id = @player_id;
		SET @player_id = (SELECT rand_player_game(id, 0));
		UPDATE march_events SET
			red_card = red_card + 1
		WHERE game_id = id AND player_id = @player_id;
		SET red_cards = red_cards - 1;
	END WHILE;
END//

DROP TRIGGER IF EXISTS games_update_trg//
CREATE TRIGGER games_update_trg AFTER UPDATE ON games
FOR EACH ROW
BEGIN 
	CALL write_march_events(OLD.id);
 	CALL update_march_events(OLD.id);
 END//
 
DELIMITER ;
