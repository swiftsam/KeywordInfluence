DROP TABLE IF EXISTS freq_diff;
CREATE TABLE freq_diff (
	entity_id TEXT,
	congress INTEGER,
	json_data TEXT);

\COPY freq_diff FROM 'data/freq_diff.csv' WITH CSV HEADER DELIMITER AS ',';
