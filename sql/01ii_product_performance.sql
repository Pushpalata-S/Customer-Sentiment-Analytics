USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   QUERY 02 — PRODUCT PERFORMANCE ANALYSIS

   Business Question:
   Which products have the strongest customer performance?

   Concepts:
   - JOIN
   - GROUP BY
   - CASE
   - Aggregation
   - NULLIF
   - Conditional aggregation
   ========================================================= */

SELECT
    p.ProductID,
    p.ProductName,

    COUNT(r.ReviewID) AS TotalReviews,

    COUNT(DISTINCT r.CustomerID) AS UniqueCustomers,

    CAST(
        AVG(CAST(r.Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AverageRating,

    SUM(
        CASE
            WHEN r.Rating >= 4 THEN 1
            ELSE 0
        END
    ) AS PositiveReviews,

    SUM(
        CASE
            WHEN r.Rating <= 2 THEN 1
            ELSE 0
        END
    ) AS NegativeReviews,

    CAST(
        100.0 *
        SUM(CASE WHEN r.Rating >= 4 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(r.ReviewID), 0)
        AS DECIMAL(10,2)
    ) AS PositiveReviewPercentage,

    CAST(
        100.0 *
        SUM(CASE WHEN r.Rating <= 2 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(r.ReviewID), 0)
        AS DECIMAL(10,2)
    ) AS NegativeReviewPercentage

FROM dbo.dim_products p

LEFT JOIN dbo.fact_customer_reviews r
    ON p.ProductID = r.ProductID

GROUP BY
    p.ProductID,
    p.ProductName

ORDER BY
    AverageRating DESC,
    TotalReviews DESC;


USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   QUERY 03 — PRODUCT RANKING

   Business Question:
   How do products rank based on customer feedback?

   Concepts:
   - CTE
   - JOIN
   - GROUP BY
   - Window Functions
   - RANK
   - DENSE_RANK
   - ROW_NUMBER
   ========================================================= */

WITH ProductPerformance AS
(
    SELECT
        p.ProductID,
        p.ProductName,

        COUNT(r.ReviewID) AS TotalReviews,

        CAST(
            AVG(CAST(r.Rating AS DECIMAL(10,2)))
            AS DECIMAL(10,2)
        ) AS AverageRating

    FROM dbo.dim_products p

    LEFT JOIN dbo.fact_customer_reviews r
        ON p.ProductID = r.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName
)

SELECT
    ProductID,
    ProductName,
    TotalReviews,
    AverageRating,

    RANK() OVER (
        ORDER BY AverageRating DESC
    ) AS RatingRank,

    DENSE_RANK() OVER (
        ORDER BY AverageRating DESC
    ) AS DenseRatingRank,

    ROW_NUMBER() OVER (
        ORDER BY AverageRating DESC, TotalReviews DESC
    ) AS ProductRowNumber

FROM ProductPerformance

ORDER BY
    RatingRank,
    TotalReviews DESC;