-- Define a snapshot: used to track historical changes to the listings table over time
{% snapshot scd_raw_listings %}

-- Snapshot configuration
{{
    config(
        target_schema='dev',
        unique_key='id',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}

-- Source data for the snapshot: raw listings from the airbnb source
SELECT * FROM {{ source('airbnb', 'listings') }}

-- End snapshot definition
{% endsnapshot %}