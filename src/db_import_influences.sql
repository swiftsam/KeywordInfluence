DROP TABLE IF EXISTS lobbying;
CREATE TABLE lobbying (
	transaction_id TEXT,
	transaction_type TEXT,
	transaction_type_desc TEXT,
	year INTEGER,
	filing_type TEXT,
	filing_included_nsfs TEXT,
	amount DECIMAL,
	registrant_name TEXT,
	registrant_is_firm TEXT,
	client_name TEXT,
	client_category TEXT,
	client_parent_name TEXT,
	include_in_industry_totals TEXT,
	use TEXT,
	affiliate TEXT);

\COPY lobbying FROM 'data/lobbying.csv' WITH CSV HEADER DELIMITER AS ',';

DROP TABLE IF EXISTS lobbyist;
CREATE TABLE lobbyist (
	id INTEGER,
	year INTEGER,
	transaction_id TEXT,
	lobbyist_name TEXT,
	lobbyist_ext_id TEXT,
	candidate_ext_id TEXT,
	government_position TEXT,
	member_of_congress TEXT);

\COPY lobbyist FROM 'data/lobbyist.csv' WITH CSV HEADER DELIMITER AS ',';

DROP TABLE IF EXISTS agency;
CREATE TABLE agency (
	id INTEGER,
	transaction_id TEXT,
	agency_name TEXT,
	agency_ext_id TEXT);

\COPY agency FROM 'data/agency.csv' WITH CSV HEADER DELIMITER AS ',';

DROP TABLE IF EXISTS issue;
CREATE TABLE issue (
	id INTEGER,
	year INTEGER,
	transaction_id TEXT,
	general_issue_code TEXT,
	general_issue TEXT,
	specific_issue TEXT);

\COPY issue FROM 'data/issue.csv' WITH CSV HEADER DELIMITER AS ',';

DROP TABLE IF EXISTS bill;
CREATE TABLE bill (
	id INTEGER,
	bill_id INTEGER,
	issue_id INTEGER,
	congress_no INTEGER,
	bill_type_raw TEXT,
	bill_type TEXT,
	bill_no INTEGER,
	bill_name TEXT);

\COPY bill FROM 'data/bill.csv' WITH CSV HEADER DELIMITER AS ',';

DROP TABLE IF EXISTS pac;
CREATE TABLE pac (
	year INTEGER,
	fec_rec_no TEXT,
	pac_id TEXT,
	candidate_id TEXT,
	amount DECIMAL,
	date TEXT,
	real_code TEXT,
	type TEXT,
	direct TEXT,
	fec_candidate_id TEXT);

\COPY pac FROM 'data/pac.csv' WITH CSV DELIMITER AS ',';