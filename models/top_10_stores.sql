--Top 10 stores per transacted amount
WITH StoreTransactionTotal
AS (SELECT
		store_name,
		SUM(t_amount) total_amount,
		RANK() OVER (ORDER BY SUM(t_amount) DESC) AS ranking
FROM {{ ref('events') }}
--where t.device_id  in (1,57,76)
GROUP BY 1
)
SELECT
  store_name,
  total_amount
FROM StoreTransactionTotal
WHERE ranking <= 10