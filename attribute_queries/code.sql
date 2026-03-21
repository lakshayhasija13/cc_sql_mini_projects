/* TASK 1: Get familiar with CoolTShirts 
   How many campaigns and sources does CoolTShirts use? 
   Which source is used for each campaign?
*/

-- 1.1: Number of distinct campaigns
SELECT COUNT(DISTINCT utm_campaign) AS 'Total Campaigns'
FROM page_visits;

-- 1.2: Number of distinct sources
SELECT COUNT(DISTINCT utm_source) AS 'Total Sources'
FROM page_visits;

-- 1.3: Relationship between source and campaign
SELECT DISTINCT utm_source, utm_campaign
FROM page_visits;


/* TASK 2: What pages are on the website?
   Find the distinct values of the page_name column.
*/

SELECT DISTINCT page_name
FROM page_visits;


/* TASK 3: How many first touches is each campaign responsible for?
   Identifies which campaigns are best at initial customer acquisition.
*/

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_source AS 'Source',
       pv.utm_campaign AS 'Campaign',
       COUNT(ft.user_id) AS 'First Touches'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 3 DESC;


/* TASK 4: How many last touches is each campaign responsible for?
   Identifies which campaigns are bringing users back for their final visit.
*/
WITH last_touch AS (
  /* ... */),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
         pv.page_name
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;



/* TASK 5: How many visitors make a purchase?
   Count the distinct users who visited the page named '4 - purchase'.
*/

SELECT COUNT(DISTINCT user_id) AS 'Total Purchasers'
FROM page_visits
WHERE page_name = '4 - purchase';


/* TASK 6: How many last touches on the purchase page is each campaign responsible for?
   This attributes specific revenue/sales to each campaign.
*/

WITH last_touch AS (
  SELECT user_id,
         MAX(timestamp) AS last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id),
SELECT pv.utm_source,
       pv.utm_campaign,
       COUNT(lt.user_id) AS purchase_last_touches
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1, 2
ORDER BY 3 DESC;

