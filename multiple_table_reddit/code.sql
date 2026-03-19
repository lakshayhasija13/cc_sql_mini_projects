-- TASK 1 : Overview of datasets
SELECT *
FROM users 
LIMIT 10;
SELECT *
FROM posts
LIMIT 10;
SELECT *
FROM subreddits
LIMIT 10;

-- TASK 2 : Identifying Primary Keys and Foreign Keys
-- USERS :
-- -- PRIMARY KEY : id 
-- POSTS
-- -- PRIMARY KEY : id
-- -- FOREIGN KEY : user_id, subreddit_id
-- SUBREDDITS
-- -- PRIMARY KEY : id 

-- TASK 3: NUMBER OF DIFFRENT SUBREDDITS 
SELECT COUNT(DISTINCT name)
FROM subreddits;

-- TASK 4: USER MAX SCORE, POST MAX SCORE, TOP 5 SUBREDDITS
SELECT MAX(score)
FROM users;
SELECT MAX(score)
FROM posts;
SELECT name, subscriber_count 
FROM subreddits
ORDER BY subscriber_count DESC
LIMIT 5;

-- TASK 5: LEFT JOIN OF users AND posts ORDERED BY NUMBER OF POSTS DESC 
SELECT  username, COUNT(*) AS 'posts_made'
FROM users
LEFT JOIN posts 
ON posts.user_id = users.id
GROUP BY username
ORDER BY COUNT(*) DESC;

-- TASK 6: INNER JOIN users AND posts
-- SELECT *
-- FROM users
-- INNER JOIN posts 
-- ON posts.user_id = users.id

-- TASK 7: STACK POSTS AND POSTS2 TO SEE NEW POSTS
SELECT *
FROM posts
UNION 
SELECT *
FROM posts2;

-- TASK 8: ALL POPULAR POSTS AND THEIR SUBREDDITS
WITH popular_posts AS (
  SELECT *
  FROM POSTS
  WHERE score >= 5000
)
SELECT subreddits.name, popular_posts.title, popular_posts.score
FROM subreddits
INNER JOIN popular_posts
  ON subreddits.id = popular_posts.subreddit_id
ORDER BY popular_posts.score DESC;

-- TASK 9: HIGH SCORING POST FOR EACH SUBREDDIT
SELECT subreddits.id, MAX(score)
FROM posts
INNER JOIN subreddits
ON posts.subreddit_id = subreddits.id
GROUP BY 1;

-- TASK 10: AVERAGE SCORE FOR ALL SUBREDDITS
SELECT subreddits.name, AVG(score)
FROM posts 
JOIN subreddits
ON posts.subreddit_id = subreddits.id
GROUP BY subreddits.name;

