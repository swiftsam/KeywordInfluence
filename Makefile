# Keyword Influence 
# 
# assumes existence of local postgres db: keyword-influence

PSQL_KEYINFL=psql --set ON_ERROR_STOP=1 keyword-influence

all: .make_db_import_words .make_db_import_influence

# Import words files to database
.make_db_import_words: .make_get_words  src/db_import_words.sql
	cat src/db_import_words.sql | ${PSQL_KEYINFL}
	cat src/db_import_words.sql | psql --set ON_ERROR_STOP=1 keyword-influence
	touch $@

# Import influence files to database
.make_db_import_influence: .make_get_influence src/db_import_influence.sql
	cat src/db_import_influence.sql | {$PSQL_KEYINFL}
	cat src/db_import_influence.sql | psql --set ON_ERROR_STOP=1 keyword-influence
	touch $@

# Download influence files from AWS
.make_get_influence: src/get_influence.sh 
	bash src/get_influence.sh
	touch $@

# Pull, save, and combine words files from Sunlight Foundation
.make_get_words: src/pull_congresspeople.py src/pull_capitolwords_text.py src/concat_capitolwords_text.py
	python src/pull_capitolwords_text.py
	pythong src/concat_capitolwords_text.py
	touch $@

### Cleanup...
clean:
	rm -r data/*
	rm -f .make*

drop_keyinfl_db:
	dropdb --if-exists keyword-influence
	rm -f .make_db_import
