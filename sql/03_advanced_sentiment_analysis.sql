-- Overall sentiment analysis

USE PortfolioProject_MarketingAnalytics;
GO

SELECT
    TextSentimentLabel,
    COUNT(*) AS ReviewCount,
    CAST(AVG(SentimentScore) AS DECIMAL(10,4)) AS AvgSentimentScore,
    CAST(AVG(CAST(Rating AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS AvgRating
FROM dbo.vw_review_sentiment_analysis
GROUP BY TextSentimentLabel
ORDER BY ReviewCount DESC;



-- Find rating vs sentiment mismatch
SELECT
    Rating,
    TextSentimentLabel,
    COUNT(*) AS ReviewCount
FROM dbo.vw_review_sentiment_analysis
GROUP BY
    Rating,
    TextSentimentLabel
ORDER BY
    Rating,
    ReviewCount DESC;

-- Find problematic products
SELECT
    ProductID,
    COUNT(*) AS TotalReviews,
    SUM(CASE
        WHEN TextSentimentLabel = 'Negative' THEN 1
        ELSE 0
    END) AS NegativeReviews,

    CAST(
        100.0 * SUM(CASE
            WHEN TextSentimentLabel = 'Negative' THEN 1
            ELSE 0
        END) / COUNT(*)
        AS DECIMAL(10,2)
    ) AS NegativeReviewPercentage,

    AVG(SentimentScore) AS AvgSentimentScore,
    AVG(CAST(Rating AS DECIMAL(10,2))) AS AvgRating

FROM dbo.vw_review_sentiment_analysis

GROUP BY ProductID

HAVING COUNT(*) >= 5

ORDER BY NegativeReviewPercentage DESC;

USE PortfolioProject_MarketingAnalytics;
GO

/* =========================================================
   1. PRODUCTS WITH THE WORST SENTIMENT
   ========================================================= */

SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Category,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(v.Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews

FROM dbo.vw_review_sentiment_analysis v

INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

HAVING COUNT(*) >= 5

ORDER BY
    AvgSentimentScore ASC;

GO


/* =========================================================
   2. PRODUCTS WITH THE STRONGEST SENTIMENT
   ========================================================= */

SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Category,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(v.Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Positive'
            THEN 1
            ELSE 0
        END
    ) AS PositiveReviews,

    CAST(
        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Positive'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS PositiveReviewRate

FROM dbo.vw_review_sentiment_analysis v

INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

HAVING COUNT(*) >= 5

ORDER BY
    AvgSentimentScore DESC;

GO


/* =========================================================
   3. PRODUCT SENTIMENT MATRIX
   ========================================================= */

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    COUNT(*) AS TotalReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Positive'
            THEN 1
            ELSE 0
        END
    ) AS PositiveReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Neutral'
            THEN 1
            ELSE 0
        END
    ) AS NeutralReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(v.Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating

FROM dbo.vw_review_sentiment_analysis v

INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY
    AvgSentimentScore DESC;

GO


/* =========================================================
   4. PRODUCTS THAT NEED IMMEDIATE ATTENTION
   ========================================================= */

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(v.Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews,

    CAST(
        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Negative'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS NegativeReviewRate

FROM dbo.vw_review_sentiment_analysis v

INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

HAVING
    COUNT(*) >= 5
    AND AVG(v.SentimentScore) < 0

ORDER BY
    NegativeReviewRate DESC;

GO


/* =========================================================
   5. CUSTOMER-LEVEL SENTIMENT ANALYSIS
   ========================================================= */

SELECT
    v.CustomerID,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Positive'
            THEN 1
            ELSE 0
        END
    ) AS PositiveReviews

FROM dbo.vw_review_sentiment_analysis v

GROUP BY
    v.CustomerID

HAVING COUNT(*) >= 3

ORDER BY
    AvgSentimentScore ASC;

GO


/* =========================================================
   6. MONTHLY SENTIMENT TREND
   ========================================================= */

SELECT
    YEAR(v.ReviewDate) AS ReviewYear,
    MONTH(v.ReviewDate) AS ReviewMonth,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Positive'
            THEN 1
            ELSE 0
        END
    ) AS PositiveReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Neutral'
            THEN 1
            ELSE 0
        END
    ) AS NeutralReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews

FROM dbo.vw_review_sentiment_analysis v

GROUP BY
    YEAR(v.ReviewDate),
    MONTH(v.ReviewDate)

ORDER BY
    ReviewYear,
    ReviewMonth;

GO

/* =========================================================
   7. RATING VS SENTIMENT MISMATCH
   ========================================================= */

SELECT
    v.Rating,
    v.TextSentimentLabel,

    COUNT(*) AS ReviewCount,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore

FROM dbo.vw_review_sentiment_analysis v

GROUP BY
    v.Rating,
    v.TextSentimentLabel

ORDER BY
    v.Rating,
    ReviewCount DESC;

GO


/* =========================================================
   8. NEGATIVE REVIEWS WITH HIGH RATINGS
   ========================================================= */

SELECT
    v.ReviewID,
    v.CustomerID,
    v.ProductID,
    v.ReviewDate,
    v.Rating,
    v.SentimentScore,
    v.TextSentimentLabel,
    v.ReviewText

FROM dbo.vw_review_sentiment_analysis v

WHERE
    v.Rating >= 4
    AND v.TextSentimentLabel = 'Negative'

ORDER BY
    v.SentimentScore ASC;

GO


/* =========================================================
   9. POSITIVE REVIEWS WITH LOW RATINGS
   ========================================================= */

SELECT
    v.ReviewID,
    v.CustomerID,
    v.ProductID,
    v.ReviewDate,
    v.Rating,
    v.SentimentScore,
    v.TextSentimentLabel,
    v.ReviewText

FROM dbo.vw_review_sentiment_analysis v

WHERE
    v.Rating <= 2
    AND v.TextSentimentLabel = 'Positive'

ORDER BY
    v.SentimentScore DESC;

GO


/* =========================================================
   10. MISMATCH RATE BETWEEN RATING AND SENTIMENT
   ========================================================= */

SELECT
    COUNT(*) AS TotalReviews,

    SUM(
        CASE
            WHEN
                (v.Rating >= 4 AND v.TextSentimentLabel = 'Negative')
                OR
                (v.Rating <= 2 AND v.TextSentimentLabel = 'Positive')
            THEN 1
            ELSE 0
        END
    ) AS MismatchReviews,

    CAST(
        SUM(
            CASE
                WHEN
                    (v.Rating >= 4 AND v.TextSentimentLabel = 'Negative')
                    OR
                    (v.Rating <= 2 AND v.TextSentimentLabel = 'Positive')
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS MismatchRate

FROM dbo.vw_review_sentiment_analysis v;

GO


/* =========================================================
   11. RANK PRODUCTS BY AVERAGE SENTIMENT
   ========================================================= */

WITH ProductSentiment AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

        COUNT(*) AS TotalReviews,

        CAST(
            AVG(v.SentimentScore)
            AS DECIMAL(10,4)
        ) AS AvgSentimentScore

    FROM dbo.vw_review_sentiment_analysis v

    INNER JOIN dbo.products p
        ON v.ProductID = p.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category

    HAVING COUNT(*) >= 5
)

SELECT
    ProductID,
    ProductName,
    Category,
    TotalReviews,
    AvgSentimentScore,

    RANK() OVER (
        ORDER BY AvgSentimentScore DESC
    ) AS SentimentRank,

    DENSE_RANK() OVER (
        ORDER BY AvgSentimentScore DESC
    ) AS DenseSentimentRank,

    ROW_NUMBER() OVER (
        ORDER BY AvgSentimentScore DESC
    ) AS RowNumber

FROM ProductSentiment

ORDER BY
    SentimentRank;

GO


/* =========================================================
   12. TOP 10 PRODUCTS BY SENTIMENT
   ========================================================= */

WITH ProductSentiment AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

        COUNT(*) AS TotalReviews,

        CAST(
            AVG(v.SentimentScore)
            AS DECIMAL(10,4)
        ) AS AvgSentimentScore

    FROM dbo.vw_review_sentiment_analysis v

    INNER JOIN dbo.products p
        ON v.ProductID = p.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category

    HAVING COUNT(*) >= 5
),

RankedProducts AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (
            ORDER BY AvgSentimentScore DESC
        ) AS ProductRank

    FROM ProductSentiment
)

SELECT
    ProductID,
    ProductName,
    Category,
    TotalReviews,
    AvgSentimentScore,
    ProductRank

FROM RankedProducts

WHERE ProductRank <= 10

ORDER BY
    ProductRank;

GO


/* =========================================================
   13. WORST 10 PRODUCTS BY SENTIMENT
   ========================================================= */

WITH ProductSentiment AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

        COUNT(*) AS TotalReviews,

        CAST(
            AVG(v.SentimentScore)
            AS DECIMAL(10,4)
        ) AS AvgSentimentScore

    FROM dbo.vw_review_sentiment_analysis v

    INNER JOIN dbo.products p
        ON v.ProductID = p.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category

    HAVING COUNT(*) >= 5
),

RankedProducts AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (
            ORDER BY AvgSentimentScore ASC
        ) AS ProductRank

    FROM ProductSentiment
)

SELECT
    ProductID,
    ProductName,
    Category,
    TotalReviews,
    AvgSentimentScore,
    ProductRank

FROM RankedProducts

WHERE ProductRank <= 10

ORDER BY
    ProductRank;

GO


/* =========================================================
   14. RANK PRODUCTS WITHIN EACH CATEGORY
   ========================================================= */

WITH ProductSentiment AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

        COUNT(*) AS TotalReviews,

        CAST(
            AVG(v.SentimentScore)
            AS DECIMAL(10,4)
        ) AS AvgSentimentScore

    FROM dbo.vw_review_sentiment_analysis v

    INNER JOIN dbo.products p
        ON v.ProductID = p.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category

    HAVING COUNT(*) >= 5
)

SELECT
    ProductID,
    ProductName,
    Category,
    TotalReviews,
    AvgSentimentScore,

    RANK() OVER (
        PARTITION BY Category
        ORDER BY AvgSentimentScore DESC
    ) AS CategorySentimentRank

FROM ProductSentiment

ORDER BY
    Category,
    CategorySentimentRank;

GO

/* =========================================================
   15. CATEGORY-LEVEL SENTIMENT ANALYSIS
   ========================================================= */

SELECT
    p.Category,

    COUNT(*) AS TotalReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Positive'
            THEN 1
            ELSE 0
        END
    ) AS PositiveReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Neutral'
            THEN 1
            ELSE 0
        END
    ) AS NeutralReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(v.Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating

FROM dbo.vw_review_sentiment_analysis v

INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID

GROUP BY
    p.Category

ORDER BY
    AvgSentimentScore DESC;

GO


/* =========================================================
   16. CATEGORY NEGATIVE REVIEW RATE
   ========================================================= */

SELECT
    p.Category,

    COUNT(*) AS TotalReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews,

    CAST(
        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Negative'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS NegativeReviewRate,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore

FROM dbo.vw_review_sentiment_analysis v

INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID

GROUP BY
    p.Category

ORDER BY
    NegativeReviewRate DESC;

GO


/* =========================================================
   17. CATEGORY RANKING BY SENTIMENT
   ========================================================= */

WITH CategorySentiment AS
(
    SELECT
        p.Category,

        COUNT(*) AS TotalReviews,

        CAST(
            AVG(v.SentimentScore)
            AS DECIMAL(10,4)
        ) AS AvgSentimentScore,

        CAST(
            AVG(CAST(v.Rating AS DECIMAL(10,2)))
            AS DECIMAL(10,2)
        ) AS AvgRating

    FROM dbo.vw_review_sentiment_analysis v

    INNER JOIN dbo.products p
        ON v.ProductID = p.ProductID

    GROUP BY
        p.Category
)

SELECT
    Category,
    TotalReviews,
    AvgSentimentScore,
    AvgRating,

    RANK() OVER (
        ORDER BY AvgSentimentScore DESC
    ) AS SentimentRank

FROM CategorySentiment

ORDER BY
    SentimentRank;

GO


/* =========================================================
   18. CATEGORY HEALTH SCORE
   ========================================================= */

SELECT
    p.Category,

    COUNT(*) AS TotalReviews,

    CAST(
        AVG(v.SentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        AVG(CAST(v.Rating AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS AvgRating,

    CAST(
        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Positive'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS PositiveRate,

    CAST(
        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Negative'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS NegativeRate

FROM dbo.vw_review_sentiment_analysis v

INNER JOIN dbo.products p
    ON v.ProductID = p.ProductID

GROUP BY
    p.Category

ORDER BY
    NegativeRate DESC;

GO

/* =========================================================
   19. MONTHLY SENTIMENT TREND
   ========================================================= */

WITH MonthlySentiment AS
(
    SELECT
        YEAR(v.ReviewDate) AS ReviewYear,
        MONTH(v.ReviewDate) AS ReviewMonth,

        COUNT(*) AS TotalReviews,

        CAST(
            AVG(v.SentimentScore)
            AS DECIMAL(10,4)
        ) AS AvgSentimentScore,

        CAST(
            AVG(CAST(v.Rating AS DECIMAL(10,2)))
            AS DECIMAL(10,2)
        ) AS AvgRating,

        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Positive'
                THEN 1
                ELSE 0
            END
        ) AS PositiveReviews,

        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Negative'
                THEN 1
                ELSE 0
            END
        ) AS NegativeReviews

    FROM dbo.vw_review_sentiment_analysis v

    GROUP BY
        YEAR(v.ReviewDate),
        MONTH(v.ReviewDate)
)

SELECT
    ReviewYear,
    ReviewMonth,
    TotalReviews,
    AvgSentimentScore,
    AvgRating,
    PositiveReviews,
    NegativeReviews

FROM MonthlySentiment

ORDER BY
    ReviewYear,
    ReviewMonth;

GO


/* =========================================================
   20. MONTH-OVER-MONTH SENTIMENT CHANGE
   ========================================================= */

WITH MonthlySentiment AS
(
    SELECT
        YEAR(v.ReviewDate) AS ReviewYear,
        MONTH(v.ReviewDate) AS ReviewMonth,

        COUNT(*) AS TotalReviews,

        AVG(v.SentimentScore) AS AvgSentimentScore

    FROM dbo.vw_review_sentiment_analysis v

    GROUP BY
        YEAR(v.ReviewDate),
        MONTH(v.ReviewDate)
),

SentimentWithPreviousMonth AS
(
    SELECT
        ReviewYear,
        ReviewMonth,
        TotalReviews,
        AvgSentimentScore,

        LAG(AvgSentimentScore) OVER (
            ORDER BY ReviewYear, ReviewMonth
        ) AS PreviousMonthSentiment

    FROM MonthlySentiment
)

SELECT
    ReviewYear,
    ReviewMonth,
    TotalReviews,

    CAST(
        AvgSentimentScore
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        PreviousMonthSentiment
        AS DECIMAL(10,4)
    ) AS PreviousMonthSentiment,

    CAST(
        AvgSentimentScore - PreviousMonthSentiment
        AS DECIMAL(10,4)
    ) AS SentimentChange

FROM SentimentWithPreviousMonth

ORDER BY
    ReviewYear,
    ReviewMonth;

GO


/* =========================================================
   21. MONTHLY SENTIMENT DETERIORATION ALERT
   ========================================================= */

WITH MonthlySentiment AS
(
    SELECT
        YEAR(v.ReviewDate) AS ReviewYear,
        MONTH(v.ReviewDate) AS ReviewMonth,

        AVG(v.SentimentScore) AS AvgSentimentScore

    FROM dbo.vw_review_sentiment_analysis v

    GROUP BY
        YEAR(v.ReviewDate),
        MONTH(v.ReviewDate)
),

SentimentComparison AS
(
    SELECT
        ReviewYear,
        ReviewMonth,
        AvgSentimentScore,

        LAG(AvgSentimentScore) OVER (
            ORDER BY ReviewYear, ReviewMonth
        ) AS PreviousMonthSentiment

    FROM MonthlySentiment
)

SELECT
    ReviewYear,
    ReviewMonth,

    CAST(
        AvgSentimentScore
        AS DECIMAL(10,4)
    ) AS AvgSentimentScore,

    CAST(
        PreviousMonthSentiment
        AS DECIMAL(10,4)
    ) AS PreviousMonthSentiment,

    CAST(
        AvgSentimentScore - PreviousMonthSentiment
        AS DECIMAL(10,4)
    ) AS SentimentChange,

    CASE
        WHEN AvgSentimentScore - PreviousMonthSentiment <= -0.10
            THEN 'Significant Deterioration'

        WHEN AvgSentimentScore - PreviousMonthSentiment < 0
            THEN 'Deterioration'

        WHEN AvgSentimentScore - PreviousMonthSentiment >= 0.10
            THEN 'Significant Improvement'

        ELSE 'Stable / Minor Change'
    END AS SentimentTrend

FROM SentimentComparison

WHERE PreviousMonthSentiment IS NOT NULL

ORDER BY
    ReviewYear,
    ReviewMonth;

GO


/* =========================================================
   22. MONTHLY NEGATIVE REVIEW RATE
   ========================================================= */

SELECT
    YEAR(v.ReviewDate) AS ReviewYear,
    MONTH(v.ReviewDate) AS ReviewMonth,

    COUNT(*) AS TotalReviews,

    SUM(
        CASE
            WHEN v.TextSentimentLabel = 'Negative'
            THEN 1
            ELSE 0
        END
    ) AS NegativeReviews,

    CAST(
        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Negative'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS NegativeReviewRate

FROM dbo.vw_review_sentiment_analysis v

GROUP BY
    YEAR(v.ReviewDate),
    MONTH(v.ReviewDate)

ORDER BY
    ReviewYear,
    ReviewMonth;

GO

/* =========================================================
   23. CUSTOMER SENTIMENT SCORE
   ========================================================= */

WITH CustomerSentiment AS
(
    SELECT
        v.CustomerID,

        COUNT(*) AS TotalReviews,

        CAST(
            AVG(v.SentimentScore)
            AS DECIMAL(10,4)
        ) AS AvgSentimentScore,

        CAST(
            AVG(CAST(v.Rating AS DECIMAL(10,2)))
            AS DECIMAL(10,2)
        ) AS AvgRating,

        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Negative'
                THEN 1
                ELSE 0
            END
        ) AS NegativeReviews,

        SUM(
            CASE
                WHEN v.TextSentimentLabel = 'Positive'
                THEN 1
                ELSE 0
            END
        ) AS PositiveReviews

    FROM dbo.vw_review_sentiment_analysis v

    GROUP BY
        v.CustomerID

    HAVING COUNT(*) >= 2
)

SELECT
    CustomerID,
    TotalReviews,
    AvgSentimentScore,
    AvgRating,
    NegativeReviews,
    PositiveReviews

FROM CustomerSentiment

ORDER BY
    AvgSentimentScore DESC;

GO


/* =========================================================
   24. CUSTOMER EXPERIENCE SEGMENTATION
   NTILE() - DIVIDE CUSTOMERS INTO 4 GROUPS
   ========================================================= */

WITH CustomerSentiment AS
(
    SELECT
        v.CustomerID,

        COUNT(*) AS TotalReviews,

        AVG(v.SentimentScore) AS AvgSentimentScore,

        AVG(CAST(v.Rating AS DECIMAL(10,2))) AS AvgRating

    FROM dbo.vw_review_sentiment_analysis v

    GROUP BY
        v.CustomerID

    HAVING COUNT(*) >= 2
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
    TotalReviews,

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

        WHEN SentimentQuartile = 4
            THEN 'Highly Satisfied'

    END AS CustomerSegment

FROM CustomerSegments

ORDER BY
    SentimentQuartile,
    AvgSentimentScore;

GO


/* =========================================================
   25. CUSTOMER SEGMENT SUMMARY
   ========================================================= */

WITH CustomerSentiment AS
(
    SELECT
        v.CustomerID,

        COUNT(*) AS TotalReviews,

        AVG(v.SentimentScore) AS AvgSentimentScore,

        AVG(CAST(v.Rating AS DECIMAL(10,2))) AS AvgRating

    FROM dbo.vw_review_sentiment_analysis v

    GROUP BY
        v.CustomerID

    HAVING COUNT(*) >= 2
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
    SentimentQuartile,

    CASE
        WHEN SentimentQuartile = 1
            THEN 'At-Risk Customers'
        WHEN SentimentQuartile = 2
            THEN 'Needs Attention'
        WHEN SentimentQuartile = 3
            THEN 'Satisfied'
        ELSE 'Highly Satisfied'
    END AS CustomerSegment,

    COUNT(*) AS CustomerCount,

    CAST(
        AVG(AvgSentimentScore)
        AS DECIMAL(10,4)
    ) AS AvgSegmentSentiment,

    CAST(
        AVG(AvgRating)
        AS DECIMAL(10,2)
    ) AS AvgSegmentRating

FROM CustomerSegments

GROUP BY
    SentimentQuartile

ORDER BY
    SentimentQuartile;

GO
