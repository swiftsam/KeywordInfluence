
# Get unique pacs with influence summary sorted by influence
SELECT pac_id, pac_short, n_contribs, sum_contrib FROM
	(SELECT pac_id,
		   COUNT(1) AS n_contribs,
		   SUM(amount) AS sum_contrib
		FROM pac_contrib
		GROUP BY pac_id) as contrib_counts, 
	(SELECT DISTINCT ON (cmte_id) cmte_id, pac_short
		FROM pac
		ORDER BY cmte_id, cycle DESC) as pac_names
	WHERE contrib_counts.pac_id = pac_names.cmte_id
ORDER BY sum_contrib DESC;


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

# find PACS which have contributed at least X dollars in sum
SELECT DISTINCT pac.cmte_id as pac_id, pac.pac_short, sums.sum, sums.n_contribs 
	FROM pac
	INNER JOIN (SELECT pac_id, SUM(amount) AS sum, COUNT(1) AS n_contribs
				FROM pac_contrib
				GROUP BY pac_id) AS sums
	ON pac.cmte_id = sums.pac_id
	WHERE sums.sum > 10000;

SELECT pac_id FROM pac_contrib 
	WHERE date::date > '2012-01-01'::date 
	AND date::date < '2012-12-31'::date GROUP BY pac_id;


# find all PACs which have at least one chunk

SELECT p.pac_id, w.chunk_id
	FROM pac as p, words as w
	INNER JOIN 

SELECT COUNT(1) AS n_chunks
	FROM words
	WHERE bioguide_id IN(
		SELECT bioguide_id, 
		FROM pac_contrib
		INNER JOIN congress
		ON pac_contrib.fec_candidate_id =
		  congress.fec_id)
	GROUP BY pac_id;


SELECT DISTINCT p.cmte_id
FROM pac AS p, pac_contrib AS pc, words AS w, congress AS c
WHERE p.cmte_id = pc.pac_id AND pc.fec_candidate_id = c.fec_id AND c.bioguide_id = w.bioguide_id;
