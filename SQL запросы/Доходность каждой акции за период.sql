SELECT 
    Ticker,
    MIN(Date) AS start_date,
    MAX(Date) AS end_date,
    ROUND((SELECT Close FROM us_stocks WHERE Ticker = s.Ticker ORDER BY Date DESC LIMIT 1), 2) AS end_price,
    ROUND((SELECT Close FROM us_stocks WHERE Ticker = s.Ticker ORDER BY Date ASC LIMIT 1), 2) AS start_price,
    ROUND(
        ((SELECT Close FROM us_stocks WHERE Ticker = s.Ticker ORDER BY Date DESC LIMIT 1) - 
         (SELECT Close FROM us_stocks WHERE Ticker = s.Ticker ORDER BY Date ASC LIMIT 1)) / 
         (SELECT Close FROM us_stocks WHERE Ticker = s.Ticker ORDER BY Date ASC LIMIT 1) * 100, 2
    ) AS total_return_percent
FROM us_stocks s
GROUP BY Ticker
ORDER BY total_return_percent DESC;