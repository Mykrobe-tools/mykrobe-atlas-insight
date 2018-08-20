CREATE TABLE results (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(30) NOT NULL,
    analysed VARCHAR(100),
    kmer BIGINT,
    genotypeModel VARCHAR(100),
    parent_id VARCHAR(30) NOT NULL,
    received_date TIMESTAMP
);