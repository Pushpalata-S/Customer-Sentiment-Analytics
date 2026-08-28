# 📊 Customer Sentiment Analytics

**SQL Server • Python • NLTK VADER • Advanced SQL • Power BI • DAX • Customer Sentiment Analysis**

An end-to-end customer analytics project that transforms raw customer, product, engagement, journey, and review data into structured business insights using **SQL Server, Python NLP, advanced SQL analytics, and Power BI**.

---

# 📌 Project Overview

Customer reviews contain valuable information about customer experience, but raw review text and ratings alone are difficult to analyze at scale.

This project builds an end-to-end analytics pipeline that:

- Stores and structures raw business data in SQL Server
- Cleans and validates the data
- Creates fact and dimension tables
- Extracts customer reviews using Python
- Performs sentiment analysis using NLTK VADER
- Enriches customer review data with sentiment information
- Stores the enriched data back into SQL Server
- Performs advanced SQL analysis
- Creates a Power BI-ready analytical view
- Builds KPIs and analytical measures using DAX
- Presents the final insights through an interactive Power BI dashboard

The project focuses on answering business questions related to:

- Customer satisfaction
- Product performance
- Customer sentiment
- Rating vs sentiment mismatch
- Customer engagement
- Customer review activity
- Customer journey behavior

---

# 🔄 End-to-End Project Workflow

```text
Raw CSV Data
       ↓
SQL Server
       ↓
Data Cleaning & Validation
       ↓
Fact & Dimension Tables
       ↓
Python + Pandas
       ↓
NLTK VADER Sentiment Analysis
       ↓
Enriched Customer Reviews
       ↓
Sentiment Fact Table
       ↓
Advanced SQL Analytics
       ↓
Power BI Analytical View
       ↓
Power BI Data Model
       ↓
DAX Measures & KPIs
       ↓
Interactive Dashboard
       ↓
Business Insights
```

---

# 🎯 Business Problem

Businesses collect large amounts of customer feedback through reviews, ratings, engagement activities, and customer journeys.

However, raw data does not directly answer important business questions.

The project addresses questions such as:

- What percentage of customer reviews are positive, neutral, or negative?
- Which products receive the highest customer satisfaction?
- Which products receive poor customer feedback?
- Which customers are highly active in providing reviews?
- How do textual sentiments compare with numerical ratings?
- Are there customers giving high ratings while expressing negative sentiment?
- How does customer engagement relate to customer feedback?
- How does customer sentiment change over time?
- Which areas may require business improvement?

---

# 🎯 Project Objectives

The main objectives of the project are:

- Load raw business data into SQL Server
- Clean and validate source data
- Design a structured relational data model
- Create fact and dimension tables
- Extract review data using Python
- Apply NLP-based sentiment analysis
- Enrich customer reviews with sentiment scores
- Store sentiment-enriched data in SQL Server
- Perform advanced SQL analytics
- Create reusable analytical SQL views
- Prepare data for Power BI
- Create DAX-based KPIs
- Build an interactive customer sentiment dashboard
- Convert analytical results into business insights

---

# 📂 Dataset

The project uses multiple datasets related to customers, products, reviews, engagement, geography, and customer journeys.

### Main Source Tables

| Table | Description |
|---|---|
| customer_reviews | Customer review text and ratings |
| customers | Customer demographic and profile information |
| products | Product information |
| customer_journey | Customer interaction and journey information |
| engagement_data | Customer engagement metrics |
| geography | Geographic information |

---

# 🏗️ Data Model

To make the data easier to analyze, the raw data was transformed into a structured fact and dimension model.

### Dimension Tables
- dim_customers
- dim_products

These tables contain descriptive information about customers and products.

### Fact Tables
- fact_customer_reviews
- fact_customer_journey
- fact_engagement_data
- fact_review_sentiment

These tables contain measurable business events and analytical information.

---

# 🧩 Fact & Dimension Architecture

```text
                    dim_customers
                         |
                         |
                         ↓
                  fact_customer_reviews
                         |
                         ↓
                  fact_review_sentiment
                         |
                         |
dim_products -----------+
                         
                         
fact_customer_journey

fact_engagement_data
```

The model separates descriptive attributes from transactional/analytical data, making the database easier to query and connect with Power BI.

---

# 🧹 Data Cleaning & Validation

Before analysis, the raw data was processed and validated.

The workflow included:

- Checking duplicate records
- Validating missing values
- Standardizing data
- Checking data types
- Normalizing engagement-related data
- Validating customer and product relationships
- Preparing review text for NLP processing
- Structuring the data into fact and dimension tables

This ensured that the analytical layer was based on consistent and reliable data.

---

# 🐍 Python Data Processing

Python was used as the bridge between SQL Server and the sentiment-analysis pipeline.

The Python script:

```
python/customer_reviews_enrichment.py
```

performs the following operations:

```text
SQL Server
    ↓
Extract Customer Reviews
    ↓
Pandas DataFrame
    ↓
Text Processing
    ↓
VADER Sentiment Analysis
    ↓
Sentiment Classification
    ↓
Enriched Review Data
    ↓
SQL Server
```

---

# 🧠 Sentiment Analysis

Customer review text was analyzed using VADER (Valence Aware Dictionary and sEntiment Reasoner) from the NLTK library.

VADER produces a compound sentiment score ranging from approximately:

```
-1  ← Negative
 0  ← Neutral
+1  ← Positive
```

The sentiment score is then converted into meaningful sentiment categories.

### 📊 Sentiment Fields

The enriched review data contains sentiment-related fields such as:

| Field | Description |
|---|---|
| SentimentScore | Numerical VADER sentiment score |
| TextSentimentLabel | Original text sentiment classification |
| SentimentCategory | Business-oriented sentiment category |
| SentimentBucket | Grouped sentiment score range |

**Example:**

| Review | Sentiment Score | Sentiment |
|---|---|---|
| Excellent product, highly recommend! | 0.77 | Positive |
| Average experience | 0.00 | Neutral |
| Product did not meet expectations | -0.45 | Negative |

---

# 🔗 Sentiment Enrichment Pipeline

The original customer review data contains information such as:

- ReviewID
- CustomerID
- ProductID
- ReviewDate
- Rating
- ReviewText

Python enriches this information by adding:

- SentimentScore
- TextSentimentLabel
- SentimentCategory
- SentimentBucket

This creates a richer analytical dataset that combines:

```text
Numerical Feedback
        +
Textual Feedback
        ↓
Customer Sentiment Analysis
```

---

# 🗄️ SQL Server Analytical Layer

After sentiment analysis, the enriched review information is incorporated into the SQL Server analytical layer.

The project contains dedicated fact and dimension tables for analytical querying.

Important analytical tables include:

- dim_customers
- dim_products
- fact_customer_reviews
- fact_customer_journey
- fact_engagement_data
- fact_review_sentiment

This allows customer, product, review, engagement, and sentiment information to be analyzed together.

---

# 🧮 Advanced SQL Analytics

The project was expanded beyond basic SQL queries to include advanced analytical SQL.

Techniques used include:

- CTEs
- JOINs
- LEFT JOINs
- GROUP BY
- Conditional Aggregation
- CASE expressions
- NULLIF
- Window Functions
  - RANK
  - DENSE_RANK
  - ROW_NUMBER
  - PERCENT_RANK
  - SUM() OVER()
- Cumulative calculations
- SQL Views
- Analytical percentages

---

# 👥 Customer-Level Performance Analysis

Customer performance is analyzed using metrics such as:

- Total reviews
- Products reviewed
- Average rating
- Positive reviews
- Negative reviews
- Positive review percentage
- Review activity percentile

The analysis helps identify customers who are highly active in providing feedback.

---

# 📦 Product Performance Analysis

Products are evaluated using:

- Total reviews
- Unique customers
- Average rating
- Positive reviews
- Negative reviews
- Positive review percentage
- Negative review percentage

This helps identify high-performing and underperforming products.

---

# 🏆 Product Ranking

Products are ranked using multiple SQL window functions.

### RANK()

```sql
RANK() OVER (
    ORDER BY AverageRating DESC
) AS RatingRank
```

Ranks products according to average customer rating.

When two products have the same rating, they receive the same rank.

### DENSE_RANK()

```sql
DENSE_RANK() OVER (
    ORDER BY AverageRating DESC
) AS DenseRatingRank
```

Similar to RANK(), but does not leave gaps after tied rankings.

**Example:**

| Rating | RANK | DENSE_RANK |
|---|---|---|
| 4.9 | 1 | 1 |
| 4.8 | 2 | 2 |
| 4.8 | 2 | 2 |
| 4.7 | 4 | 3 |

### ROW_NUMBER()

```sql
ROW_NUMBER() OVER (
    ORDER BY AverageRating DESC, TotalReviews DESC
) AS ProductRowNumber
```

Assigns a unique sequential number to every product.

The secondary sorting condition of TotalReviews helps break ties between products with the same rating.

---

# 📈 Customer Review Activity Percentile

Customer review activity is analyzed using:

```sql
PERCENT_RANK() OVER (
    ORDER BY TotalReviews
) AS ReviewActivityPercentile
```

This calculates the relative position of a customer based on their total review activity.

A value closer to `0` represents a lower relative position, while a value closer to `1` represents a higher relative position.

---

# 📊 Rating Distribution Analysis

Customer ratings are analyzed using:

- Review count
- Rating percentage
- Cumulative review count
- Cumulative percentage

A cumulative calculation is created using:

```sql
SUM(ReviewCount) OVER (
    ORDER BY Rating
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
```

This helps understand how reviews accumulate across different rating levels.

---

# 🪟 SQL Window Functions

The project uses the following window functions:

| Function | Purpose |
|---|---|
| RANK() | Product ranking |
| DENSE_RANK() | Ranking without gaps |
| ROW_NUMBER() | Unique product ordering |
| PERCENT_RANK() | Relative customer review activity |
| SUM() OVER() | Cumulative review analysis |

These functions demonstrate advanced analytical SQL capabilities beyond simple aggregation.

---

# 🔗 Power BI Analytical View

A dedicated SQL Server view was created for Power BI:

```
vw_powerbi_customer_sentiment
```

The view creates a clean, analysis-ready dataset by combining review, customer, product, rating, and sentiment information.

It also generates business-friendly analytical fields such as:

- ReviewYear
- ReviewMonth
- ReviewMonthName
- ReviewMonthStart
- AgeGroup
- RatingGroup
- RatingSentimentStatus
- NegativeReviewFlag
- PositiveReviewFlag
- ReviewCount

This reduces repetitive transformations inside Power BI and centralizes important business logic in SQL Server.

---

# 📅 Time-Based Analysis

Review dates are transformed into analytical attributes:

- ReviewYear
- ReviewMonth
- ReviewMonthName
- ReviewMonthStart

These fields allow analysis of:

- Monthly review volume
- Rating trends
- Sentiment trends
- Customer feedback trends
- Changes in customer satisfaction over time

---

# 👥 Customer Segmentation

Customer age is converted into business-friendly groups:

- Under 25
- 25-34
- 35-44
- 45-54
- 55+

This allows customer satisfaction and sentiment to be compared across different customer segments.

---

# ⭐ Rating vs Sentiment Analysis

One of the key improvements in the project is the comparison between:

```text
Customer Rating
        +
Textual Sentiment
```

A customer may give a high numerical rating while expressing negative sentiment in the review text.

The project identifies these potential mismatches.

### High Rating + Negative Sentiment

```text
Rating >= 4
      +
Negative Sentiment
      ↓
Potential Hidden Customer Issue
```

### Low Rating + Positive Sentiment

```text
Rating <= 2
      +
Positive Sentiment
      ↓
Potential Rating/Text Mismatch
```

### Rating-Sentiment Status

A derived field:

```
RatingSentimentStatus
```

is used to classify these situations.

Possible categories include:

- Negative Sentiment - High Rating
- Positive Sentiment - Low Rating
- Aligned

This provides deeper customer experience analysis than using star ratings alone.

---

# 🚩 Review Flags

The analytical view also creates binary indicators:

- NegativeReviewFlag
- PositiveReviewFlag

Example:

```text
Negative Sentiment
        ↓
NegativeReviewFlag = 1
```

```text
Positive Sentiment
        ↓
PositiveReviewFlag = 1
```

These flags make filtering and KPI calculations easier in Power BI.

---

# 📊 Power BI Dashboard

The final Power BI dashboard brings together the SQL and Python outputs into an interactive analytical interface.

The dashboard focuses on:

- Customer satisfaction
- Customer sentiment
- Product performance
- Review activity
- Rating distribution
- Sentiment trends
- Customer segmentation
- Rating vs sentiment analysis
- Customer engagement
- Customer journey

---

# 🎯 Power BI KPIs

The dashboard can be used to monitor important metrics such as:

| KPI | Description |
|---|---|
| Total Reviews | Total customer reviews |
| Average Rating | Average star rating |
| Positive Reviews | Number of positive reviews |
| Negative Reviews | Number of negative reviews |
| Positive Sentiment % | Percentage of positive reviews |
| Negative Sentiment % | Percentage of negative reviews |
| Neutral Sentiment % | Percentage of neutral reviews |
| Average Sentiment Score | Average sentiment score |
| Products Reviewed | Number of products receiving reviews |
| Active Customers | Customers contributing reviews |

---

# 🧮 DAX

DAX is used in Power BI to create analytical measures and KPIs.

The DAX layer is used to support:

- Review metrics
- Customer metrics
- Sentiment analysis
- Percentage calculations
- Dashboard KPIs

The combination of:

```text
SQL Server
      ↓
Python
      ↓
SQL Analytical Layer
      ↓
Power BI
      ↓
DAX
```

creates a complete business intelligence workflow.

---

# 📊 Dashboard Analysis

The dashboard allows users to move from high-level KPIs into detailed analysis.

For example:

```text
Overall Customer Satisfaction
          ↓
Product Performance
          ↓
Individual Reviews
          ↓
Sentiment
          ↓
Potential Customer Issue
```

This makes the dashboard useful for both high-level business monitoring and detailed investigation.

---

# 💡 Business Insights Enabled

The project enables businesses to identify:

**Customer Satisfaction**
Understand the overall customer experience using ratings and sentiment.

**Product Performance**
Identify products receiving consistently high or low customer feedback.

**Negative Feedback**
Identify products and customers associated with negative reviews.

**Rating-Sentiment Mismatch**
Identify cases where numerical ratings and textual feedback tell different stories.

**Customer Engagement**
Analyze customer engagement and interaction behavior.

**Customer Journey**
Identify patterns and potential drop-off points in customer interactions.

**Sentiment Trends**
Track how customer sentiment changes over time.

---

# 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| SQL Server | Data storage and transformation |
| SSMS | SQL development and database management |
| Python | Data processing and sentiment analysis |
| Pandas | Data manipulation |
| NLTK | Natural Language Processing |
| VADER | Sentiment analysis |
| PyODBC | Python-SQL Server connectivity |
| SQLAlchemy | Database connectivity support |
| Power BI | Data visualization and dashboarding |
| DAX | KPI and analytical calculations |
| Git | Version control |
| GitHub | Project hosting |
| VS Code | Development environment |

---

# 📁 Project Structure

```text
Customer-Sentiment-Analytics/
│
├── data/
│   ├── raw/
│   │   ├── customer_reviews.csv
│   │   ├── customer_journey.csv
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── engagement_data.csv
│   │   └── geography.csv
│   │
│   └── processed/
│       └── fact_customer_reviews_enrich.csv
│
├── sql/
│   ├── 01_kpi.sql
│   ├── 01i_customer_performance.sql
│   ├── 01ii_product_performance.sql
│   ├── 02_sentiment_analysis.sql
│   ├── 03_advanced_sentiment_analysis.sql
│   ├── 04_sql_optimization.sql
│   ├── 05_powerbi_analytics_view.sql
│   ├── dim_customers.sql
│   ├── dim_products.sql
│   ├── fact_customer_reviews.sql
│   ├── fact_customer_journey.sql
│   ├── fact_engagement_data.sql
│   └── fact_review_sentiment.sql
│
├── python/
│   └── customer_reviews_enrichment.py
│
├── powerbi/
│   └── Customer_Sentiment_Analytics_Dashboard.pbix
│
├── images/
│   ├── duplicate_records.png
│   ├── normalise_engagement_data_table.png
│   ├── Products_vs_price.png
│   ├── standardized_data.png
│   └── star_relationship.png
│
├── README.md
└── .gitignore
```

> **Note:** File names in the structure should match the actual files present in the repository.

---

# ▶️ How to Run the Project

### Step 1 — Clone the Repository

```bash
git clone https://github.com/Pushpalata-S/Customer-Sentiment-Analytics.git
cd Customer-Sentiment-Analytics
```

### Step 2 — Set Up SQL Server

Open SQL Server Management Studio (SSMS) and connect to your SQL Server instance.

Example:

```
localhost\SQLEXPRESS
```

### Step 3 — Create the Database

Create:

```
PortfolioProject_MarketingAnalytics
```

### Step 4 — Import Source Data

Import the raw CSV files into SQL Server.

Main tables:

- customer_reviews
- customers
- products
- customer_journey
- engagement_data
- geography

### Step 5 — Create Fact & Dimension Tables

Execute the SQL scripts inside `sql/`.

Create the required:

```text
Dimension Tables
        ↓
Fact Tables
        ↓
Sentiment Fact Table
```

### Step 6 — Install Python Dependencies

```bash
pip install pandas nltk pyodbc sqlalchemy
```

### Step 7 — Download VADER Lexicon

```python
import nltk

nltk.download('vader_lexicon')
```

### Step 8 — Configure Database Connection

Open `python/customer_reviews_enrichment.py` and update the SQL Server connection details according to your local environment.

> Do not commit passwords or sensitive credentials to GitHub.

### Step 9 — Run Sentiment Analysis

From the project root:

```bash
python python/customer_reviews_enrichment.py
```

The script:

- Connects to SQL Server
- Extracts customer reviews
- Loads them into Pandas
- Applies VADER sentiment analysis
- Creates sentiment classifications
- Generates enriched review data
- Writes the enriched information back to the analytical layer

### Step 10 — Run SQL Analytics

Execute the SQL files inside `sql/`.

These scripts perform:

- KPI analysis
- Customer analysis
- Product analysis
- Rating analysis
- Sentiment analysis
- Advanced SQL analysis
- Window-function analysis
- Power BI data preparation

### Step 11 — Open Power BI

Open `powerbi/Customer_Sentiment_Analytics_Dashboard.pbix`.

Refresh the dataset and interact with the dashboard using slicers, filters, and visualizations.

---

# 📌 Important Note About Database Connectivity

The SQL Server database itself is not stored inside GitHub.

The repository contains:

```text
CSV/Data files
+
SQL scripts
+
Python pipeline
+
Power BI dashboard
```

The user needs to create/configure the SQL Server database locally before running the complete pipeline.

---

# 🧪 Validation Performed

The project includes validation of:

- Duplicate records
- Customer relationships
- Product relationships
- Review records
- Data types
- Missing/invalid values
- Sentiment output
- Analytical table structure

This helps ensure that downstream analysis is based on reliable data.

---

# 🔐 Security

Database credentials and local connection details should not be committed to GitHub.

Sensitive information should be stored locally or through environment variables.

Example:

```
DB_SERVER
DB_DATABASE
DB_USERNAME
DB_PASSWORD
```

A `.gitignore` file should be used to prevent accidental upload of sensitive files.

---

# 📚 Key SQL Concepts Demonstrated

SELECT, WHERE, GROUP BY, ORDER BY, JOIN, LEFT JOIN, CASE, NULLIF, COUNT, COUNT DISTINCT, SUM, AVG, CTE, RANK, DENSE_RANK, ROW_NUMBER, PERCENT_RANK, SUM() OVER(), SQL VIEW, Conditional Aggregation

# 📚 Key Python Concepts Demonstrated

Python, Pandas, DataFrame, PyODBC, SQL Server Connectivity, NLTK, VADER, Text Processing, Sentiment Classification, CSV Processing, Data Enrichment, ETL Pipeline

# 📚 Key Power BI Concepts Demonstrated

Data Import, Data Modeling, Relationships, KPIs, Cards, Charts, Slicers, Filters, Drill-down Analysis, DAX Measures, Interactive Dashboard

---

# 📈 Analytics Architecture

The project can be viewed as four major layers:

```text
┌──────────────────────────────┐
│       SOURCE DATA            │
│ CSV Customer & Product Data  │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       SQL SERVER             │
│ Cleaning + Fact/Dimensions   │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       PYTHON NLP             │
│ Pandas + NLTK VADER          │
│ Sentiment Enrichment         │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       ANALYTICS              │
│ Advanced SQL + SQL Views     │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│       POWER BI                │
│ DAX + KPIs + Dashboard       │
└──────────────────────────────┘
```

---

# 🎓 What I Learned

This project provided practical experience in building an end-to-end analytics solution.

### SQL

I learned how to:
- Design relational data models
- Create fact and dimension tables
- Write complex analytical queries
- Use joins and conditional aggregation
- Work with CTEs
- Use SQL window functions
- Create analytical views
- Prepare data for Power BI

### Python

I learned how to:
- Connect Python to SQL Server
- Extract database data using PyODBC
- Manipulate data using Pandas
- Build an automated enrichment workflow
- Integrate NLP into an analytics pipeline

### NLP

I learned how to:
- Process customer review text
- Apply VADER sentiment analysis
- Generate sentiment scores
- Classify customer feedback
- Combine textual sentiment with numerical ratings

### Power BI

I learned how to:
- Build analytical data models
- Create KPIs
- Use DAX
- Build interactive dashboards
- Present analytical findings visually

### Business Analytics

Most importantly, I learned how to move from:

```text
Raw Data
    ↓
Cleaning
    ↓
Data Modeling
    ↓
Transformation
    ↓
Analysis
    ↓
Visualization
    ↓
Business Insights
```

This helped me understand how different analytics tools work together rather than treating SQL, Python, and Power BI as separate technologies.

---

# ⭐ Key Project Highlights

✔ End-to-End Customer Analytics Pipeline
✔ SQL Server Database
✔ Fact & Dimension Data Modeling
✔ Data Cleaning & Validation
✔ Python + SQL Server Integration
✔ Pandas Data Processing
✔ NLTK VADER Sentiment Analysis
✔ Customer Review Enrichment
✔ Sentiment Fact Table
✔ Advanced SQL Queries
✔ CTEs
✔ Conditional Aggregation
✔ Window Functions
✔ RANK()
✔ DENSE_RANK()
✔ ROW_NUMBER()
✔ PERCENT_RANK()
✔ Cumulative Analysis
✔ SQL Views
✔ Power BI-Ready Analytical Layer
✔ DAX KPIs
✔ Interactive Power BI Dashboard
✔ Rating vs Sentiment Analysis
✔ Customer-Level Analysis
✔ Product-Level Analysis
✔ Business-Focused Analytics

---

# 🔮 Future Improvements

Possible future improvements include:

- Transformer-based sentiment analysis
- BERT-based NLP models
- Aspect-based sentiment analysis
- Topic modeling
- Customer segmentation
- Customer churn prediction
- Sentiment forecasting
- Automated ETL pipelines
- Scheduled data refresh
- Real-time sentiment monitoring
- Cloud database deployment
- Automated Power BI refresh
- Advanced customer experience analytics

---

# 📌 Conclusion

Customer Sentiment Analytics demonstrates an end-to-end approach to transforming raw customer data into actionable business insights.

The project combines:

```text
SQL Server
+
Python
+
Pandas
+
NLTK VADER
+
Advanced SQL
+
Power BI
+
DAX
```

SQL Server provides the structured data foundation and analytical layer.

Python and NLTK VADER enrich customer reviews with sentiment information.

Advanced SQL queries generate customer, product, rating, and sentiment analysis.

Power BI and DAX transform these analytical outputs into an interactive business dashboard.

The final solution demonstrates how a Data Analyst can take raw structured and unstructured customer data and convert it into a complete business intelligence and decision-support solution.

---

# 👩‍💻 Author

**Pushpalata S**

B.Tech in Chemical Engineering
Motilal Nehru National Institute of Technology Allahabad

GitHub: [https://github.com/Pushpalata-S](https://github.com/Pushpalata-S)

---

# ⭐ Repository

Project Repository: [https://github.com/Pushpalata-S/Customer-Sentiment-Analytics](https://github.com/Pushpalata-S/Customer-Sentiment-Analytics)

If you find this project useful, feel free to explore the SQL scripts, Python sentiment pipeline, data model, and Power BI dashboard.

---

# 📝 Project Update Note

This README reflects the **current, upgraded version** of the project. The previous version of the README described only a **SQL Server + Python** workflow. The project has since evolved, and this README now correctly documents the full pipeline:

```text
SQL Server → Fact/Dimension Model → Python/VADER → Sentiment Fact →
Advanced SQL → Power BI View → DAX → Dashboard
```

**Note on repository structure:** the file tree in the [Project Structure](#-project-structure) section should match what's actually present in the GitHub repository — rename files on either side if they've drifted, rather than assuming every listed file exists.

For the strongest presentation, the repository should ultimately be organized as:

```text
Customer-Sentiment-Analytics
│
├── data
│   ├── raw
│   └── processed
│
├── sql
│   ├── fact_*.sql
│   ├── dim_*.sql
│   ├── sentiment analysis queries
│   └── Power BI view
│
├── python
│   └── customer_reviews_enrichment.py
│
├── powerbi
│   └── Customer_Sentiment_Analytics_Dashboard.pbix
│
├── images
├── README.md
└── .gitignore
```

This version is stronger for a Data Analyst interview because it shows the project is not just a basic sentiment-analysis exercise — it's an end-to-end SQL + Python + NLP + Power BI analytics project.


