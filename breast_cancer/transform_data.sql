-- Create a new table from the original table. Categorize data in "size_tumor" column.
-- Binarize data in "class" column. Encode data in "quadrant" and "irradianting" columns.


CREATE TABLE IF NOT EXISTS bcancer.BreastCancer2
AS
SELECT
	CASE
		WHEN class = 'no-recurrence-events' THEN 0
        WHEN class = 'recurrence-events' THEN 1
	END as class,
    age,
    menopause,
	CASE 
		WHEN size_tumor IN ('0-4', '5-9') THEN 'Very small'
        WHEN size_tumor IN ('10-14', '15-19') THEN 'Small'
        WHEN size_tumor IN ('20-24', '25-29') THEN 'Medium'
        WHEN size_tumor IN ('30-34', '35-39') THEN 'Big'
        WHEN size_tumor IN ('40-44', '45-49') THEN 'Very big'
        WHEN size_tumor IN ('50-54') THEN 'Immediate care'
	END as size_tumor,
    inv_nodes,
    CASE 
		WHEN node_caps = 'no' THEN 0
        WHEN node_caps = 'yes' THEN 1
        ELSE 2
	END as node_caps,
    deg_malig,
    breast,
    CASE
		WHEN quadrant = 'left_low' THEN 1
        WHEN quadrant = 'right_up' THEN 2
        WHEN quadrant = 'left_up' THEN 3
        WHEN quadrant = 'right_low' THEN 4
        WHEN quadrant = 'central' THEN 5
        ELSE 0
	END AS quadrant,
    CASE 
		WHEN irradiating = 'no' THEN 0
        WHEN irradiating = 'yes' THEN 1
	END as irradiating
FROM bcancer.BreastCancer;
    