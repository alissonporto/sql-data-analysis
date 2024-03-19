# 1 - What is the number of hubs by city?
SELECT h.hub_city, COUNT(h.hub_id) as n_hubs
FROM order_deliveries.hubs as h
GROUP BY h.hub_city
ORDER BY h.hub_city;

# 2 - What is the number of orders by status?
SELECT od.order_status, COUNT(od.order_id) as n_orders
FROM order_deliveries.orders as od
GROUP BY od.order_status;


# 3 - What is the number of stores by hub city?
SELECT h.hub_city, COUNT(st.store_id) as n_stores
FROM order_deliveries.stores as st
INNER JOIN order_deliveries.hubs as h 
	ON st.hub_id = h.hub_id
GROUP BY h.hub_city
ORDER BY h.hub_city;


# 4 - What is the least and the greatest payment amounts?

# Amounts only
SELECT MAX(CAST(od.order_amount AS DECIMAL(18,2))) as max_od_value
FROM order_deliveries.orders as od;

SELECT MIN(CAST(od.order_amount AS DECIMAL(18,2))) as max_od_value
FROM order_deliveries.orders as od;

# Record(s) with amount
SELECT *
FROM order_deliveries.orders as od
WHERE CAST(od.order_amount AS DECIMAL(18,2)) = (
	SELECT MAX(CAST(od2.order_amount AS DECIMAL(18,2)))
	FROM order_deliveries.orders as od2
);

SELECT *
FROM order_deliveries.orders as od
WHERE CAST(od.order_amount AS DECIMAL(18,2)) = (
	SELECT MIN(CAST(od2.order_amount AS DECIMAL(18,2)))
	FROM order_deliveries.orders as od2
);


# 5a - What is the driver type that delivered more orders?
SELECT dr.driver_type, COUNT(de.delivery_id) as count_deliveries
FROM order_deliveries.deliveries as de
INNER JOIN order_deliveries.drivers as dr
	ON de.driver_id = dr.driver_id
GROUP BY dr.driver_type
ORDER BY count_deliveries DESC;

# 5b - Who is the driver who delivered more orders?
SELECT *
FROM order_deliveries.drivers as dr1
WHERE dr1.driver_id = (
	SELECT dr.driver_id
	FROM order_deliveries.deliveries as de
	INNER JOIN order_deliveries.drivers as dr
		ON de.driver_id = dr.driver_id
	GROUP BY dr.driver_id
	ORDER BY COUNT(de.delivery_id) DESC
    LIMIT 1
);


# 6 - What is the average delivery distance by driver modal?
SELECT dr.driver_type, ROUND(AVG(de.delivery_distance_meters), 2) avg_distance
FROM order_deliveries.deliveries as de
INNER JOIN order_deliveries.drivers as dr
	ON de.driver_id = dr.driver_id
GROUP BY dr.driver_type;


# 7 - What is the average order amount by store, in descending order?
SELECT st.store_id, st.store_name, ROUND(AVG(CAST(od.order_amount AS DECIMAL(18,2))), 2) as avg_order
FROM order_deliveries.orders as od
INNER JOIN order_deliveries.stores as st
	ON od.store_id = st.store_id
GROUP BY st.store_id, st.store_name
ORDER BY avg_order DESC;


# 8 - Are there orders that are not associated to any stores?
SELECT *
FROM order_deliveries.orders as od
WHERE od.store_id IS NULL;


# 9 - What is the total order amount in the channel 'FOOD PLACE'?
SELECT ch.channel_name, COUNT(od.order_id) as n_orders, ROUND(SUM(CAST(od.order_amount AS DECIMAL(18,2))), 2) as sum_amount
FROM order_deliveries.orders as od
INNER JOIN order_deliveries.channels as ch
	ON od.channel_id = ch.channel_id
WHERE ch.channel_name LIKE 'FOOD PLACE'
GROUP BY ch.channel_name;


# 10 - How many cancelled payments are there?
SELECT DISTINCT p.payment_status
FROM order_deliveries.payments as p;

SELECT COUNT(p.payment_id) as count_canceled
FROM order_deliveries.payments as p
WHERE p.payment_status LIKE 'CHARGEBACK';


# 11 - What is the average payment amount for cancelled payments?
SELECT ROUND(AVG(CAST(p.payment_amount AS DECIMAL(18,2))), 2) as avg_payment
FROM order_deliveries.payments as p
WHERE p.payment_status LIKE 'CHARGEBACK';


# 12 - What is the average payment amount by payment method?
SELECT p.payment_method, ROUND(AVG(CAST(p.payment_amount AS DECIMAL(18,2))), 2) as avg_payment
FROM order_deliveries.payments as p
GROUP BY p.payment_method
ORDER BY avg_payment DESC;


# 13 - Which payment methods had average payment value higher than 100?
SELECT p.payment_method, ROUND(AVG(CAST(p.payment_amount AS DECIMAL(18,2))), 2) as avg_payment
FROM order_deliveries.payments as p
GROUP BY p.payment_method
HAVING avg_payment > 100
ORDER BY avg_payment DESC;


# 14 - What is the average order amount by hub state, store segment and channel type?
SELECT 
	IF(h.hub_state IS NULL, 'All hubs', h.hub_state) as hub_state,
    IF(st.store_segment IS NULL, 'All segments', st.store_segment) as store_segment,
    IF(ch.channel_type IS NULL, 'All channels', ch.channel_type) as channel_type,
    ROUND(AVG(CAST(od.order_amount AS DECIMAL(18,2))), 2) as avg_amount
FROM order_deliveries.orders as od
INNER JOIN order_deliveries.stores as st
	ON od.store_id = st.store_id
INNER JOIN order_deliveries.hubs as h
	ON st.hub_id = h.hub_id
INNER JOIN order_deliveries.channels as ch
	ON od.channel_id = ch.channel_id
GROUP BY h.hub_state, st.store_segment, ch.channel_type WITH ROLLUP
ORDER BY h.hub_state, st.store_segment, ch.channel_type;


# 15 - Which combinations of hub state, store segment and channel type have order amounts greater than 450?
SELECT 
	IF(h.hub_state IS NULL, 'All hubs', h.hub_state) as hub_state,
    IF(st.store_segment IS NULL, 'All segments', st.store_segment) as store_segment,
    IF(ch.channel_type IS NULL, 'All channels', ch.channel_type) as channel_type,
    ROUND(AVG(CAST(od.order_amount AS DECIMAL(18,2))), 2) as avg_amount
FROM order_deliveries.orders as od
INNER JOIN order_deliveries.stores as st
	ON od.store_id = st.store_id
INNER JOIN order_deliveries.hubs as h
	ON st.hub_id = h.hub_id
INNER JOIN order_deliveries.channels as ch
	ON od.channel_id = ch.channel_id
GROUP BY h.hub_state, st.store_segment, ch.channel_type
HAVING avg_amount > 450
ORDER BY avg_amount DESC;


# 16 - What is the total order amount by hub state, store segment and channel type?
SELECT 
	IF(h.hub_state IS NULL, 'All hubs', h.hub_state) as hub_state,
    IF(st.store_segment IS NULL, 'All segments', st.store_segment) as store_segment,
    IF(ch.channel_type IS NULL, 'All channels', ch.channel_type) as channel_type,
    ROUND(SUM(CAST(od.order_amount AS DECIMAL(18,2))), 2) as avg_amount
FROM order_deliveries.orders as od
INNER JOIN order_deliveries.stores as st
	ON od.store_id = st.store_id
INNER JOIN order_deliveries.hubs as h
	ON st.hub_id = h.hub_id
INNER JOIN order_deliveries.channels as ch
	ON od.channel_id = ch.channel_id
GROUP BY h.hub_state, st.store_segment, ch.channel_type WITH ROLLUP
ORDER BY h.hub_state, st.store_segment, ch.channel_type;


# 17 - When the order is from the 'Rio de Janeiro' hub state, 'FOOD' store segment, 'Marketplace' channel type and was cancelled, what
# is the average order amount?
SELECT ROUND(AVG(CAST(od.order_amount AS DECIMAL(18,2))), 2) as avg_amount
FROM order_deliveries.orders as od
INNER JOIN order_deliveries.stores as st
	ON od.store_id = st.store_id
INNER JOIN order_deliveries.hubs as h
	ON st.hub_id = h.hub_id
INNER JOIN order_deliveries.channels as ch
	ON od.channel_id = ch.channel_id
INNER JOIN order_deliveries.payments as p
	ON od.payment_order_id = p.payment_order_id
WHERE h.hub_state LIKE 'RJ'
	AND st.store_segment LIKE 'FOOD'
    AND ch.channel_type LIKE 'MARKETPLACE'
    AND od.order_status LIKE 'CANCELED';
    
    
# 18 - When the order is from the 'GOOD' store segment, 'Marketplace' channel type and is cancelled, are there any hub states that had 
# total order amount greater than 100.000?
SELECT h.hub_state, ROUND(SUM(CAST(od.order_amount AS DECIMAL(18,2))), 2) as sum_order_amount
FROM order_deliveries.orders as od
INNER JOIN order_deliveries.stores as st
	ON od.store_id = st.store_id
INNER JOIN order_deliveries.channels as ch
	ON od.channel_id = ch.channel_id
INNER JOIN order_deliveries.hubs as h
	ON st.hub_id = h.hub_id
WHERE st.store_segment LIKE 'GOOD'
	AND ch.channel_type LIKE 'MARKETPLACE'
    AND od.order_status LIKE 'CANCELED'
GROUP BY h.hub_state
HAVING sum_order_amount > 100000
ORDER BY sum_order_amount DESC;


# 19 - Which date has the higher average order amount?
SELECT SUBSTRING_INDEX(od.order_moment_created, ' ', 1) as moments, 
	ROUND(AVG(CAST(od.order_amount AS DECIMAL(18,2))), 2) as avg_order_amt
FROM order_deliveries.orders as od
GROUP BY moments
ORDER BY avg_order_amt DESC
LIMIT 1;


# 20 - What are the dates that had no orders?
SELECT @max_date:=MAX(STR_TO_DATE(SUBSTRING_INDEX(od.order_moment_created, ' ', 1), "%c/%e/%Y")),
	@min_date:=MIN(STR_TO_DATE(SUBSTRING_INDEX(od.order_moment_created, ' ', 1), "%c/%e/%Y"))
FROM order_deliveries.orders as od;


WITH recursive Date_Ranges AS (
    select @min_date as date_value
   union all
   select date_value + interval 1 day
   from Date_Ranges
   where date_value < @max_date
),
order_dates AS (
SELECT DISTINCT STR_TO_DATE(SUBSTRING_INDEX(od.order_moment_created, ' ', 1), "%c/%e/%Y") as moments
FROM order_deliveries.orders as od
)
SELECT dr.*
FROM Date_Ranges as dr
LEFT JOIN order_dates as od
	ON dr.date_value = od.moments
WHERE od.moments IS NULL
ORDER BY date_value;
