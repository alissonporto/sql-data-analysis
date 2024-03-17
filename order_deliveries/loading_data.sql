-- Access mysql from terminal:
--     mysql --local-infile=1 -u root -p
-- 
-- If you have problems loading data from terminal, please access: 
-- https://stackoverflow.com/a/65548915/10443880

LOAD DATA LOCAL INFILE 'order_deliveries/data/channels.csv' INTO TABLE `order_deliveries`.`channels` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


LOAD DATA LOCAL INFILE 'order_deliveries/data/deliveries.csv' INTO TABLE `order_deliveries`.`deliveries` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


LOAD DATA LOCAL INFILE 'order_deliveries/data/drivers.csv' INTO TABLE `order_deliveries`.`drivers` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


LOAD DATA LOCAL INFILE 'order_deliveries/data/hubs.csv' INTO TABLE `order_deliveries`.`hubs` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


LOAD DATA LOCAL INFILE 'order_deliveries/data/orders.csv' INTO TABLE `order_deliveries`.`orders` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


LOAD DATA LOCAL INFILE 'order_deliveries/data/payments.csv' INTO TABLE `order_deliveries`.`payments` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


LOAD DATA LOCAL INFILE 'order_deliveries/data/stores.csv' INTO TABLE `order_deliveries`.`stores` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
