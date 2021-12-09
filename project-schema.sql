/**********************************************************************
 * NAME: Zach Sahlin
 * CLASS: CPSC 321 Fall 2021
 * DATE: 11/08/2021
 * HOMEWORK: 7
 * DESCRIPTION: Creates a database for skiing, and then populates it with data.
 **********************************************************************/

-- drop table statements
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS nearby_city;
DROP TABLE IF EXISTS snow;
DROP TABLE IF EXISTS weather;
DROP TABLE IF EXISTS run;
DROP TABLE IF EXISTS chairlift;
DROP TABLE IF EXISTS resort;

-- create table statements
-- represents a ski resort
CREATE TABLE resort(
    name VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    base_elev INT UNSIGNED,
    summit_elev INT UNSIGNED,
    acres INT UNSIGNED,
    pass VARCHAR(50),   -- if the resort is on a group pass, e.g. IKON, Epic
    PRIMARY KEY(name)
);

-- represents a ski run
CREATE TABLE run(
    name VARCHAR(50) NOT NULL,
    resort VARCHAR(50) NOT NULL,
    difficulty ENUM('green', 'blue', 'black', 'double black'),
    status ENUM('open', 'closed'),
    PRIMARY KEY(name, resort),
    FOREIGN KEY(resort) REFERENCES resort(name)
);

-- represents a chairlift
CREATE TABLE chairlift(
    name VARCHAR(50) NOT NULL,
    resort VARCHAR(50) NOT NULL,
    capacity INT UNSIGNED,     -- number of people that can fit on a seat
    status ENUM('open', 'closed'),
    PRIMARY KEY(name, resort),
    FOREIGN KEY(resort) REFERENCES resort(name)
);

-- represents a weather report
CREATE TABLE weather(
    resort VARCHAR(50) NOT NULL,
    report_time DATETIME NOT NULL,
    wind INT UNSIGNED,
    temp INT,
    precip ENUM('none', 'rain', 'snow'),
    PRIMARY KEY(resort, report_time),
    FOREIGN KEY(resort) REFERENCES resort(name)    
);

-- represents a snow report
CREATE TABLE snow(
    resort VARCHAR(50) NOT NULL,
    report_date DATE NOT NULL,
    total INT UNSIGNED, -- total inches of snow for current season
    12hr INT UNSIGNED,
    24hr INT UNSIGNED,
    48hr INT UNSIGNED,
    72hr INT UNSIGNED,
    PRIMARY KEY(resort, report_date),
    FOREIGN KEY(resort) REFERENCES resort(name)
);

-- represents a city nearby the resort
CREATE TABLE nearby_city(
    city_name VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL, -- name of the state/province the city is in
    resort VARCHAR(50) NOT NULL,
    min_away INT UNSIGNED NOT NULL,
    PRIMARY KEY(city_name, state, resort),
    FOREIGN KEY(resort) REFERENCES resort(name)
);

-- represents a lift ticket
CREATE TABLE ticket(
    resort VARCHAR(50) NOT NULL,
    age_min INT UNSIGNED NOT NULL,
    age_max INT UNSIGNED,
    price DECIMAL(7,2) UNSIGNED,
    type ENUM('day', 'season'),
    PRIMARY KEY(resort, age_min),
    FOREIGN KEY(resort) REFERENCES resort(name)
);

-- insert statements
-- resort data
INSERT INTO resort VALUES('Crystal', 'Washington', 'United States', 3912, 7012, 2600, 'IKON');
INSERT INTO resort VALUES('Schweitzer', 'Idaho', 'United States', 3989, 6389, 2900, 'IKON');
INSERT INTO resort VALUES('Stevens', 'Washington', 'United States', 4061, 5845, 1125, 'Epic');
INSERT INTO resort VALUES('Whistler', 'British Columbia', 'Canada', 2214, 7494, 8171, 'Epic');

-- run data
INSERT INTO run VALUES('Niagaras', 'Crystal', 'double black', 'closed');
INSERT INTO run VALUES('Lucky Shot', 'Crystal', 'blue', 'closed');
INSERT INTO run VALUES('Upper Northway', 'Crystal', 'black', 'closed');
INSERT INTO run VALUES('Snorting Elk', 'Crystal', 'black', 'closed');
INSERT INTO run VALUES('Paradise Bowl', 'Crystal', 'double black', 'closed');
INSERT INTO run VALUES('Powder Bowl', 'Crystal', 'double black', 'closed');
INSERT INTO run VALUES('Australia', 'Schweitzer', 'double black', 'open');
INSERT INTO run VALUES('Siberia', 'Schweitzer', 'double black', 'open');
INSERT INTO run VALUES('Snow Ghost', 'Schweitzer', 'blue', 'closed');

-- chairlift data
INSERT INTO chairlift VALUES('Mt. Rainier Gondola', 'Crystal', 8, 'open');
INSERT INTO chairlift VALUES('Chair 6', 'Crystal', 2, 'closed');
INSERT INTO chairlift VALUES('Northway', 'Crystal', 2, 'open');
INSERT INTO chairlift VALUES('Stella Express Six Pack', 'Schweitzer', 6, 'open');
INSERT INTO chairlift VALUES('Great Escape Quad', 'Schweitzer', 4, 'closed');
INSERT INTO chairlift VALUES('Colburn Triple', 'Schweitzer', 3, 'open');

-- weather data
INSERT INTO weather VALUES('Crystal', '2021-12-07 20:51:00', 3, 36, NULL);
INSERT INTO weather VALUES('Schweitzer', '2021-12-08 00:01:00', 3, 39, NULL);
INSERT INTO weather VALUES('Crystal', '2021-12-08 10:38:00', 2, 24, NULL);
INSERT INTO weather VALUES('Schweitzer', '2021-12-08 15:00:00', 15, 22, NULL);

-- snow data
INSERT INTO snow VALUES('Crystal', '2021-12-07', NULL, 0, 0, NULL, NULL);
INSERT INTO snow VALUES('Schweitzer', '2021-12-07', 34, 1, 1, 2, 2);
INSERT INTO snow VALUES('Crystal', '2021-12-08', NULL, 0, 0, NULL, NULL);
INSERT INTO snow VALUES('Schweitzer', '2021-12-08', 34, 0, 0, 1, 2);
INSERT INTO snow VALUES('Whistler', '2021-12-08', 109, 0, 1, 1, NULL);

-- nearby city data
INSERT INTO nearby_city VALUES('Seattle', 'Washington', 'Crystal', 118);
INSERT INTO nearby_city VALUES('Seattle', 'Washington', 'Stevens', 92);
INSERT INTO nearby_city VALUES('Spokane', 'Washington', 'Stevens', 231);
INSERT INTO nearby_city VALUES('Spokane', 'Washington', 'Schweitzer', 103);

-- ticket data
INSERT INTO ticket VALUES('Schweitzer', 18, 64, 110, 'day');
INSERT INTO ticket VALUES('Schweitzer', 7, 17, 60, 'day');
INSERT INTO ticket VALUES('Schweitzer', 65, 79, 104.5, 'day');
INSERT INTO ticket VALUES('Schweitzer', 0, 6, 0, 'day');
INSERT INTO ticket VALUES('Schweitzer', 80, NULL, 0, 'day');
INSERT INTO ticket VALUES('Crystal', 5, 12, 55, 'day');
INSERT INTO ticket VALUES('Crystal', 13, 22, 144, 'day');
INSERT INTO ticket VALUES('Crystal', 23, 69, 184, 'day');
INSERT INTO ticket VALUES('Crystal', 70, NULL, 55, 'day');
INSERT INTO ticket VALUES('Stevens', 5, 12, 73, 'day');
INSERT INTO ticket VALUES('Stevens', 13, 69, 109, 'day');
INSERT INTO ticket VALUES('Whistler', 7, 12, 70.38, 'day');
INSERT INTO ticket VALUES('Whistler', 13, 18, 119.41, 'day');
INSERT INTO ticket VALUES('Whistler', 19, 64, 140.76, 'day');
INSERT INTO ticket VALUES('Whistler', 65, NULL, 126.53, 'day');
INSERT INTO ticket VALUES('Crystal', 0, 4, 49, 'season');
INSERT INTO ticket VALUES('Crystal', 5, 12, 379, 'season');
INSERT INTO ticket VALUES('Crystal', 13, 22, 869, 'season');
INSERT INTO ticket VALUES('Crystal', 23, 79, 1149, 'season');
INSERT INTO ticket VALUES('Crystal', 80, NULL, 49, 'season');
INSERT INTO ticket VALUES('Schweitzer', 26, 79, 949, 'season');
INSERT INTO ticket VALUES('Schweitzer', 7, 17, 349, 'season');
INSERT INTO ticket VALUES('Schweitzer', 18, 25, 549, 'season');
INSERT INTO ticket VALUES('Schweitzer', 80, NULL, 39, 'season');
INSERT INTO ticket VALUES('Schweitzer', 0, 6, 39, 'season');
