
USE offshore;
SHOW tables;

SELECT * FROM countriesNW LIMIT 10;
SELECT * FROM edges_1DNW LIMIT 10;
SELECT * FROM node_countriesNW LIMIT 10;
SELECT * FROM nodesNW LIMIT 10;



## Question 1 WHICH COUNTRIES MOST NODES ARE FROM?
SELECT country_name, COUNT(*) AS counts 
FROM node_countriesNW
GROUP BY country_name
HAVING COUNT(*) > 1000
ORDER BY counts DESC;


## Now that we know the countries with most transactions lets see 
##how much of these nodes going out vs going in 


# Number of edge directions
SELECT DISTINCT direction AS directions FROM edges_1DNW;
# 2: 0 > indegree 1> outdegree (?)


SELECT COUNT(Unique_ID) FROM edges_1DNW;
SELECT COUNT(Unique_ID) FROM nodesNW;

# Density of the Graph:

SELECT CAST((SELECT (SELECT COUNT(Unique_ID) FROM edges_1DNW)*2) /
	(SELECT (SELECT (SELECT COUNT(Unique_ID) FROM nodesNW) - 1) * (SELECT COUNT(Unique_ID) FROM nodesNW)) AS decimal(10,9))
	 AS density;

## WHICH COMPANIES/INDIVIDUALS ARE INVOLVED THE MOST?

SELECT Description_, COUNT(*) AS counts FROM nodesNW
GROUP BY Description_
ORDER BY counts DESC
LIMIT 20;



## table for the nodes for which the edges are going into. (their country names and
## the description of the edge going into them.)
SELECT node1.NODEID1, node1.country_name, edge1.Unique_ID, edge1.Entity_ID1, edge1.description_  
FROM (SELECT Unique_ID, Entity_ID1, Entity_ID2, description_ 
FROM edges_1DNW
WHERE direction = 1) AS edge1
LEFT JOIN node_countriesNW AS node1
ON node1.NODEID1 = edge1.Entity_ID1
LIMIT 10;


#SELECT COUNT(tb1.NODEID1) FROM 
#(SELECT node1.NODEID1, node1.country_name, edge1.Unique_ID, edge1.Entity_ID1, edge1.description_  
#FROM (SELECT Unique_ID, Entity_ID1, Entity_ID2, description_ 
#FROM edges_1DNW
#WHERE direction = 1) AS edge1
#LEFT JOIN node_countriesNW AS node1
#ON node1.NODEID1 = edge1.Entity_ID1 LIMIT 100) as tb1;



/*
SELECT node1.country_name, COUNT(node1.country_name) as counts
FROM (SELECT Entity_ID2
FROM edges_1DNW
WHERE direction = 1 LIMIT 15000) AS edge1
LEFT JOIN node_countriesNW AS node1
ON node1.NODEID1 = edge1.Entity_ID2
GROUP BY node1.country_name
ORDER BY counts DESC
LIMIT 20;


SELECT node1.country_name, COUNT(node1.country_name) as counts
FROM (SELECT Entity_ID1
FROM edges_1DNW
WHERE direction = 1 LIMIT 15000) AS edge1
LEFT JOIN node_countriesNW AS node1
ON node1.NODEID1 = edge1.Entity_ID1
GROUP BY node1.country_name
ORDER BY counts DESC
LIMIT 20;


SELECT node1.country_name, COUNT(node1.country_name) as counts
FROM (SELECT Entity_ID2
FROM edges_1DNW
WHERE direction = 0 LIMIT 15000) AS edge1
LEFT JOIN node_countriesNW AS node1
ON node1.NODEID1 = edge1.Entity_ID2
GROUP BY node1.country_name
ORDER BY counts DESC
LIMIT 20;


SELECT node1.country_name, COUNT(node1.country_name) as counts
FROM (SELECT Entity_ID1
FROM edges_1DNW
WHERE direction = 0 LIMIT 15000) AS edge1
LEFT JOIN node_countriesNW AS node1
ON node1.NODEID1 = edge1.Entity_ID1
GROUP BY node1.country_name
ORDER BY counts DESC
LIMIT 20;*/


## HOW MANY DISTINCT POSITIONS/ROLES CAN EDGES HAVE?
SELECT DISTINCT(description_) FROM edges_1DNW;

# Which Individuals/Companies Have the most out-going edges and 
# which countries they operate in?
SELECT Entity_ID1, counts, Description_, country_name
FROM(
SELECT Entity_ID1, counts, Description_ 
FROM (SELECT Entity_ID1, COUNT(*) AS counts FROM edges_1DNW
WHERE direction = 1
GROUP BY Entity_ID1
ORDER BY counts DESC
LIMIT 20) AS entities
LEFT JOIN nodesNW AS node
ON entities.Entity_ID1 = node.Unique_ID
LIMIT 10)AS entities2
LEFT JOIN node_countriesNW AS countries
ON entities2.Entity_ID1 = countries.NODEID1
ORDER BY entities2.counts DESC;


SELECT Entity_ID2, COUNT(*) AS counts FROM edges_1DNW
GROUP BY Entity_ID2
ORDER BY counts DESC
LIMIT 20;
