-- TASK 3: Create a temporary table of months (Jan–Mar 2017)
WITH months AS (
  SELECT '2017-01-01' AS first_day, '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01', '2017-02-28'
  UNION
  SELECT '2017-03-01', '2017-03-31'
),

-- TASK 4: Cross join subscriptions with months to evaluate each user per month
cross_join AS (
  SELECT *
  FROM months
  CROSS JOIN subscriptions
),

-- TASK 5 & 6:
-- Create status table with:
-- - Active users per segment
-- - Canceled users per segment
status AS (
  SELECT
    id,
    segment,
    first_day,

    -- TASK 5:
    -- Check if a user is active at the start of the month
    CASE 
      WHEN subscription_start < first_day
           AND (subscription_end IS NULL OR subscription_end >= first_day)
      THEN 1 ELSE 0 
    END AS is_active,

    -- TASK 6:
    -- Check if a user canceled during the month
    CASE 
      WHEN subscription_end BETWEEN first_day AND last_day
      THEN 1 ELSE 0 
    END AS is_canceled

  FROM cross_join
),

-- TASK 7:
-- Aggregate active and canceled users per segment per month
status_aggregate AS (
  SELECT
    segment,
    first_day,
    SUM(is_active) AS sum_active,
    SUM(is_canceled) AS sum_canceled
  FROM status
  GROUP BY segment, first_day
)

-- TASK 8:
-- Calculate churn rate = canceled / active
SELECT
  segment,
  first_day,
  sum_active,
  sum_canceled,
  CASE 
    WHEN sum_active = 0 THEN 0
    ELSE sum_canceled * 1.0 / sum_active
  END AS churn_rate
FROM status_aggregate
ORDER BY segment, first_day;
