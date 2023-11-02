SELECT
		store_country
        ,store_typology
        ,ROUND(AVG(t_amount),2) avg_transacted_amount
FROM {{ ref('events') }}
GROUP BY 1,2

