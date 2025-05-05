-- CTE 'l': Load cleansed listing data
WITH l AS (SELECT * FROM {{ ref('dim_listings_clean') }}),

-- CTE 'h': Load cleansed host data
h AS (SELECT * FROM {{ ref('dim_hosts_clean') }})

-- Main query: Join listings with their corresponding host info
SELECT
    l.listing_id,                   -- Unique ID for each listing
    l.listing_name,                 -- Title or name of the listing
    l.room_type,                    -- Type of room offered (e.g. private, entire)
    l.minimum_nights,               -- Minimum nights required to book
    l.price,                        -- Price per night
    l.host_id,                      -- ID of the host who owns the listing
    h.host_name,                    -- Name of the host (joined from host table)
    h.is_superhost AS host_is_superhost,  -- Whether the host is a Superhost (renamed for clarity)
    l.created_at,                   -- When the listing was created

    -- Take the most recent update timestamp between listing and host
    GREATEST(l.updated_at, h.updated_at) AS updated_at

FROM l
LEFT JOIN h ON h.host_id = l.host_id  -- Join hosts onto listings using host_id
