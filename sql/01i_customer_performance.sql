USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   QUERY 04 — CUSTOMER-LEVEL PERFORMANCE

   Business Question:
   Which customers generate the most reviews and
   what is the quality of their feedback?

   Concepts:
   - CTE
   - LEFT JOIN
   - GROUP BY
   - Conditional Aggregation
   - Window Functions
   - PERCENT_RANK
   ========================================================= */

WITH CustomerPerformance AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        c.Country,
        c.City,

        COUNT(r.ReviewID) AS TotalReviews,

        COUNT(DISTINCT r.ProductID) AS ProductsReviewed,

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
        ) AS NegativeReviews

    FROM dbo.dim_customers c

    LEFT JOIN dbo.fact_customer_reviews r
        ON c.CustomerID = r.CustomerID

    GROUP BY
        c.CustomerID,
        c.CustomerName,
        c.Country,
        c.City
)

SELECT
    CustomerID,
    CustomerName,
    Country,
    City,
    TotalReviews,
    ProductsReviewed,
    AverageRating,
    PositiveReviews,
    NegativeReviews,

    CAST(
        100.0 * PositiveReviews
        / NULLIF(TotalReviews, 0)
        AS DECIMAL(10,2)
    ) AS PositiveReviewPercentage,

    PERCENT_RANK() OVER (
        ORDER BY TotalReviews
    ) AS ReviewActivityPercentile

FROM CustomerPerformance

ORDER BY
    TotalReviews DESC,
    AverageRating DESC;


USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   QUERY 05 — RATING DISTRIBUTION & SATISFACTION

   Business Question:
   How is customer satisfaction distributed across ratings?

   Concepts:
   - CTE
   - Conditional Aggregation
   - Window Functions
   - Percentage of Total
   ========================================================= */

WITH RatingSummary AS
(
    SELECT
        Rating,
        COUNT(*) AS ReviewCount
    FROM dbo.fact_customer_reviews
    GROUP BY Rating
),

TotalReviews AS
(
    SELECT
        SUM(ReviewCount) AS TotalReviewCount
    FROM RatingSummary
)

SELECT
    rs.Rating,
    rs.ReviewCount,

    CAST(
        100.0 * rs.ReviewCount
        / NULLIF(tr.TotalReviewCount, 0)
        AS DECIMAL(10,2)
    ) AS RatingPercentage,

    SUM(rs.ReviewCount) OVER (
        ORDER BY rs.Rating
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeReviews,

    CAST(
        100.0 *
        SUM(rs.ReviewCount) OVER (
            ORDER BY rs.Rating
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
        / NULLIF(tr.TotalReviewCount, 0)
        AS DECIMAL(10,2)
    ) AS CumulativePercentage

FROM RatingSummary rs
CROSS JOIN TotalReviews tr

ORDER BY rs.Rating;