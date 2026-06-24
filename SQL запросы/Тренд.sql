SELECT 
    Ticker,
    Date,
    Close,
    close_20_days_ago,
    ROUND(((Close - close_20_days_ago) / close_20_days_ago) * 100, 2) AS change_20_days_percent
FROM (
    SELECT 
        Ticker,
        Date,
        Close,
        LAG(Close, 20) OVER (PARTITION BY Ticker ORDER BY Date) AS close_20_days_ago
    FROM us_stocks
)
WHERE Date = (SELECT MAX(Date) FROM us_stocks)
  AND close_20_days_ago IS NOT NULL
ORDER BY change_20_days_percent DESC;