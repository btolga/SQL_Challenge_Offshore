
USE offshore;
SHOW tables;

SELECT * FROM countriesNW LIMIT 10;
SELECT * FROM edges_1DNW LIMIT 10;
SELECT * FROM node_countriesNW LIMIT 10;
SELECT * FROM nodesNW LIMIT 10;



## Question 1 WHICH COUNTRIES MOST NODES ARE FROM?
SELECT country_code, COUNT(*) AS counts 
FROM node_countriesNW
GROUP BY country_code
HAVING COUNT(*) > 10000
ORDER BY counts DESC;


## Now that we know the countries with most transactions lets see 
##how much of these nodes going out vs going in 



#LOAD DATA LOCAL INFILE '/Users/tolga/SQL_Challenge/data/countriesNW.csv' INTO TABLE countriesNW
#	FIELDS TERMINATED BY ';' 
#	LINES TERMINATED BY '\r\n'
#	IGNORE 1 LINES
#	(country_id,country_code,country_name);
