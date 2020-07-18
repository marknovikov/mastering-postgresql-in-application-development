BEGIN;

CREATE TABLE factbook (
    year    INT,
    date    DATE,
    shares  TEXT,
    trades  TEXT,
    dollars TEXT
);

\copy factbook FROM 'factbook.csv' WITH DELIMITER E'\t' NULL ''

ALTER TABLE factbook
    ALTER shares
    TYPE BIGINT
    USING REPLACE(shares, ',', '')::BIGINT,

    ALTER trades
    TYPE BIGINT
    USING REPLACE(trades, ',', '')::BIGINT,

    ALTER dollars
    TYPE BIGINT
    USING REPLACE(SUBSTRING(dollars FROM 2), ',', '')::BIGINT;

COMMIT;
