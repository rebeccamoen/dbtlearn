-- dbt model configuration
{{ config(materialized='view') }}

-- CTE: Load all data from the source model 'src_hosts'
WITH src_hosts AS (
    SELECT * FROM {{ ref('src_hosts') }}
)

-- Main query: Clean and standardize host data
SELECT
    host_id,  -- Unique identifier for the host

    -- Replace null values in host_name with 'Anonymous'
    -- Note: NVL works in Oracle/Snowflake; use COALESCE in other SQL dialects
    NVL(host_name, 'Anonymous') AS host_name,

    IS_SUPERHOST,  -- Boolean flag indicating if the host is a superhost

    CREATED_AT,    -- Timestamp when the host record was created
    UPDATED_AT     -- Timestamp when the host record was last updated
FROM src_hosts
