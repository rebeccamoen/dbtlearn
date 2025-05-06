-- Test to check for reviews submitted before the listing was created

-- Select all review records
SELECT r.* 
FROM {{ ref('fct_reviews') }} r

-- Join with the listings table to get the created_at date for each listing
LEFT JOIN {{ ref('dim_listings_clean') }} l
  ON r.listing_id = l.listing_id

-- Filter: find any reviews that were created before the listing was created (data quality issues)
WHERE r.review_date < l.created_at


-- Alternative version: INNER JOIN where both listing and review exist (unmatched data is excluded)
-- SELECT *
-- FROM {{ ref('dim_listings_clean') }} l
-- INNER JOIN {{ ref('fct_reviews') }} r
-- USING (listing_id)
-- WHERE l.created_at >= r.review_date