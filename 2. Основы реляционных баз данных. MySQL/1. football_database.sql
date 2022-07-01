-- База данных "футбол" состоит из 9 таблиц (страны, клубы, игроки, профили, позиции, амплуа, чемпионаты, игры и события в матчах).
-- База данных "футбол" предназначена для получения данных футбольной статики.

-- Создаём БД
DROP DATABASE IF EXISTS football;
CREATE DATABASE football;

-- Делаем её текущей
USE football;

-- -----------------1-----------------
-- Создаем таблицу клубов
DROP TABLE IF EXISTS clubs;
CREATE TABLE clubs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	name VARCHAR(255) NOT NULL COMMENT 'Название команды',
	sity VARCHAR(255) NOT NULL COMMENT 'Город',
	country_id TINYINT UNSIGNED NOT NULL COMMENT 'Ссылка на страну',
	budget INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Бюджет клуба',
	count_ INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Стоимость клуба', -- Общая стоимость всех футболистов + бюджет
	avg_skills TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Средний навык игроков клуба',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Футбольные клубы';

-- -----------------2-----------------
-- Создаем таблицу игроков
DROP TABLE IF EXISTS players;
CREATE TABLE players (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	first_name VARCHAR(255) NOT NULL COMMENT 'Имя игрока',
	last_name VARCHAR(255) NOT NULL COMMENT 'Фамилия игрока',
	country_id TINYINT UNSIGNED NOT NULL COMMENT 'Ссылка на страну',
	club_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на клуб',
	pos_id TINYINT UNSIGNED NOT NULL COMMENT 'Ссылка на позицию',
	amplua_id TINYINT UNSIGNED NOT NULL COMMENT 'Ссылка на амплуа',
	skill TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Общий навык', -- от 1 до 100
	count_ INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Стоимость игока',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Игроки';
	
-- -----------------3-----------------
-- Таблица профилей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	player_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Ссылка на пользователя',
	working_leg BOOL DEFAULT 1 COMMENT 'Рабочая нога',-- 1-правая, 0-левая
	pac TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Скорость',-- от 1 до 100
	sho TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Удар',-- от 1 до 100
	pas TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Передачи',-- от 1 до 100
	dri TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Дриблинг',-- от 1 до 100
	def TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Защита',-- от 1 до 100
	phy TINYINT UNSIGNED NOT NULL DEFAULT 10 COMMENT 'Физика',-- от 1 до 100
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Профили';

-- -----------------4-----------------
-- Создаем таблицу национальных государств
DROP TABLE IF EXISTS countrys;
CREATE TABLE countrys (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	name VARCHAR(255) NOT NULL COMMENT 'Название страны',
	reduction_name	CHAR(3) NOT NULL COMMENT 'Сокращенное название страны',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Страны';

-- -----------------5-----------------
-- Создаем таблицу игровых позиций
DROP TABLE IF EXISTS positions;
CREATE TABLE positions (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	name VARCHAR(255) NOT NULL COMMENT 'Название позиции',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Позиции';

-- -----------------6-----------------
-- Создаем таблицу амплуа игроков
DROP TABLE IF EXISTS amplua;
CREATE TABLE amplua (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	position_id TINYINT UNSIGNED NOT NULL COMMENT 'Ссылка на позицию',
	name VARCHAR(255) NOT NULL COMMENT 'Название амплуа',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Амплуа';

-- -----------------7-----------------
-- Создаем таблицу чемпионатов
CREATE TABLE championship (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	name VARCHAR(255) UNIQUE COMMENT 'Название чемпионата',
	country_id TINYINT UNSIGNED NOT NULL COMMENT 'Ссылка на страну',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Чемпионаты';

-- -----------------8-----------------
-- Создаем таблицу игр
DROP TABLE IF EXISTS games;
CREATE TABLE games (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	chemp_id INT UNSIGNED NOT NULL COMMENT 'Идентификатор строки',
	tour TINYINT UNSIGNED NOT NULL COMMENT 'Номер тура',
	club_owner_id INT UNSIGNED NOT NULL COMMENT 'Домашняя команда',
	goals_o TINYINT UNSIGNED DEFAULT NULL COMMENT 'Голы домашней команды', -- значение NULL пока матч не сыгран
	goals_g TINYINT UNSIGNED DEFAULT NULL COMMENT 'Голы гостевой команды', -- значение NULL пока матч не сыгран
	club_guest_id INT UNSIGNED NOT NULL COMMENT 'Гостевая команда',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Игры';

-- -----------------9-----------------
-- Создаем таблицу событий матча
DROP TABLE IF EXISTS march_events;
CREATE TABLE march_events(
	game_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на мач',
	player_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя',
	goal INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Гол',
	assist INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Голевой пас',
	yellow_card BOOL DEFAULT 0 COMMENT 'желтая карточка',
	red_card BOOL DEFAULT 0 COMMENT 'красная карточка',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Cобытия матча';