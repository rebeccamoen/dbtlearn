-- Import raw_listings

-- CTE: Load raw listing data from the defined source
WITH raw_listings AS (
    -- Direct reference to raw table
    -- SELECT * FROM AIRBNB.RAW.RAW_LISTINGS

    -- dbt source reference defined in sources.yml
    SELECT * FROM {{ source('airbnb', 'listings') }}
)

-- Main query: Select and rename columns from the raw data
SELECT
    ID AS listing_id,         -- Rename ID to listing_id for consistency and clarity
    LISTING_URL,              -- URL of the listing
    NAME AS listing_name,     -- Rename NAME to listing_name
    ROOM_TYPE,                -- Type of room (e.g., entire home, private room)
    MINIMUM_NIGHTS,           -- Minimum nights required for booking
    HOST_ID,                  -- ID of the host
    PRICE AS price_str,       -- Raw price string, kept as-is for later cleaning
    CREATED_AT,               -- Timestamp when the listing was created
    UPDATED_AT                -- Timestamp of the last update to the listing
FROM
    raw_listings
