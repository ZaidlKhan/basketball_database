--
-- 	Database Table Creation
--
--	This file will create the tables for use.
--

drop table Game;
drop table Coach;
drop table Player;
drop table TeamMember;
drop table Owns;
drop table Sponsors;
drop table HasPlayed;
drop table Team;
drop table Owner;
drop table Age;
drop table Location;
drop table Season;
drop table Sponsor;
drop table Referee;
drop table StatSheet;



CREATE TABLE Location (
 arena CHAR(20) PRIMARY KEY,
 city CHAR(20) NOT NULL
);

-- removed city, added foreign key ref to Location
CREATE TABLE Team (
 tid INT PRIMARY KEY,
 name CHAR(20) NOT NULL,
 arena CHAR(20) NOT NULL,
 FOREIGN KEY (arena) REFERENCES Location(arena)
);

-- changed primary key to age
CREATE TABLE Age(
 dob DATE NOT NULL,
 age INT PRIMARY KEY
);

-- removed cid
CREATE TABLE TeamMember (
 tmid INT PRIMARY KEY NOT NULL,
 name CHAR(20) NOT NULL,
 tid INT NOT NULL,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 salary INT NOT NULL,
 age INT NOT NULL,
 FOREIGN KEY (tid) REFERENCES Team(tid) ON DELETE CASCADE,
 FOREIGN KEY (age) REFERENCES Age(age) ON DELETE CASCADE
);

-- renamed tmid to pid
CREATE TABLE Player (
 pid INT PRIMARY KEY,
 position CHAR(10),
 FOREIGN KEY (pid) REFERENCES TeamMember(tmid)
);


-- add tid fkey reference
CREATE TABLE Coach (
 tmid INT PRIMARY KEY,
 tid INT NOT NULL,
 FOREIGN KEY (tmid) REFERENCES TeamMember(tmid),
 FOREIGN KEY (tid) REFERENCES Team(tid)
);

CREATE TABLE Season (
 year INT PRIMARY KEY,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 CHECK (start_date <= end_date)
);

-- added age ref
CREATE TABLE Owner (
 name CHAR(20) PRIMARY KEY,
 age INT NOT NULL,
 net_worth INT DEFAULT 0,
 FOREIGN KEY (age) REFERENCES Age(age)
);

CREATE TABLE Owns (
 oname CHAR(20),
 tid INT,
 PRIMARY KEY (oname, tid),
 FOREIGN KEY (oname) REFERENCES Owner(name),
 FOREIGN KEY (tid) REFERENCES Team(tid)
);

CREATE TABLE Sponsor (
 name CHAR(20) PRIMARY KEY,
 contribution INT DEFAULT 0
);

CREATE TABLE Sponsors (
 sname CHAR(20),
 tid INT,
 PRIMARY KEY (sname, tid),
 FOREIGN KEY (sname) REFERENCES Sponsor(name),
 FOREIGN KEY (tid) REFERENCES Team(tid)
); 

CREATE TABLE HasPlayed (
 home_tid INT,
 away_tid INT,
 PRIMARY KEY (home_tid, away_tid),
 FOREIGN KEY (home_tid) REFERENCES Team(tid),
 FOREIGN KEY (away_tid) REFERENCES Team(tid)
);

CREATE TABLE Referee (
 rid INT PRIMARY KEY,
 name CHAR(20) NOT NULL,
 experience_years INT DEFAULT 0
);

CREATE TABLE StatSheet (
 ssid INT PRIMARY KEY,
 home_points INT DEFAULT 0,
 away_points INT DEFAULT 0,
 home_steals INT DEFAULT 0,
 away_steals INT DEFAULT 0,
 home_assists INT DEFAULT 0,
 away_assists INT DEFAULT 0,
 home_rebounds INT DEFAULT 0,
 away_rebounds INT DEFAULT 0
);

CREATE TABLE Game (
 game_date date,
 home_tid INT,
 away_tid INT,
 score CHAR(10),
 ssid INT,
 year INT,
 rid INT,
 arena CHAR(20),
 PRIMARY KEY (game_date, home_tid, away_tid),
 FOREIGN KEY (home_tid) REFERENCES Team(tid),
 FOREIGN KEY (away_tid) REFERENCES Team(tid),
 FOREIGN KEY (ssid) REFERENCES StatSheet(ssid),
 FOREIGN KEY (year) REFERENCES Season(year),
 FOREIGN KEY (rid) REFERENCES Referee(rid),
 FOREIGN KEY (arena) REFERENCES Location(arena)
);

INSERT INTO Location (arena, city) VALUES ('Staples Center', 'Los Angeles');
INSERT INTO Location (arena, city) VALUES ('Chase Center', 'Golden State');
INSERT INTO Location (arena, city) VALUES ('TD Garden', 'Boston');
INSERT INTO Location (arena, city) VALUES ('United Center', 'Chicago');
INSERT INTO Location (arena, city) VALUES ('Toyota Center', 'Houston');

INSERT INTO Team (tid, name, arena) VALUES (1, 'Lakers', 'Staples Center');
INSERT INTO Team (tid, name, arena) VALUES (2, 'Warriors', 'Chase Center');
INSERT INTO Team (tid, name, arena) VALUES (3, 'Celtics', 'TD Garden');
INSERT INTO Team (tid, name, arena) VALUES (4, 'Bulls', 'United Center');
INSERT INTO Team (tid, name, arena) VALUES (5, 'Rockets', 'Toyota Center');


INSERT INTO Age (dob, age) VALUES ('1990-05-15', 32);
INSERT INTO Age (dob, age) VALUES ('1985-08-22', 37);
INSERT INTO Age (dob, age) VALUES ('1995-02-10', 27);
INSERT INTO Age (dob, age) VALUES ('1980-11-05', 42);
INSERT INTO Age (dob, age) VALUES ('1992-06-18', 30);
INSERT INTO Age (dob, age) VALUES ('1988-09-30', 34);
INSERT INTO Age (dob, age) VALUES ('1998-04-25', 24);
INSERT INTO Age (dob, age) VALUES ('1982-03-12', 40);
INSERT INTO Age (dob, age) VALUES ('1993-07-08', 29);
INSERT INTO Age (dob, age) VALUES ('1987-01-20', 35);

INSERT INTO TeamMember values (1, 'LeBron James', 1, '2022-01-01', '2023-12-31', 40000000, 37);
INSERT INTO TeamMember values (2, 'Stephen Curry', 1, '2022-01-01', '2023-12-31', 43000000, 33);
INSERT INTO TeamMember values (3, 'Jayson Tatum', 1, '2022-01-01', '2023-12-31', 32000000, 24);
INSERT INTO TeamMember values (4, 'Zach LaVine', 1, '2022-01-01', '2023-12-31', 28000000, 26);
INSERT INTO TeamMember values (5, 'James Harden', 1, '2022-01-01', '2023-12-31', 38000000, 32);
INSERT INTO TeamMember values (6, 'Jimmy Butler', 1, '2022-01-01', '2023-12-31', 34000000, 32);
INSERT INTO TeamMember values (7, 'DeMar DeRozan', 1, '2022-01-01', '2023-12-31', 25000000, 32);
INSERT INTO TeamMember values (8, 'Pascal Siakam', 1, '2022-01-01', '2023-12-31', 29000000, 28);
INSERT INTO TeamMember values (9, 'Julius Randle', 1, '2022-01-01', '2023-12-31', 26000000, 27);
INSERT INTO TeamMember values (10, 'Gilgeous Alexander', 1, '2022-01-01', '2023-12-31', 22000000, 23);
INSERT INTO TeamMember values (11, 'Klay Thompson', 2, '2022-01-01', '2023-12-31', 38000000, 32);
INSERT INTO TeamMember values (12, 'Draymond Green', 2, '2022-01-01', '2023-12-31', 33000000, 31);
INSERT INTO TeamMember values (13, 'Andrew Wiggins', 2, '2022-01-01', '2023-12-31', 27000000, 26);
INSERT INTO TeamMember values (14, 'Kelly Oubre Jr.', 2, '2022-01-01', '2023-12-31', 22000000, 25);
INSERT INTO TeamMember values (15, 'James Wiseman', 2, '2022-01-01', '2023-12-31', 24000000, 21);
INSERT INTO TeamMember values (16, 'Jordan Poole', 2, '2022-01-01', '2023-12-31', 18000000, 23);
INSERT INTO TeamMember values (17, 'Juan Toscano-Anderson', 2, '2022-01-01', '2023-12-31', 15000000, 28);
INSERT INTO TeamMember values (18, 'Nemanja Bjelica', 2, '2022-01-01', '2023-12-31', 12000000, 33);
INSERT INTO TeamMember values (19, 'Moses Moody', 2, '2022-01-01', '2023-12-31', 10000000, 20);
INSERT INTO TeamMember values (20, 'Andre Iguodala', 2, '2022-01-01', '2023-12-31', 12000000, 38);
INSERT INTO TeamMember values (21, 'Jaylen Brown', 3, '2022-01-01', '2023-12-31', 35000000, 25);
INSERT INTO TeamMember values (22, 'Marcus Smart', 3, '2022-01-01', '2023-12-31', 24000000, 28);
INSERT INTO TeamMember values (23, 'Al Horford', 3, '2022-01-01', '2023-12-31', 26000000, 35);
INSERT INTO TeamMember values (24, 'Robert Williams III', 3, '2022-01-01', '2023-12-31', 18000000, 24);
INSERT INTO TeamMember values (25, 'Dennis Schroder', 3, '2022-01-01', '2023-12-31', 15000000, 28);
INSERT INTO TeamMember values (26, 'Josh Richardson', 3, '2022-01-01', '2023-12-31', 12000000, 28);
INSERT INTO TeamMember values (27, 'Grant Williams', 3, '2022-01-01', '2023-12-31', 8000000, 23);
INSERT INTO TeamMember values (28, 'Romeo Langford', 3, '2022-01-01', '2023-12-31', 7000000, 22);
INSERT INTO TeamMember values (29, 'Aaron Nesmith', 3, '2022-01-01', '2023-12-31', 6000000, 22);
INSERT INTO TeamMember values (30, 'Payton Pritchard', 3, '2022-01-01', '2023-12-31', 5000000, 23);
INSERT INTO TeamMember values (31, 'DeMar DeRozan', 4, '2022-01-01', '2023-12-31', 33000000, 32);
INSERT INTO TeamMember values (32, 'Zach LaVine', 4, '2022-01-01', '2023-12-31', 28000000, 26);
INSERT INTO TeamMember values (33, 'Nikola Vucevic', 4, '2022-01-01', '2023-12-31', 26000000, 31);
INSERT INTO TeamMember values (34, 'Lonzo Ball', 4, '2022-01-01', '2023-12-31', 20000000, 24);
INSERT INTO TeamMember values (35, 'Coby White', 4, '2022-01-01', '2023-12-31', 15000000, 22);
INSERT INTO TeamMember values (36, 'Patrick Williams', 4, '2022-01-01', '2023-12-31', 12000000, 20);
INSERT INTO TeamMember values (37, 'Alex Caruso', 4, '2022-01-01', '2023-12-31', 10000000, 28);
INSERT INTO TeamMember values (38, 'Javonte Green', 4, '2022-01-01', '2023-12-31', 8000000, 28);
INSERT INTO TeamMember values (39, 'Thaddeus Young', 4, '2022-01-01', '2023-12-31', 12000000, 33);
INSERT INTO TeamMember values (40, 'Troy Brown Jr.', 4, '2022-01-01', '2023-12-31', 7000000, 22);
INSERT INTO TeamMember values (41, 'Christian Wood', 5, '2022-01-01', '2023-12-31', 28000000, 26);
INSERT INTO TeamMember values (42, 'John Wall', 5, '2022-01-01', '2023-12-31', 41000000, 31);
INSERT INTO TeamMember values (43, 'Jalen Green', 5, '2022-01-01', '2023-12-31', 18000000, 19);
INSERT INTO TeamMember values (44, 'Kevin Porter Jr.', 5, '2022-01-01', '2023-12-31', 22000000, 21);
INSERT INTO TeamMember values (45, 'Daniel Theis', 5, '2022-01-01', '2023-12-31', 12000000, 29);
INSERT INTO TeamMember values (46, 'Eric Gordon', 5, '2022-01-01', '2023-12-31', 18000000, 33);
INSERT INTO TeamMember values (47, 'David Nwaba', 5, '2022-01-01', '2023-12-31', 8000000, 28);
INSERT INTO TeamMember values (48, 'Armoni Brooks', 5, '2022-01-01', '2023-12-31', 7000000, 22);
INSERT INTO TeamMember values (49, 'Khyri Thomas', 5, '2022-01-01', '2023-12-31', 6000000, 25);
INSERT INTO TeamMember values (50, 'Alperen Sengun', 5, '2022-01-01', '2023-12-31', 5000000, 19);


INSERT INTO Player (pid, position) VALUES (1, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (2, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (3, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (4, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (5, 'Coach');
INSERT INTO Player (pid, position) VALUES (6, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (7, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (8, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (9, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (10, 'Center');
INSERT INTO Player (pid, position) VALUES (11, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (12, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (13, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (14, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (15, 'Center');
INSERT INTO Player (pid, position) VALUES (16, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (17, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (18, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (19, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (20, 'Center');
INSERT INTO Player (pid, position) VALUES (21, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (22, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (23, 'Coach');
INSERT INTO Player (pid, position) VALUES (24, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (25, 'Center');
INSERT INTO Player (pid, position) VALUES (26, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (27, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (28, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (29, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (30, 'Center');
INSERT INTO Player (pid, position) VALUES (31, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (32, 'Coach');
INSERT INTO Player (pid, position) VALUES (33, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (34, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (35, 'Center');
INSERT INTO Player (pid, position) VALUES (36, 'Coach');
INSERT INTO Player (pid, position) VALUES (37, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (38, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (39, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (40, 'Center');
INSERT INTO Player (pid, position) VALUES (41, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (42, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (43, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (44, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (45, 'Center');
INSERT INTO Player (pid, position) VALUES (46, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (47, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (48, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (49, 'Power Forward');
INSERT INTO Player (pid, position) VALUES (50, 'Center');
INSERT INTO Player (pid, position) VALUES (51, 'Coach');
INSERT INTO Player (pid, position) VALUES (52, 'Point Guard');
INSERT INTO Player (pid, position) VALUES (53, 'Shooting Guard');
INSERT INTO Player (pid, position) VALUES (54, 'Small Forward');
INSERT INTO Player (pid, position) VALUES (55, 'Center');


INSERT INTO Coach (tmid, tid) VALUES ( 5, 1);
INSERT INTO Coach (tmid, tid) VALUES ( 23, 2);
INSERT INTO Coach (tmid, tid) VALUES ( 32, 3);
INSERT INTO Coach (tmid, tid) VALUES ( 36, 4);
INSERT INTO Coach (tmid, tid) VALUES ( 51, 5);

INSERT INTO Season (year, start_date, end_date) VALUES (2015, '2015-10-01', '2016-04-15');
INSERT INTO Season (year, start_date, end_date) VALUES (2016, '2016-10-25', '2017-04-12');
INSERT INTO Season (year, start_date, end_date) VALUES (2017, '2017-10-17', '2018-04-11');
INSERT INTO Season (year, start_date, end_date) VALUES (2018, '2018-10-16', '2019-04-10');
INSERT INTO Season (year, start_date, end_date) VALUES (2019, '2019-10-22', '2020-04-15');

INSERT INTO Owner (name, age, net_worth) VALUES ('Magic Johnson', 62, 7000000);
INSERT INTO Owner (name, age, net_worth) VALUES ('Joe Lacob', 65, 5000000);
INSERT INTO Owner (name, age, net_worth) VALUES ('Wyc Grousbeck', 63, 40000000);
INSERT INTO Owner (name, age, net_worth) VALUES ('Jerry Reinsdorf', 85, 1500000);
INSERT INTO Owner (name, age, net_worth) VALUES ('Robert Pera', 44, 1100000);

INSERT INTO Owns (oname, tid) VALUES ('Magic Johnson', 1);
INSERT INTO Owns (oname, tid) VALUES ('Joe Lacob', 2);
INSERT INTO Owns (oname, tid) VALUES ('Wyc Grousbeck', 3);
INSERT INTO Owns (oname, tid) VALUES ('Jerry Reinsdorf', 4);
INSERT INTO Owns (oname, tid) VALUES ('Robert Pera', 5);

INSERT INTO Sponsor (name, contribution) VALUES ('Nike', 5000000);
INSERT INTO Sponsor (name, contribution) VALUES ('Adidas', 3000000);
INSERT INTO Sponsor (name, contribution) VALUES ('Coca-Cola', 2000000);
INSERT INTO Sponsor (name, contribution) VALUES ('Verizon', 1500000);
INSERT INTO Sponsor (name, contribution) VALUES ('IBM', 1000000);

INSERT INTO Sponsors (sname, tid) VALUES ('Nike', 1);
INSERT INTO Sponsors (sname, tid) VALUES ('Adidas', 2);
INSERT INTO Sponsors (sname, tid) VALUES ('Coca-Cola', 3);
INSERT INTO Sponsors (sname, tid) VALUES ('Verizon', 4);
INSERT INTO Sponsors (sname, tid) VALUES ('IBM', 5);

INSERT INTO HasPlayed (home_tid, away_tid) VALUES (1, 2);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (2, 3);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (3, 4);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (4, 5);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (5, 1);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (2, 4);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (3, 5);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (1, 3);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (4, 1);
INSERT INTO HasPlayed (home_tid, away_tid) VALUES (5, 2);

INSERT INTO Referee (rid, name, experience_years) VALUES (1, 'John Smith', 5);
INSERT INTO Referee (rid, name, experience_years) VALUES (2, 'Emily Johnson', 8);
INSERT INTO Referee (rid, name, experience_years) VALUES (3, 'Michael Davis', 6);
INSERT INTO Referee (rid, name, experience_years) VALUES (4, 'Sarah Wilson', 10);
INSERT INTO Referee (rid, name, experience_years) VALUES (5, 'David Brown', 3);
INSERT INTO Referee (rid, name, experience_years) VALUES (6, 'Jessica Miller', 7);
INSERT INTO Referee (rid, name, experience_years) VALUES (7, 'Brian Taylor', 9);
INSERT INTO Referee (rid, name, experience_years) VALUES (8, 'Amanda Clark', 4);
INSERT INTO Referee (rid, name, experience_years) VALUES (9, 'Christopher White', 2);
INSERT INTO Referee (rid, name, experience_years) VALUES (10, 'Ashley Harris', 5);

INSERT INTO StatSheet VALUES (1, 105, 100, 8, 6, 25, 20, 45, 38);
INSERT INTO StatSheet VALUES (2, 110, 112, 10, 9, 28, 24, 40, 42);
INSERT INTO StatSheet VALUES (3, 95, 98, 7, 8, 22, 18, 38, 41);
INSERT INTO StatSheet VALUES (4, 120, 118, 12, 10, 30, 26, 44, 39);
INSERT INTO StatSheet VALUES (5, 98, 105, 6, 7, 20, 22, 36, 40);
INSERT INTO StatSheet VALUES (6, 112, 108, 9, 8, 26, 23, 42, 37);
INSERT INTO StatSheet VALUES (7, 105, 102, 8, 9, 24, 21, 39, 40);
INSERT INTO StatSheet VALUES (8, 115, 112, 11, 10, 29, 25, 41, 38);
INSERT INTO StatSheet VALUES (9, 100, 96, 7, 6, 23, 19, 37, 35);
INSERT INTO StatSheet VALUES (10, 118, 115, 10, 11, 27, 24, 43, 41);

INSERT INTO Game VALUES ('2016-01-15', 1, 2, '105-100', 1, 2016, 1, 'Staples Center');
INSERT INTO Game VALUES ('2017-02-20', 2, 3, '110-112', 2, 2017, 2, 'Chase Center');
INSERT INTO Game VALUES ('2015-03-10', 3, 4, '95-98', 3, 2015, 3, 'TD Garden');
INSERT INTO Game VALUES ('2016-04-05', 4, 5, '120-118', 4, 2016, 4, 'United Center');
INSERT INTO Game VALUES ('2019-05-02', 5, 1, '98-105', 5, 2019, 5, 'Toyota Center');
INSERT INTO Game VALUES ('2019-06-18', 2, 4, '112-108', 6, 2019, 6, 'Chase Center');
INSERT INTO Game VALUES ('2016-07-12', 3, 5, '105-102', 7, 2016, 7, 'TD Garden');
INSERT INTO Game VALUES ('2017-08-28', 1, 3, '115-112', 8, 2017, 8, 'Staples Center');
INSERT INTO Game VALUES ('2017-09-14', 4, 1, '100-96', 9, 2017, 9, 'United Center');
INSERT INTO Game VALUES ('2018-10-30', 5, 2, '118-115', 10, 2018, 10, 'Toyota Center');




