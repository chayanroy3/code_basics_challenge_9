SELECT 
    fact_events.product_code, 
    dim_products.product_name
FROM 
    retail_events_db.fact_events
INNER JOIN 
    retail_events_db.dim_products 
ON 
    dim_products.product_code = fact_events.product_code
WHERE 
    promo_type = "BOGOF" 
    AND base_price > 500;

SELECT 
    city, 
    COUNT(1) AS No_of_store
FROM 
    retail_events_db.dim_stores
GROUP BY 
    city
ORDER BY 
    No_of_store DESC;

SELECT 
    dim_campaigns.campaign_name,
    SUM(fact_events.base_price * fact_events.`quantity_sold(before_promo)`) AS "total_revenue(before_promotion)",
    SUM(fact_events.base_price * fact_events.`quantity_sold(after_promo)`) AS "total_revenue(after_promotion)"
FROM 
    retail_events_db.fact_events
INNER JOIN 
    retail_events_db.dim_campaigns ON dim_campaigns.campaign_id = fact_events.campaign_id
GROUP BY 
    dim_campaigns.campaign_name;


WITH ranked_categories AS (
    SELECT 
        dim_products.category,
        (fact_events.`quantity_sold(after_promo)` - fact_events.`quantity_sold(before_promo)`) * 100.0 / fact_events.`quantity_sold(before_promo)` AS "ISU%",
        DENSE_RANK() OVER (ORDER BY (fact_events.`quantity_sold(after_promo)` - fact_events.`quantity_sold(before_promo)`) * 100.0 / fact_events.`quantity_sold(before_promo)` DESC) AS rank_order
    FROM 
        retail_events_db.fact_events
    INNER JOIN 
        retail_events_db.dim_products ON dim_products.product_code = fact_events.product_code
    WHERE
		fact_events.campaign_id="CAMP_DIW_01"
    GROUP BY 
        dim_products.category
)
SELECT 
    category,
    `ISU%`,
    rank_order
FROM 
    ranked_categories;

WITH revenue AS (
    SELECT
        SUM(fact_events.base_price * fact_events.`quantity_sold(before_promo)`) AS "total_revenue(before_promotion)",
        SUM(fact_events.base_price * fact_events.`quantity_sold(after_promo)`) AS "total_revenue(after_promotion)",
        fact_events.product_code
    FROM
        retail_events_db.fact_events
    GROUP BY
        fact_events.product_code
)			
SELECT 	
    dim_products.product_name,
    dim_products.category,
    (revenue.`total_revenue(after_promotion)` - revenue.`total_revenue(before_promotion)`) * 100 / revenue.`total_revenue(before_promotion)` AS "ir%"
FROM 	
    revenue
INNER JOIN 
    retail_events_db.dim_products ON dim_products.product_code = revenue.product_code
ORDER BY
    `ir%` DESC
LIMIT
    5;

