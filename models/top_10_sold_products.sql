WITH StoreTransactionTotal
AS (SELECT
		product_name,
		COUNT(*) total_count,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking
FROM {{ ref('events') }}
--where t.device_id  in (1,57,76)
GROUP BY 1
)
SELECT
  product_name,
  total_count
FROM StoreTransactionTotal
WHERE ranking <= 10