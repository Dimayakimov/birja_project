SELECT 
    Ticker,
    ROUND(AVG(daily_return), 3) AS avg_daily_return,
    ROUND(SQRT(AVG(daily_return * daily_return) - AVG(daily_return) * AVG(daily_return)), 3) AS volatility
FROM (
    SELECT 
        Ticker,
        (Close - LAG(Close) OVER (PARTITION BY Ticker ORDER BY Date)) / LAG(Close) OVER (PARTITION BY Ticker ORDER BY Date) * 100 AS daily_return
    FROM us_stocks
)
WHERE daily_return IS NOT NULL
GROUP BY Ticker
ORDER BY volatility DESC;