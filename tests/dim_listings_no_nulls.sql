-- Run the no_nulls_in_columns macro on dim_listings_clean
-- Returns rows where any column contains a NULL value

{{ no_nulls_in_columns(ref('dim_listings_clean')) }}