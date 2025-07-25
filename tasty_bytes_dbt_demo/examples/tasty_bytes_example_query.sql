-- What tables exist?
SHOW TABLES IN SCHEMA TASTY_BYTES_DBT_DB.dev;

-- What is the scale of data? 
SELECT COUNT(*) FROM TASTY_BYTES_DBT_DB.dev.raw_pos_order_header;

-- Understand a query that might be used in a mart
SELECT 
    cl.customer_id,
    cl.city,
    cl.country,
    cl.first_name,
    cl.last_name,
    cl.phone_number,
    cl.e_mail,
    SUM(oh.order_total) AS total_sales,
    ARRAY_AGG(DISTINCT oh.location_id) AS visited_location_ids_array
FROM TASTY_BYTES_DBT_DB.dev.customer_loyalty_metrics cl
JOIN TASTY_BYTES_DBT_DB.dev.orders oh
ON cl.customer_id = oh.customer_id
GROUP BY cl.customer_id, cl.city, cl.country, cl.first_name,
cl.last_name, cl.phone_number, cl.e_mail;