SELECT 
    Ticker,
    ROUND(MIN(drawdown), 2) AS max_drawdown_percent
FROM (
    SELECT 
        Ticker,
        (Close - MAX(Close) OVER (PARTITION BY Ticker ORDER BY Date)) / MAX(Close) OVER (PARTITION BY Ticker ORDER BY Date) * 100 AS drawdown
    FROM us_stocks
)
GROUP BY Ticker
ORDER BY max_drawdown_percent ASC;