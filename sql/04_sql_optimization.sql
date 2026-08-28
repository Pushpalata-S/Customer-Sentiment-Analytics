SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   26. CHECK EXISTING INDEXES
   ========================================================= */

SELECT
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    c.name AS ColumnName

FROM sys.tables t

INNER JOIN sys.indexes i
    ON t.object_id = i.object_id

INNER JOIN sys.index_columns ic
    ON i.object_id = ic.object_id
    AND i.index_id = ic.index_id

INNER JOIN sys.columns c
    ON ic.object_id = c.object_id
    AND ic.column_id = c.column_id

WHERE t.name IN
(
    'customer_reviews',
    'fact_review_sentiment',
    'customers',
    'products'
)

ORDER BY
    t.name,
    i.name,
    ic.key_ordinal;

GO

/* =========================================================
   27. INDEX ON SENTIMENT REVIEW ID
   ========================================================= */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_fact_review_sentiment_ReviewID'
      AND object_id = OBJECT_ID('dbo.fact_review_sentiment')
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_fact_review_sentiment_ReviewID
    ON dbo.fact_review_sentiment (ReviewID);

END;

GO

/* =========================================================
   28. INDEX FOR PRODUCT-LEVEL ANALYSIS
   ========================================================= */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_customer_reviews_ProductID'
      AND object_id = OBJECT_ID('dbo.customer_reviews')
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_customer_reviews_ProductID
    ON dbo.customer_reviews (ProductID);

END;

GO

/* =========================================================
   29. INDEX FOR CUSTOMER-LEVEL ANALYSIS
   ========================================================= */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_customer_reviews_CustomerID'
      AND object_id = OBJECT_ID('dbo.customer_reviews')
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_customer_reviews_CustomerID
    ON dbo.customer_reviews (CustomerID);

END;

GO

/* =========================================================
   30. COVERING INDEX FOR SENTIMENT ANALYSIS
   ========================================================= */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_reviewsentiment_ReviewID_Sentiment'
      AND object_id = OBJECT_ID('dbo.fact_review_sentiment')
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_reviewsentiment_ReviewID_Sentiment
    ON dbo.fact_review_sentiment (ReviewID)
    INCLUDE
    (
        SentimentScore,
        SentimentLabel
    );

END;

GO

-- opti query
SELECT
    p.Category,
    COUNT(*) AS TotalReviews,
    AVG(v.SentimentScore) AS AvgSentiment
FROM dbo.vw_review_sentiment_analysis v
INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID
GROUP BY
    p.Category;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO

/* =========================================================
   32. UPDATE TABLE STATISTICS
   ========================================================= */

UPDATE STATISTICS dbo.customer_reviews;
UPDATE STATISTICS dbo.fact_review_sentiment;
UPDATE STATISTICS dbo.products;
UPDATE STATISTICS dbo.customers;

GO