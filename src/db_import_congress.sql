DROP TABLE IF EXISTS congress;
CREATE TABLE congress(
	title TEXT,
	firstname TEXT,
	middlename TEXT,
	lastname TEXT,
	name_suffix TEXT,
	nickname TEXT,
	party TEXT,
	state TEXT,
	district TEXT,
	in_office TEXT,
	gender TEXT,
	phone TEXT,
	fax TEXT,
	website TEXT,
	webform TEXT,
	congress_office TEXT,
	bioguide_id TEXT,
	votesmart_id TEXT,
	fec_id TEXT,
	govtrack_id INTEGER,
	crp_id TEXT,
	twitter_id TEXT,
	congresspedia_url TEXT,
	youtube_url TEXT,
	facebook_id TEXT,
	official_rss TEXT,
	senate_class TEXT,
	birthdate TEXT);
\COPY congress FROM 'data/legislators.csv' WITH CSV HEADER DELIMITER AS ',';
CREATE INDEX ON congress (fec_id);
CREATE INDEX ON congress (bioguide_id);