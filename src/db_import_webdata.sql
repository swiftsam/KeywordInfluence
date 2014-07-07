DROP TABLE IF EXISTS webdata_pac;
CREATE TABLE webdata_pac (
	pac_id TEXT,
	congress INTEGER,
	json_data TEXT);

\COPY webdata_pac FROM 'data/webdata_pac.csv' WITH CSV HEADER DELIMITER AS ',';
