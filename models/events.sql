{% set transactions = 'main."transaction"' %}
{% set store = 'main.store' %}
{% set device = 'main.device' %}

{{ config(materialized='table') }}

with source_data as (

SELECT
	t.id AS t_id
	,d.id AS t_device_id
	,s.id AS t_store_id
    ,t.amount AS t_amount
	,t.product_name
	,t.product_sku
	,t.category_name
	,t.status AS t_status
	,t.created_at as t_created_at
    --for duckdb
    ,SUBSTRING(t_created_at, 7, 4) || '-' || SUBSTRING(t_created_at, 1, 2) || '-' || SUBSTRING(t_created_at, 4, 2) || ' ' || SUBSTRING(t_created_at, 12) AS transaction_created_at
	,t.happened_at as t_happened_at
	,d.type AS t_device_type
	,s.name AS store_name
	,s.city AS store_city
	,s.country AS store_country
	,s.typology AS store_typology
	,s.customer_id
FROM {{ transactions }} t
INNER JOIN {{ device }} d
	ON d.id = t.device_id
INNER JOIN {{ store }} s
	ON s.id = d.store_id

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
