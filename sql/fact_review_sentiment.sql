USE [PortfolioProject_MarketingAnalytics]
GO

/****** Object:  Table [dbo].[fact_review_sentiment]    Script Date: 28-08-2026 23:07:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fact_review_sentiment](
	[ReviewID] [smallint] NOT NULL,
	[SentimentScore] [decimal](5, 4) NOT NULL,
	[TextSentimentLabel] [varchar](20) NOT NULL,
	[SentimentBucket] [varchar](20) NOT NULL,
	[SentimentCategory] [varchar](30) NOT NULL,
 CONSTRAINT [PK_fact_review_sentiment] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


