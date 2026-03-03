-- TRENDS IN STARTUPS
-- TASK 1
SELECT *
FROM startups;

-- TASK 2
SELECT COUNT(*)
FROM startups;

-- TASK 3
SELECT SUM(valuation)
FROM startups;

-- TASK 4
SELECT MAX(raised)
FROM startups;

-- TASK 5
SELECT MAX(raised)
FROM startups
WHERE stage = 'Seed';

-- TASK 6
SELECT MIN(founded)
FROM startups;

-- TASK 7
SELECT AVG(valuation)
FROM startups;

-- TASK 8
SELECT category, AVG(valuation)
FROM startups
GROUP BY category;

-- TASK 9
SELECT category, ROUND(AVG(valuation), 2)
FROM startups
GROUP BY category;

-- TASK 10
SELECT category, ROUND(AVG(valuation), 2)
FROM startups
GROUP BY category
ORDER BY 2 DESC;

-- TASK 11
SELECT category, COUNT(*)
FROM startups
GROUP BY category;

-- TASK 12
SELECT category, COUNT(*)
FROM startups
GROUP BY category
HAVING COUNT(*) > 3;

-- TASK 13
SELECT location, COUNT(*)
FROM startups
GROUP BY location;

-- TASK 14
SELECT location, COUNT(*)
FROM startups
GROUP BY location
HAVING COUNT(*) > 500;
