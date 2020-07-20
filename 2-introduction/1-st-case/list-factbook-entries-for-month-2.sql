/*
 * List either data or default values for each day of month
 * without a single additional line of application code beint SPENT on solving the problem
 *
 * Generate the target month's calendar then LEFT JOIN each day against the factbook dataset,
 * so as to have every day in the result set, wether or not we have a book entry for the day
 *
 * MERGE LEFT JOIN over 2 ordered relations in DB server
 * vs
 * HASH JOIN NESTED LOOP in application code
 */

\set start '2017-02-01'

SELECT
    -- first 'AS DATE' casts to DATE type, second 'AS date' aliasses the column in the result set
    -- need to cast because GENERATE_SERIES() func returns a set of timestamp* entries and we don't care about the time parts of it
    CAST(calendar.entry AS DATE) AS date,
    COALESCE(shares, 0) AS shares,
    COALESCE(trades, 0) AS trades,
    TO_CHAR(
        COALESCE(dollars, 0),
        'L99G999G999G999'
    ) AS dollars
FROM
    GENERATE_SERIES(
        DATE :'start',
        DATE :'start' + INTERVAL '1 month' - INTERVAL '1 day',
        INTERVAL '1 day'
    -- 'expr AS table(col, ...)' sets scheme for precedeing table expression result
    ) AS calendar(entry)
    LEFT JOIN factbook
    ON factbook.date = calendar.entry
ORDER BY date;
