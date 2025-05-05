-- dbt model configuration
{{ config(materialized='view') }}

-- CTE: Load all data from the source model 'src_listings'
WITH src_listings AS (
    SELECT * FROM {{ ref('src_listings') }}
)

-- Main query: Transform and clean listing data from the source
SELECT
    listing_id,             -- Unique identifier for the listing
    listing_name,           -- Name/title of the listing
    ROOM_TYPE,              -- Type of room offered (e.g., entire home, private room)

    -- Clean minimum_nights: If value is 0 (invalid), replace it with 1
    CASE
        WHEN MINIMUM_NIGHTS = 0 THEN 1
        ELSE MINIMUM_NIGHTS
    END AS MINIMUM_NIGHTS,

    HOST_ID,                -- ID of the host who owns the listing

    -- Clean and convert price: Remove '$' and cast to numeric with 2 decimal places
    REPLACE(price_str, '$') :: NUMBER(10, 2) AS price,

    CREATED_AT,             -- Timestamp when the listing record was created
    UPDATED_AT              -- Timestamp when the listing was last updated
FROM src_listings
