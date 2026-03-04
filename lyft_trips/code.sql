-- TASK 1
SELECT * FROM trips;
SELECT * FROM riders;
SELECT * FROM cars;

-- TASK 2
-- trips.id
-- riders.id
-- cars.id
-- primary keys

-- TASK 3
SELECT *
FROM riders
CROSS JOIN cars;

-- TASK 4
SELECT *
FROM trips
LEFT JOIN riders
ON trips.rider_id = riders.id;

-- TASK 5
SELECT *
FROM trips
INNER JOIN cars
ON trips.rider_id = cars.id;

-- TASK 6
SELECT *
FROM riders
UNION
SELECT *
FROM riders2;

-- TASK 7
SELECT AVG(cost)
FROM trips;

-- TASK 8
SELECT *
FROM riders
WHERE total_trips < 500
UNION
SELECT *
FROM riders2
WHERE total_trips < 500;

-- TASK 9
SELECT COUNT(*)
FROM cars
WHERE status = 'active';

-- TASK 10
SELECT *
FROM cars
ORDER BY trips_completed DESC
LIMIT 2;
