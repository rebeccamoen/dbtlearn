-- This model materializes as a table in the database
{{ config(
    materialized = 'table',
) }}

-- CTE: Load the fact reviews model (transformed review data)
WITH fct_reviews AS (
    SELECT * FROM {{ ref('fct_reviews') }}
),

-- CTE: Load the seed data that contains known full moon dates
full_moon_dates AS (
    SELECT * FROM {{ ref('seed_full_moon_dates') }}
)

-- Main query: Join review data with full moon dates
SELECT
    r.*,  -- Select all columns from the review fact table

    -- Add a new column indicating if the review was left on the day after a full moon
    CASE
        WHEN fm.full_moon_date IS NULL THEN 'not full moon'
        ELSE 'full moon'
    END AS is_full_moon

FROM fct_reviews r

-- Left join full moon dates to see if review_date is the day after a full moon
LEFT JOIN full_moon_dates fm
  ON TO_DATE(r.review_date) = DATEADD(DAY, 1, fm.full_moon_date)
