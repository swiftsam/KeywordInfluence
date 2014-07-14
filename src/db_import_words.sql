DROP TABLE IF EXISTS words;
CREATE TABLE words ( 
	csv_id INTEGER,
	bills TEXT,
	bioguide_id TEXT,
	capitolwords_url TEXT,
	chamber TEXT,
	congress TEXT,
	date TEXT,
	id TEXT,
	number INTEGER,
	"order" INTEGER,
	origin_url TEXT,
	pages TEXT,
	session INTEGER,
	speaker_first TEXT,
	speaker_last TEXT,
	speaker_party TEXT,
	speaker_raw TEXT,
	speaker_state TEXT,
	speaking TEXT,
	title TEXT,
	volume INTEGER,
	n_sentence INTEGER);

\COPY words FROM 'data/words.csv' WITH CSV HEADER DELIMITER AS ',';
CREATE INDEX ON words (bioguide_id);