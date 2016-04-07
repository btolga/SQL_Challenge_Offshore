#USE world;
#SELECT *
#FROM City

USE offshore;

CREATE TABLE IF NOT EXISTS countriesNW
(
country_id INT,
country_code VARCHAR(1000),
country_name VARCHAR(1000)
); 

CREATE TABLE IF NOT EXISTS node_countriesNW
(
NODEID1 INT,
country_code VARCHAR(1000),
country_name VARCHAR(1000),
country_id INT
); 

CREATE TABLE IF NOT EXISTS edges_1DNW
(
Unique_ID INT,
Entity_ID1 INT,
Entity_ID2 INT,
description_ VARCHAR(200),
date_from DATETIME,
date_to DATETIME,
direction INT,
chinesePos VARCHAR(200),
linktype VARCHAR(20)
CHARACTER SET utf8 
); 
