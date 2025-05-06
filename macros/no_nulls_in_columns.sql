-- Macro to find rows in a model where any column has a NULL value
{% macro no_nulls_in_columns(model) %}

    -- Begin a SELECT query from the given model
    SELECT * FROM {{ model }} WHERE

        -- Loop through all columns in the model and check each for NULL values
        -- The -% trims whitespace after each loop iteration for cleaner SQL
        {% for col in adapter.get_columns_in_relation(model) -%}
            {{ col.column }} IS NULL OR
        {% endfor %}

    -- Add FALSE to safely close the WHERE clause after the final OR
    FALSE

{% endmacro %}