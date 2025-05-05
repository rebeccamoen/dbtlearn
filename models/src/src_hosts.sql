-- Import raw_hosts

-- CTE: Load raw host data directly from the AIRBNB.RAW schema
WITH raw_hosts AS (
    -- Direct reference to raw table
    -- SELECT * FROM AIRBNB.RAW.RAW_HOSTS

    -- dbt source reference defined in sources.yml
    SELECT * FROM {{ source('airbnb', 'hosts') }}
)

-- Main query: Select and rename fields for clarity and consistency
SELECT
    ID AS host_id,           -- Rename ID to host_id
    NAME AS host_name,       -- Rename NAME to host_name
    IS_SUPERHOST,            -- Boolean indicating whether host is a Superhost
    CREATED_AT,              -- Timestamp when the host record was created
    UPDATED_AT               -- Timestamp when the host record was last updated
FROM
    raw_hosts
