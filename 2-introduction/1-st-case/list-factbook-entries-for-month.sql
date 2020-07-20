\set start '2017-02-01'

SELECT
    date,
    TO_CHAR(shares, '99G999G999G999') AS shares,
    TO_CHAR(trades, '99G999G999G999') AS trades,
    TO_CHAR(dollars, 'L99G999G999G999') AS dollars
FROM factbook
WHERE date >= :'start' AND date < DATE :'start' + INTERVAL '1 month'
ORDER BY date;
