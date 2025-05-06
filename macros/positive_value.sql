-- Custom Generic Test to check that a column contains only positive values (>= 1)
{% test positive_value(model, column_name) %}

-- Select all rows where the given column has a value less than 1
-- If any rows are returned, the test will fail
SELECT * FROM {{ model }}
WHERE {{ column_name }} < 1

{% endtest %}