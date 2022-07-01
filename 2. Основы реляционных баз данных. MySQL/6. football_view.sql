USE football;

--  ��������� ������� ������� English_Premier_League
DROP VIEW IF EXISTS english_premier_league;
CREATE VIEW english_premier_league AS SELECT 
	DISTINCT clubs.name as Club, 
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id AND goals_o > goals_g) AS won_owner, -- ������ ����
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id AND goals_o < goals_g) AS won_guest, -- ������ � ������
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id AND goals_o = goals_g) AS drawn_owner, --  ����� ����
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id AND goals_o = goals_g) AS drawn_guest, --  ����� � ������
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id AND goals_o < goals_g) AS lost_owner, -- ��������� ����
	(SELECT COUNT(*) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id AND goals_o > goals_g) AS lost_guest,-- ��������� � ������
	(SELECT SUM(goals_o) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id) AS for_owner, -- ������� ���� ����
	(SELECT SUM(goals_g) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id) AS for_guest,-- ������� ���� � ������
	(SELECT SUM(goals_g) FROM games WHERE chemp_id = 1 AND clubs.id = club_owner_id) AS against_owner,-- ����������� ���� ����
	(SELECT SUM(goals_o) FROM games WHERE chemp_id = 1 AND clubs.id = club_guest_id) AS against_guest -- ����������� ���� � ������
FROM clubs
JOIN games
	ON clubs.id = club_owner_id OR clubs.id = club_guest_id;

-- SELECT * FROM english_premier_league;

-- ��������������� ��������� ������� English_Premier_League
DROP VIEW IF EXISTS champ_epl;
CREATE VIEW champ_epl AS SELECT
	Club '����',
	won_owner + won_guest + drawn_owner + drawn_guest + lost_owner + lost_guest '�',
	won_owner + won_guest '�',
	drawn_owner + drawn_guest '�',
	lost_owner + lost_guest '�',
	CONCAT(for_owner + for_guest, ' - ', against_owner + against_guest) '�',
	won_owner *3 + won_guest * 3 + drawn_owner + drawn_guest AS O
FROM english_premier_league
ORDER BY O DESC;

SELECT * FROM champ_epl;

