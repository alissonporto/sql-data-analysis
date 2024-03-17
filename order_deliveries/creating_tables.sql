CREATE SCHEMA IF NOT EXISTS `order_deliveries`;

CREATE TABLE IF NOT EXISTS `order_deliveries`.`channels` (
  `channel_id` int DEFAULT NULL,
  `channel_name` text,
  `channel_type` text
  );


CREATE TABLE IF NOT EXISTS `order_deliveries`.`deliveries` (
  `delivery_id` int DEFAULT NULL,
  `delivery_order_id` int DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `delivery_distance_meters` int DEFAULT NULL,
  `delivery_status` text
  );


CREATE TABLE IF NOT EXISTS `order_deliveries`.`drivers` (
  `driver_id` INT NULL,
  `driver_modal` VARCHAR(200) NULL,
  `driver_type` VARCHAR(200) NULL
  );


CREATE TABLE IF NOT EXISTS `order_deliveries`.`hubs` (
  `hub_id` INT NULL,
  `hub_name` VARCHAR(200) NULL,
  `hub_city` VARCHAR(200) NULL,
  `hub_state` VARCHAR(200) NULL,
  `hub_latitude` DOUBLE NULL,
  `hub_longitude` DOUBLE NULL
  );


CREATE TABLE IF NOT EXISTS `order_deliveries`.`orders` (
  `order_id` INT NULL,
  `store_id` INT NULL,
  `channel_id` INT NULL,
  `payment_order_id` INT NULL,
  `delivery_order_id` INT NULL,
  `order_status` VARCHAR(200) NULL,
  `order_amount` DOUBLE NULL,
  `order_delivery_fee` DOUBLE NULL,
  `order_delivery_cost` DOUBLE NULL,
  `order_created_hour` INT NULL,
  `order_created_minute` INT NULL,
  `order_created_day` INT NULL,
  `order_created_month` INT NULL,
  `order_created_year` INT NULL,
  `order_moment_created` VARCHAR(200) NULL,
  `order_moment_accepted` VARCHAR(200) NULL,
  `order_moment_ready` VARCHAR(200) NULL,
  `order_moment_collected` VARCHAR(200) NULL,
  `order_moment_in_expedition` VARCHAR(200) NULL,
  `order_moment_delivering` VARCHAR(200) NULL
  );


CREATE TABLE IF NOT EXISTS `order_deliveries`.`payments` (
  `payment_id` INT NULL,
  `payment_order_id` INT NULL,
  `payment_amount` DOUBLE NULL,
  `payment_fee` DOUBLE NULL,
  `payment_method` VARCHAR(200) NULL,
  `payment_status` VARCHAR(200) NULL
  );


CREATE TABLE IF NOT EXISTS `order_deliveries`.`stores` (
   `store_id` INT NULL,
   `hub_id` INT NULL,
   `store_name` VARCHAR(200) NULL,
   `store_segment` VARCHAR(200) NULL,
   `store_plan_price` DOUBLE NULL,
   `store_latitude` DOUBLE NULL,
   `store_longitude` DOUBLE NULL
  );
  