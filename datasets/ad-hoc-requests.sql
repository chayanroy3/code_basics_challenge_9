-- ###########################################################################
-- Question 1
-- ###########################################################################
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
    
-- ##############################################################################
-- Question 2
-- ##############################################################################
SELECT 
    city, 
    COUNT(1) AS No_of_store
FROM 
    retail_events_db.dim_stores
GROUP BY 
    city
ORDER BY 
    No_of_store DESC;

-- ################################################################################
-- Quention 3
-- ################################################################################
with discounted as(
SELECT
    promo_type,
    campaign_id,
    base_price,
    `quantity_sold(before_promo)`,
    `quantity_sold(after_promo)`,
    CASE
        WHEN promo_type = '50% OFF' THEN base_price * 0.5
        WHEN promo_type = '25% OFF' THEN base_price * 0.75
        WHEN promo_type = 'BOGOF' THEN base_price * 0.5
        WHEN promo_type = '500 Cashback' THEN base_price - 500
        WHEN promo_type = '33% OFF' THEN base_price * 0.67
    END AS discounted_price
FROM
    retail_events_db.fact_events
)
SELECT 
    dim_campaigns.campaign_name,
    ROUND(SUM(discounted.base_price * discounted.`quantity_sold(before_promo)`)/1000000,2) AS "total_revenue(before_promotion)",
    ROUND(SUM(discounted.discounted_price * discounted.`quantity_sold(after_promo)`)/1000000,2) AS "total_revenue(after_promotion)"
FROM 
    discounted
INNER JOIN 
    retail_events_db.dim_campaigns ON dim_campaigns.campaign_id = discounted.campaign_id
GROUP BY 
    dim_campaigns.campaign_name;

-- ################################################################################
-- Quention 4
-- ################################################################################
WITH 
ranked_categories AS (
    SELECT 
        dim_products.category,
        (sum(fact_events.`quantity_sold(after_promo)`) - sum(fact_events.`quantity_sold(before_promo)`)) * 100.0 / sum(fact_events.`quantity_sold(before_promo)`) AS "ISU%"
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
    RANK() OVER (ORDER BY `ISU%` DESC) AS rank_order
FROM 
    ranked_categories;



-- ################################################################################
-- Quention 5
-- ################################################################################
WITH discounted as (
SELECT
    promo_type,
    base_price,
    event_id,
    `quantity_sold(before_promo)`,
    `quantity_sold(after_promo)`,
    CASE
        WHEN promo_type = '50% OFF' THEN base_price * 0.5
        WHEN promo_type = '25% OFF' THEN base_price * 0.75
        WHEN promo_type = 'BOGOF' THEN base_price * 0.5
        WHEN promo_type = '500 Cashback' THEN base_price - 500
        WHEN promo_type = '33% OFF' THEN base_price * 0.67
    END AS discounted_price
FROM
    retail_events_db.fact_events
),
revenue AS (
    SELECT
        SUM(fact_events.base_price * fact_events.`quantity_sold(before_promo)`) AS "total_revenue(before_promotion)",
        SUM(discounted.discounted_price * fact_events.`quantity_sold(after_promo)`) AS "total_revenue(after_promotion)",
        fact_events.product_code
    FROM
        retail_events_db.fact_events
	INNER JOIN discounted ON discounted.event_id=fact_events.event_id
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

