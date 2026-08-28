USE PortfolioProject_MarketingAnalytics;
GO

/* ============================================================
   POWER BI CUSTOMER SENTIMENT ANALYTICS
   FINAL POWER BI VIEW
   ============================================================ */

CREATE OR ALTER VIEW dbo.vw_powerbi_customer_sentiment
AS
SELECT

    /* ========================================================
       1. REVIEW DETAILS
       ======================================================== */

    v.ReviewID,
    v.CustomerID,
    v.ProductID,
    v.ReviewDate,
    v.Rating,
    v.ReviewText,

    /* ========================================================
       2. DATE ATTRIBUTES
       ======================================================== */

    YEAR(v.ReviewDate) AS ReviewYear,

    MONTH(v.ReviewDate) AS ReviewMonth,

    DATENAME(MONTH, v.ReviewDate) AS ReviewMonthName,

    DATEFROMPARTS(
        YEAR(v.ReviewDate),
        MONTH(v.ReviewDate),
        1
    ) AS ReviewMonthStart,

    /* ========================================================
       3. CUSTOMER DETAILS
       ======================================================== */

    c.CustomerName,
    c.Gender,
    c.Age,

    CASE
        WHEN c.Age < 25 THEN 'Under 25'
        WHEN c.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS AgeGroup,

    /* ========================================================
       4. PRODUCT DETAILS
       ======================================================== */

    p.ProductName,

    p.Category AS ProductCategory,

    p.Price,

    /* ========================================================
       5. SENTIMENT DETAILS
       ======================================================== */

    v.SentimentScore,

    v.TextSentimentLabel,

    v.SentimentCategory,

    /* ========================================================
       6. RATING GROUP
       ======================================================== */

    CASE
        WHEN v.Rating >= 4 THEN 'High Rating'
        WHEN v.Rating = 3 THEN 'Neutral Rating'
        ELSE 'Low Rating'
    END AS RatingGroup,

    /* ========================================================
       7. RATING VS SENTIMENT
       ======================================================== */

    CASE

        WHEN v.Rating >= 4
             AND v.TextSentimentLabel = 'Negative'
        THEN 'Negative Sentiment - High Rating'

        WHEN v.Rating <= 2
             AND v.TextSentimentLabel = 'Positive'
        THEN 'Positive Sentiment - Low Rating'

        ELSE 'Aligned'

    END AS RatingSentimentStatus,

    /* ========================================================
       8. NEGATIVE REVIEW FLAG
       ======================================================== */

    CASE
        WHEN v.TextSentimentLabel = 'Negative'
        THEN 1
        ELSE 0
    END AS NegativeReviewFlag,

    /* ========================================================
       9. POSITIVE REVIEW FLAG
       ======================================================== */

    CASE
        WHEN v.TextSentimentLabel = 'Positive'
        THEN 1
        ELSE 0
    END AS PositiveReviewFlag,

    /* ========================================================
       10. NEUTRAL REVIEW FLAG
       ======================================================== */

    CASE
        WHEN v.TextSentimentLabel = 'Neutral'
        THEN 1
        ELSE 0
    END AS NeutralReviewFlag,

    /* ========================================================
       11. REVIEW COUNT
       ======================================================== */

    1 AS ReviewCount

FROM dbo.vw_review_sentiment_analysis AS v

LEFT JOIN dbo.customers AS c
    ON v.CustomerID = c.CustomerID

LEFT JOIN dbo.products AS p
    ON v.ProductID = p.ProductID;

GO


/* ============================================================
   1. CHECK FINAL POWER BI VIEW
   ============================================================ */

SELECT TOP 20 *
FROM dbo.vw_powerbi_customer_sentiment
ORDER BY ReviewDate;

GO


/* ============================================================
   2. TOTAL REVIEWS
   ============================================================ */

SELECT
    COUNT(*) AS TotalReviews
FROM dbo.vw_powerbi_customer_sentiment;

GO


/* ============================================================
   3. OVERALL SENTIMENT ANALYSIS
   ============================================================ */

SELECT
    TextSentimentLabel,

    COUNT(*) AS ReviewCount,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY
    TextSentimentLabel

ORDER BY
    ReviewCount DESC;

GO


/* ============================================================
   4. RATING VS SENTIMENT
   ============================================================ */

SELECT
    Rating,

    TextSentimentLabel,

    COUNT(*) AS ReviewCount,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY
    Rating,
    TextSentimentLabel

ORDER BY
    Rating,
    ReviewCount DESC;

GO


/* ============================================================
   5. SENTIMENT MISMATCH ANALYSIS
   ============================================================ */

SELECT
    RatingSentimentStatus,

    COUNT(*) AS ReviewCount

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY
    RatingSentimentStatus

ORDER BY
    ReviewCount DESC;

GO


/* ============================================================
   6. MISMATCH RATE
   ============================================================ */

SELECT

    COUNT(*) AS TotalReviews,

    SUM(
        CASE
            WHEN RatingSentimentStatus <> 'Aligned'
            THEN 1
            ELSE 0
        END
    ) AS MismatchReviews,

    CAST(

        100.0 *
        SUM(
            CASE
                WHEN RatingSentimentStatus <> 'Aligned'
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(*), 0)

        AS DECIMAL(10,2)

    ) AS MismatchRate

FROM dbo.vw_powerbi_customer_sentiment;

GO


/* ============================================================
   7. PRODUCT SENTIMENT PERFORMANCE
   ============================================================ */

SELECT

    ProductID,

    ProductName,

    ProductCategory,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(NegativeReviewFlag) AS NegativeReviews,

    SUM(PositiveReviewFlag) AS PositiveReviews,

    CAST(

        100.0 *
        SUM(NegativeReviewFlag)
        / NULLIF(COUNT(*),0)

        AS DECIMAL(10,2)

    ) AS NegativeReviewRate

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY

    ProductID,
    ProductName,
    ProductCategory

HAVING
    COUNT(*) >= 5

ORDER BY
    AvgSentimentScore ASC;

GO


/* ============================================================
   8. CATEGORY SENTIMENT PERFORMANCE
   ============================================================ */

SELECT

    ProductCategory,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(PositiveReviewFlag) AS PositiveReviews,

    SUM(NeutralReviewFlag) AS NeutralReviews,

    SUM(NegativeReviewFlag) AS NegativeReviews,

    CAST(
        100.0 *
        SUM(NegativeReviewFlag)
        / NULLIF(COUNT(*),0)
        AS DECIMAL(10,2)
    ) AS NegativeReviewRate

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY
    ProductCategory

ORDER BY
    AvgSentimentScore ASC;

GO


/* ============================================================
   9. MONTHLY SENTIMENT TREND
   ============================================================ */

SELECT

    ReviewYear,

    ReviewMonth,

    ReviewMonthName,

    ReviewMonthStart,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(PositiveReviewFlag) AS PositiveReviews,

    SUM(NeutralReviewFlag) AS NeutralReviews,

    SUM(NegativeReviewFlag) AS NegativeReviews

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY

    ReviewYear,
    ReviewMonth,
    ReviewMonthName,
    ReviewMonthStart

ORDER BY
    ReviewMonthStart;

GO


/* ============================================================
   10. AGE GROUP ANALYSIS
   ============================================================ */

SELECT

    AgeGroup,

    COUNT(*) AS ReviewCount,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(NegativeReviewFlag) AS NegativeReviews,

    SUM(PositiveReviewFlag) AS PositiveReviews

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY
    AgeGroup

ORDER BY
    AgeGroup;

GO


/* ============================================================
   11. GENDER SENTIMENT ANALYSIS
   ============================================================ */

SELECT

    Gender,

    COUNT(*) AS ReviewCount,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(NegativeReviewFlag) AS NegativeReviews,

    SUM(PositiveReviewFlag) AS PositiveReviews

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY
    Gender

ORDER BY
    ReviewCount DESC;

GO


/* ============================================================
   12. NEGATIVE REVIEW RATE
   ============================================================ */

SELECT

    COUNT(*) AS TotalReviews,

    SUM(NegativeReviewFlag) AS NegativeReviews,

    CAST(

        100.0 *
        SUM(NegativeReviewFlag)
        / NULLIF(COUNT(*),0)

        AS DECIMAL(10,2)

    ) AS NegativeReviewRate

FROM dbo.vw_powerbi_customer_sentiment;

GO


/* ============================================================
   13. POSITIVE REVIEW RATE
   ============================================================ */

SELECT

    COUNT(*) AS TotalReviews,

    SUM(PositiveReviewFlag) AS PositiveReviews,

    CAST(

        100.0 *
        SUM(PositiveReviewFlag)
        / NULLIF(COUNT(*),0)

        AS DECIMAL(10,2)

    ) AS PositiveReviewRate

FROM dbo.vw_powerbi_customer_sentiment;

GO


/* ============================================================
   14. MOST NEGATIVE PRODUCTS
   ============================================================ */

SELECT TOP 10

    ProductID,

    ProductName,

    ProductCategory,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(NegativeReviewFlag) AS NegativeReviews,

    CAST(

        100.0 *
        SUM(NegativeReviewFlag)
        / NULLIF(COUNT(*),0)

        AS DECIMAL(10,2)

    ) AS NegativeReviewRate

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY

    ProductID,
    ProductName,
    ProductCategory

HAVING
    COUNT(*) >= 5

ORDER BY
    AvgSentimentScore ASC;

GO


/* ============================================================
   15. MOST POSITIVE PRODUCTS
   ============================================================ */

SELECT TOP 10

    ProductID,

    ProductName,

    ProductCategory,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(PositiveReviewFlag) AS PositiveReviews,

    CAST(

        100.0 *
        SUM(PositiveReviewFlag)
        / NULLIF(COUNT(*),0)

        AS DECIMAL(10,2)

    ) AS PositiveReviewRate

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY

    ProductID,
    ProductName,
    ProductCategory

HAVING
    COUNT(*) >= 5

ORDER BY
    AvgSentimentScore DESC;

GO


/* ============================================================
   16. HIGH-RATING NEGATIVE REVIEWS
   ============================================================ */

SELECT TOP 20

    ReviewID,

    CustomerID,

    ProductID,

    ReviewDate,

    Rating,

    SentimentScore,

    TextSentimentLabel,

    RatingSentimentStatus,

    ReviewText

FROM dbo.vw_powerbi_customer_sentiment

WHERE

    Rating >= 4

    AND TextSentimentLabel = 'Negative'

ORDER BY
    SentimentScore ASC;

GO


/* ============================================================
   17. LOW-RATING POSITIVE REVIEWS
   ============================================================ */

SELECT TOP 20

    ReviewID,

    CustomerID,

    ProductID,

    ReviewDate,

    Rating,

    SentimentScore,

    TextSentimentLabel,

    RatingSentimentStatus,

    ReviewText

FROM dbo.vw_powerbi_customer_sentiment

WHERE

    Rating <= 2

    AND TextSentimentLabel = 'Positive'

ORDER BY
    SentimentScore DESC;

GO


/* ============================================================
   18. CUSTOMER SENTIMENT PERFORMANCE
   ============================================================ */

SELECT

    CustomerID,

    CustomerName,

    COUNT(*) AS ReviewCount,

    CAST(
        AVG(SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(NegativeReviewFlag) AS NegativeReviews,

    SUM(PositiveReviewFlag) AS PositiveReviews

FROM dbo.vw_powerbi_customer_sentiment

GROUP BY

    CustomerID,
    CustomerName

HAVING
    COUNT(*) >= 2

ORDER BY
    AvgSentimentScore ASC;

GO


/* ============================================================
   19. CUSTOMER SEGMENTATION
   ============================================================ */

WITH CustomerSentiment AS
(
    SELECT

        CustomerID,

        CustomerName,

        COUNT(*) AS ReviewCount,

        AVG(SentimentScore) AS AvgSentimentScore,

        AVG(
            CAST(Rating AS DECIMAL(10,2))
        ) AS AvgRating

    FROM dbo.vw_powerbi_customer_sentiment

    GROUP BY

        CustomerID,
        CustomerName

    HAVING
        COUNT(*) >= 2
),

CustomerSegments AS
(
    SELECT

        *,

        NTILE(4) OVER (
            ORDER BY AvgSentimentScore
        ) AS SentimentQuartile

    FROM CustomerSentiment
)

SELECT

    CustomerID,

    CustomerName,

    ReviewCount,

    CAST(
        AvgSentimentScore
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AvgRating
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SentimentQuartile,

    CASE

        WHEN SentimentQuartile = 1
            THEN 'At-Risk Customers'

        WHEN SentimentQuartile = 2
            THEN 'Needs Attention'

        WHEN SentimentQuartile = 3
            THEN 'Satisfied'

        ELSE 'Highly Satisfied'

    END AS CustomerSegment

FROM CustomerSegments

ORDER BY

    SentimentQuartile,

    AvgSentimentScore;

GO


/* ============================================================
   20. FINAL VIEW COLUMN CHECK
   ============================================================ */

SELECT

    COLUMN_NAME,

    DATA_TYPE

FROM INFORMATION_SCHEMA.COLUMNS

WHERE

    TABLE_SCHEMA = 'dbo'

    AND TABLE_NAME = 'vw_powerbi_customer_sentiment'

ORDER BY
    ORDINAL_POSITION;

GO


/* ============================================================
   21. FINAL ROW COUNT CHECK
   ============================================================ */

SELECT

    COUNT(*) AS FinalViewRows

FROM dbo.vw_powerbi_customer_sentiment;

GO