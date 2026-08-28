USE PortfolioProject_MarketingAnalytics;
GO

-- =====================================================
-- 1. REVIEW SENTIMENT ANALYSIS VIEW
-- =====================================================

CREATE OR ALTER VIEW dbo.vw_review_sentiment_analysis AS
SELECT
    r.ReviewID,
    r.CustomerID,
    r.ProductID,
    r.ReviewDate,
    r.Rating,
    r.ReviewText,
    s.SentimentScore,
    s.TextSentimentLabel,
    s.SentimentBucket,
    s.SentimentCategory
FROM dbo.fact_customer_reviews r
LEFT JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID;
GO

SELECT TOP 20 *
FROM dbo.vw_review_sentiment_analysis
ORDER BY ReviewDate DESC;


-- =====================================================
-- 2. RATING-SENTIMENT MISMATCH
-- =====================================================

SELECT
    ReviewID,
    CustomerID,
    ProductID,
    ReviewDate,
    Rating,
    SentimentScore,
    TextSentimentLabel,
    SentimentCategory,
    ReviewText
FROM dbo.vw_review_sentiment_analysis
WHERE
    (Rating >= 4 AND TextSentimentLabel = 'Negative')
    OR
    (Rating <= 2 AND TextSentimentLabel = 'Positive')
ORDER BY ABS(SentimentScore) DESC;


-- =====================================================
-- 3. OVERALL SENTIMENT KPIs
-- =====================================================

SELECT
    COUNT(*) AS TotalReviews,

    SUM(CASE
        WHEN TextSentimentLabel = 'Positive'
        THEN 1 ELSE 0
    END) AS PositiveReviews,

    SUM(CASE
        WHEN TextSentimentLabel = 'Negative'
        THEN 1 ELSE 0
    END) AS NegativeReviews,

    SUM(CASE
        WHEN TextSentimentLabel = 'Neutral'
        THEN 1 ELSE 0
    END) AS NeutralReviews,

    SUM(CASE
        WHEN SentimentCategory IN ('Mixed Positive', 'Mixed Negative')
        THEN 1 ELSE 0
    END) AS MismatchReviews,

    CAST(
        100.0 *
        SUM(CASE
            WHEN SentimentCategory IN ('Mixed Positive', 'Mixed Negative')
            THEN 1 ELSE 0
        END) / COUNT(*)
        AS DECIMAL(10,2)
    ) AS MismatchPercentage,

    CAST(AVG(SentimentScore) AS DECIMAL(10,4))
        AS AverageSentimentScore,

    CAST(AVG(CAST(Rating AS DECIMAL(10,2))) AS DECIMAL(10,2))
        AS AverageRating

FROM dbo.vw_review_sentiment_analysis;


USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   CUSTOMER SENTIMENT ANALYSIS
   Advanced SQL Business Analysis
   ========================================================= */


/* 1. Overall Sentiment Distribution */
SELECT
    TextSentimentLabel,
    COUNT(*) AS ReviewCount,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS ReviewPercentage
FROM dbo.fact_review_sentiment
GROUP BY TextSentimentLabel
ORDER BY ReviewCount DESC;


/* 2. Average Sentiment Score by Rating */
SELECT
    r.Rating,
    COUNT(*) AS ReviewCount,
    CAST(AVG(s.SentimentScore) AS DECIMAL(10,4)) AS AvgSentimentScore
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
GROUP BY r.Rating
ORDER BY r.Rating;


/* 3. Rating vs Text Sentiment Mismatch */
SELECT
    r.Rating,
    s.TextSentimentLabel,
    COUNT(*) AS ReviewCount
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
GROUP BY
    r.Rating,
    s.TextSentimentLabel
ORDER BY
    r.Rating,
    ReviewCount DESC;


/* 4. Negative Reviews with High Ratings */
SELECT
    r.ReviewID,
    r.CustomerID,
    r.ProductID,
    r.Rating,
    s.SentimentScore,
    s.TextSentimentLabel,
    r.ReviewText
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
WHERE r.Rating >= 4
  AND s.TextSentimentLabel = 'Negative'
ORDER BY s.SentimentScore ASC;


/* 5. Positive Reviews with Low Ratings */
SELECT
    r.ReviewID,
    r.CustomerID,
    r.ProductID,
    r.Rating,
    s.SentimentScore,
    s.TextSentimentLabel,
    r.ReviewText
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
WHERE r.Rating <= 2
  AND s.TextSentimentLabel = 'Positive'
ORDER BY s.SentimentScore DESC;


/* 6. Most Negative Products */
SELECT TOP 10
    r.ProductID,
    COUNT(*) AS TotalReviews,
    CAST(AVG(s.SentimentScore) AS DECIMAL(10,4))
        AS AvgSentimentScore,
    SUM(
        CASE
            WHEN s.TextSentimentLabel = 'Negative'
            THEN 1 ELSE 0
        END
    ) AS NegativeReviews
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
GROUP BY r.ProductID
HAVING COUNT(*) >= 5
ORDER BY AvgSentimentScore ASC;


/* 7. Most Positive Products */
SELECT TOP 10
    r.ProductID,
    COUNT(*) AS TotalReviews,
    CAST(AVG(s.SentimentScore) AS DECIMAL(10,4))
        AS AvgSentimentScore,
    SUM(
        CASE
            WHEN s.TextSentimentLabel = 'Positive'
            THEN 1 ELSE 0
        END
    ) AS PositiveReviews
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
GROUP BY r.ProductID
HAVING COUNT(*) >= 5
ORDER BY AvgSentimentScore DESC;


/* 8. Customer-Level Sentiment Analysis */
SELECT TOP 20
    r.CustomerID,
    COUNT(*) AS TotalReviews,
    CAST(AVG(s.SentimentScore) AS DECIMAL(10,4))
        AS AvgSentimentScore,
    SUM(
        CASE
            WHEN s.TextSentimentLabel = 'Negative'
            THEN 1 ELSE 0
        END
    ) AS NegativeReviews
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
GROUP BY r.CustomerID
HAVING COUNT(*) >= 2
ORDER BY AvgSentimentScore ASC;


/* 9. Sentiment by Review Year */
SELECT
    YEAR(r.ReviewDate) AS ReviewYear,
    COUNT(*) AS TotalReviews,
    CAST(AVG(s.SentimentScore) AS DECIMAL(10,4))
        AS AvgSentimentScore,
    SUM(
        CASE
            WHEN s.TextSentimentLabel = 'Positive'
            THEN 1 ELSE 0
        END
    ) AS PositiveReviews,
    SUM(
        CASE
            WHEN s.TextSentimentLabel = 'Negative'
            THEN 1 ELSE 0
        END
    ) AS NegativeReviews
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
GROUP BY YEAR(r.ReviewDate)
ORDER BY ReviewYear;


/* 10. Negative Review Rate by Product */
SELECT TOP 15
    r.ProductID,
    COUNT(*) AS TotalReviews,
    SUM(
        CASE
            WHEN s.TextSentimentLabel = 'Negative'
            THEN 1 ELSE 0
        END
    ) AS NegativeReviews,
    CAST(
        SUM(
            CASE
                WHEN s.TextSentimentLabel = 'Negative'
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS NegativeReviewRate
FROM dbo.customer_reviews r
JOIN dbo.fact_review_sentiment s
    ON r.ReviewID = s.ReviewID
GROUP BY r.ProductID
HAVING COUNT(*) >= 5
ORDER BY NegativeReviewRate DESC;