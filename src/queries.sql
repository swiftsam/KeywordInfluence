SELECT id AS chunk_id FROM words
	WHERE 


SELECT crp_id FROM congress
	WHERE

# find some high influence PACS
SELECT pac_id, COUNT(1) FROM pac_contrib GROUP BY pac_id LIMIT 100;

# name of pac 89432 is Sprint
SELECT pac_short FROM pac WHERE cmte_id = 'C00089342';

# find all members of congress who have received money from Sprint
SELECT fec_candidate_id, bioguide_id, lastname, amount 
	FROM pac_contrib 
	INNER JOIN congress 
	ON pac_contrib.fec_candidate_id = congress.fec_id
	WHERE pac_id = 'C00089342'
	ORDER BY amount DESC;

# find the chunk_ids of all words by members of congress who have received money from sprint
SELECT id FROM words
	WHERE bioguide_id IN(
		SELECT bioguide_id
			FROM pac_contrib
			INNER JOIN congress
			ON pac_contrib.fec_candidate_id = congress.fec_id
			WHERE pac_id = 'C00089342');
