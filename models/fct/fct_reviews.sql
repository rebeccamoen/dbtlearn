-- dbt model configuration
-- This model will be materialized as an incremental table
-- It will fail if the schema of the underlying source changes
{{
    config(
        materialized = 'incremental',
        on_schema_change='fail'
    )
}}

-- CTE: Load all records from the source model 'src_reviews'
WITH src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)

-- Main query: Select only reviews where the review_text is not null
SELECT * FROM src_reviews
WHERE review_text IS NOT NULL

-- Incremental logic: Only insert new rows from src_reviews where review_date is newer than the most recent date we already have
-- {{ this }} refers to the current dbt model in the database
-- This condition is applied only when dbt is running in incremental mode
{% if is_incremental() %}
  AND review_date > (SELECT MAX(review_date) FROM {{ this }})
{% endif %}
