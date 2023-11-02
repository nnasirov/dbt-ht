WITH
Transactions AS (
  SELECT
    T.t_id AS transaction_id,
    t.t_store_id AS store_id,
    transaction_created_at
  FROM {{ ref('events') }} T
),
Rankedtransactions AS (
  SELECT
  	transaction_id,
  	store_id,
  	transaction_created_at::timestamp as transaction_created_at,
  	ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY transaction_created_at ) AS transaction_rank,
  FROM Transactions
),

--Select FIRST_VALUE(transaction_created_at) OVER (PARTITION BY store_id) AS MIN_TRANSACTION_CREATED_AT from Rankedtransactions where store_id = 5
min_max_date AS (
SELECT
    store_id,
    transaction_id,
    transaction_created_at,
    FIRST_VALUE(transaction_created_at) OVER (PARTITION BY store_id) AS MIN_TRANSACTION_CREATED_AT
  FROM RankedTransactions
  WHERE transaction_rank <= 5
)

SELECT
  store_id,
  AVG(EXTRACT(DAY FROM (transaction_created_at - MIN_TRANSACTION_CREATED_AT))) AS average_time_day_to_5_transactions
FROM min_max_date
GROUP BY store_id