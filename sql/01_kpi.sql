USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   QUERY 01 — CUSTOMER REVIEW & RATING KPI BASELINE
   Purpose:
   - Total reviews
   - Unique customers
   - Unique products
   - Average rating
   - Rating distribution
   - Min / Max rating
   ========================================================= */

SELECT
    COUNT(*) AS TotalReviews,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers,
    COUNT(DISTINCT ProductID) AS UniqueProducts,
    CAST(AVG(CAST(Rating AS DECIMAL(10,2))) AS DECIMAL(10,2))
        AS AverageRating,
    MIN(Rating) AS MinimumRating,
    MAX(Rating) AS MaximumRating,

    SUM(CASE WHEN Rating >= 4 THEN 1 ELSE 0 END) AS PositiveRatingReviews,

    SUM(CASE WHEN Rating <= 2 THEN 1 ELSE 0 END) AS NegativeRatingReviews,

    CAST(
        100.0 * SUM(CASE WHEN Rating >= 4 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS PositiveRatingPercentage,

    CAST(
        100.0 * SUM(CASE WHEN Rating <= 2 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS NegativeRatingPercentage

FROM dbo.fact_customer_reviews;