CREATE SCHEMA IF NOT EXISTS `bcancer`;

CREATE TABLE IF NOT EXISTS `bcancer`.`BreastCancer` (
  `class` VARCHAR(100) NULL,
  `age` VARCHAR(45) NULL,
  `menopause` VARCHAR(45) NULL,
  `size_tumor` VARCHAR(45) NULL,
  `inv_nodes` VARCHAR(45) NULL,
  `node_caps` VARCHAR(3) NULL,
  `deg_malig` INT NULL,
  `breast` VARCHAR(5) NULL,
  `quadrant` VARCHAR(10) NULL,
  `irradiating` VARCHAR(3) NULL);