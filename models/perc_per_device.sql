{% set device = 'main.device' %}

SELECT
  D.type AS device_type,
  COUNT(t.t_id) AS total_transactions,
  ROUND((COUNT(t.t_id) * 100.0 / SUM(COUNT(t.t_id)) OVER ()),2) AS percentage_of_transactions
FROM {{ device }} D
LEFT JOIN {{ ref('events') }} T ON D.id = T.t_device_id
GROUP BY D.type
