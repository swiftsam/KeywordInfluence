
DROP USER keywordinfluence;
FLUSH PRIVILEGES;

CREATE USER keywordinfluence IDENTIFIED BY  4dMEvdUf3eU8QZFL;
GRANT USAGE ON * . * TO  keywordinfluence IDENTIFIED BY  4dMEvdUf3eU8QZFL; 
CREATE DATABASE IF NOT EXISTS  keywordinfluence ;
GRANT ALL PRIVILEGES ON  keywordinfluence . * TO  keywordinfluence;

USE keywordinfluence;
DROP TABLE IF EXISTS `contributions`;
CREATE TABLE IF NOT EXISTS `contributions` (
  `id` int(9) DEFAULT NULL,
  `import_reference_id` int(3) DEFAULT NULL,
  `cycle` int(4) DEFAULT NULL,
  `transaction_namespace` varchar(19) DEFAULT NULL,
  `transaction_id` varchar(18) DEFAULT NULL,
  `transaction_type` varchar(255) DEFAULT NULL,
  `filing_id` varchar(255) DEFAULT NULL,
  `is_amendment` varchar(1) DEFAULT NULL,
  `amount` decimal(10,3) DEFAULT NULL,
  `date` varchar(10) DEFAULT NULL,
  `contributor_name` varchar(255) DEFAULT NULL,
  `contributor_ext_id` varchar(255) DEFAULT NULL,
  `contributor_type` varchar(1) DEFAULT NULL,
  `contributor_occupation` varchar(255) DEFAULT NULL,
  `contributor_employer` varchar(255) DEFAULT NULL,
  `contributor_gender` varchar(1) DEFAULT NULL,
  `contributor_address` varchar(255) DEFAULT NULL,
  `contributor_city` varchar(255) DEFAULT NULL,
  `contributor_state` varchar(2) DEFAULT NULL,
  `contributor_zipcode` varchar(16) DEFAULT NULL,
  `contributor_category` varchar(5) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `organization_ext_id` varchar(10) DEFAULT NULL,
  `parent_organization_name` varchar(255) DEFAULT NULL,
  `parent_organization_ext_id` varchar(255) DEFAULT NULL,
  `recipient_name` varchar(255) DEFAULT NULL,
  `recipient_ext_id` varchar(9) DEFAULT NULL,
  `recipient_party` varchar(1) DEFAULT NULL,
  `recipient_type` varchar(1) DEFAULT NULL,
  `recipient_state` varchar(10) DEFAULT NULL,
  `recipient_state_held` varchar(10) DEFAULT NULL,
  `recipient_category` varchar(5) DEFAULT NULL,
  `committee_name` varchar(255) DEFAULT NULL,
  `committee_ext_id` varchar(9) DEFAULT NULL,
  `committee_party` varchar(1) DEFAULT NULL,
  `candidacy_status` varchar(1) DEFAULT NULL,
  `district` varchar(10) DEFAULT NULL,
  `district_held` varchar(10) DEFAULT NULL,
  `seat` varchar(255) DEFAULT NULL,
  `seat_held` varchar(255) DEFAULT NULL,
  `seat_status` varchar(10) DEFAULT NULL,
  `seat_result` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOAD DATA INFILE "/home/sam/KeywordInfluence/data/influence/contributions.fec.csv"
	INTO TABLE contributions
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
	IGNORE 1 LINES;
