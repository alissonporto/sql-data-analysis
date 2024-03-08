LOAD DATA LOCAL INFILE '/home/nitro14/training/portfolios/sql-data-analysis/breast_cancer/cancer_data.csv' INTO TABLE `bcancer`.`BreastCancer` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '' LINES TERMINATED BY '\n' IGNORE 1 LINES;
