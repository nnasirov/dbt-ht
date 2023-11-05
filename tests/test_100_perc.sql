SELECT *
FROM (Select SUM(percentage_of_transactions) as sum_perc
      from {{ ref('perc_per_device') }})
WHERE sum_perc<100