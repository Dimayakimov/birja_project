SELECT 
    Ticker,
    ROUND(AVG(Close), 2) AS avg_price,
    ROUND(MIN(Close), 2) AS min_price,
    ROUND(MAX(Close), 2) AS max_price,
    ROUND(MAX(Close) - MIN(Close), 2) AS price_range
FROM us_stocks
GROUP BY Ticker
ORDER BY avg_price DESC;