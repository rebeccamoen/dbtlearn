-- Test to identify listings with invalid minimum_nights values (less than 1 day)

-- Select rows from the dim_listings_clean model
SELECT * 
FROM {{ ref('dim_listings_clean') }}

-- Filter: only include listings with less than 1 minimum night (invalid data)
WHERE minimum_nights < 1

-- Limit results to 10 rows for quick review
LIMIT 10
