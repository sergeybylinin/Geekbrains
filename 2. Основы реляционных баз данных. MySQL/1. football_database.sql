-- ���� ������ "������" ������� �� 9 ������ (������, �����, ������, �������, �������, ������, ����������, ���� � ������� � ������).
-- ���� ������ "������" ������������� ��� ��������� ������ ���������� �������.

-- ������ ��
DROP DATABASE IF EXISTS football;
CREATE DATABASE football;

-- ������ � �������
USE football;

-- -----------------1-----------------
-- ������� ������� ������
DROP TABLE IF EXISTS clubs;
CREATE TABLE clubs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	name VARCHAR(255) NOT NULL COMMENT '�������� �������',
	sity VARCHAR(255) NOT NULL COMMENT '�����',
	country_id TINYINT UNSIGNED NOT NULL COMMENT '������ �� ������',
	budget INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '������ �����',
	count_ INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '��������� �����', -- ����� ��������� ���� ����������� + ������
	avg_skills TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '������� ����� ������� �����',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '���������� �����';

-- -----------------2-----------------
-- ������� ������� �������
DROP TABLE IF EXISTS players;
CREATE TABLE players (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	first_name VARCHAR(255) NOT NULL COMMENT '��� ������',
	last_name VARCHAR(255) NOT NULL COMMENT '������� ������',
	country_id TINYINT UNSIGNED NOT NULL COMMENT '������ �� ������',
	club_id INT UNSIGNED NOT NULL COMMENT '������ �� ����',
	pos_id TINYINT UNSIGNED NOT NULL COMMENT '������ �� �������',
	amplua_id TINYINT UNSIGNED NOT NULL COMMENT '������ �� ������',
	skill TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '����� �����', -- �� 1 �� 100
	count_ INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '��������� �����',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '������';
	
-- -----------------3-----------------
-- ������� ��������
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	player_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT '������ �� ������������',
	working_leg BOOL DEFAULT 1 COMMENT '������� ����',-- 1-������, 0-�����
	pac TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '��������',-- �� 1 �� 100
	sho TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '����',-- �� 1 �� 100
	pas TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '��������',-- �� 1 �� 100
	dri TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '��������',-- �� 1 �� 100
	def TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '������',-- �� 1 �� 100
	phy TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT '������',-- �� 1 �� 100
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '�������';

-- -----------------4-----------------
-- ������� ������� ������������ ����������
DROP TABLE IF EXISTS countrys;
CREATE TABLE countrys (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	name VARCHAR(255) NOT NULL COMMENT '�������� ������',
	reduction_name	CHAR(3) NOT NULL COMMENT '����������� �������� ������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '������';

-- -----------------5-----------------
-- ������� ������� ������� �������
DROP TABLE IF EXISTS positions;
CREATE TABLE positions (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	name VARCHAR(255) NOT NULL COMMENT '�������� �������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '�������';

-- -----------------6-----------------
-- ������� ������� ������ �������
DROP TABLE IF EXISTS amplua;
CREATE TABLE amplua (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	position_id TINYINT UNSIGNED NOT NULL COMMENT '������ �� �������',
	name VARCHAR(255) NOT NULL COMMENT '�������� ������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '������';

-- -----------------7-----------------
-- ������� ������� �����������
CREATE TABLE championship (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	name VARCHAR(255) UNIQUE COMMENT '�������� ����������',
	country_id TINYINT UNSIGNED NOT NULL COMMENT '������ �� ������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '����������';

-- -----------------8-----------------
-- ������� ������� ���
DROP TABLE IF EXISTS games;
CREATE TABLE games (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	chemp_id INT UNSIGNED NOT NULL COMMENT '������������� ������',
	tour TINYINT UNSIGNED NOT NULL COMMENT '����� ����',
	club_owner_id INT UNSIGNED NOT NULL COMMENT '�������� �������',
	goals_o TINYINT UNSIGNED DEFAULT NULL COMMENT '���� �������� �������', -- �������� NULL ���� ���� �� ������
	goals_g TINYINT UNSIGNED DEFAULT NULL COMMENT '���� �������� �������', -- �������� NULL ���� ���� �� ������
	club_guest_id INT UNSIGNED NOT NULL COMMENT '�������� �������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT '����';

-- -----------------9-----------------
-- ������� ������� ������� �����
DROP TABLE IF EXISTS march_events;
CREATE TABLE march_events(
	game_id INT UNSIGNED NOT NULL COMMENT '������ �� ���',
	player_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������',
	goal INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '���',
	assist INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '������� ���',
	yellow_card BOOL DEFAULT 0 COMMENT '������ ��������',
	red_card BOOL DEFAULT 0 COMMENT '������� ��������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������'
) COMMENT 'C������ �����';