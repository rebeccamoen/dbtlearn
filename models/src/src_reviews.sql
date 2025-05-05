-- Import raw_reviews

-- CTE: Load raw review data directly from the AIRBNB.RAW schema
WITH raw_reviews AS (
    -- Direct reference to raw table
    -- SELECT * FROM AIRBNB.RAW.RAW_REVIEWS

    -- dbt source reference defined in sources.yml
    SELECT * FROM {{ source('airbnb', 'reviews') }}
)

-- Main query: Select and rename fields for clarity and consistency
SELECT
    LISTING_ID,                         -- ID of the listing this review belongs to
    DATE AS review_date,               -- Rename DATE to review_date for clarity
    REVIEWER_NAME,                     -- Name of the person who left the review
    COMMENTS AS review_text,           -- Rename COMMENTS to review_text
    SENTIMENT AS review_sentiment      -- Sentiment label (e.g., positive, neutral, negative)
FROM
    raw_reviews
