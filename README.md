# 📊 Customer Sentiment Analytics

### An End-to-End SQL + Python (NLP) + Power BI Business Intelligence Project

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=flat&logo=microsoft-sql-server&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![NLTK](https://img.shields.io/badge/NLTK-VADER-4B8BBE?style=flat)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-Measures-orange?style=flat)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat)

*Transforming raw customer, product, engagement, journey, and review data into structured, decision-ready business insights.*

</div>

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Workflow](#-end-to-end-project-workflow)
- [Business Problem](#-business-problem)
- [Project Objectives](#-project-objectives)
- [Dataset](#-dataset)
- [Data Model](#️-data-model)
- [Data Cleaning & Validation](#-data-cleaning--validation)
- [Python Data Processing](#-python-data-processing)
- [Sentiment Analysis](#-sentiment-analysis)
- [SQL Server Analytical Layer](#️-sql-server-analytical-layer)
- [Advanced SQL Analytics](#-advanced-sql-analytics)
- [Rating vs Sentiment Analysis](#-rating-vs-sentiment-analysis)
- [Power BI Dashboard](#-power-bi-dashboard)
- [KPIs & DAX](#-power-bi-kpis)
- [Technologies Used](#️-technologies-used)
- [Project Structure](#-project-structure)
- [How to Run](#️-how-to-run-the-project)
- [Security](#-security)
- [Key Concepts Demonstrated](#-key-concepts-demonstrated)
- [What I Learned](#-what-i-learned)
- [Key Highlights](#-key-project-highlights)
- [Future Improvements](#-future-improvements)
- [Conclusion](#-conclusion)
- [Author](#-author)

---

## 📌 Project Overview

Customer reviews contain valuable information about customer experience, but raw review text and star ratings alone are difficult to analyze at scale.

This project builds a complete analytics pipeline — from raw data to boardroom-ready dashboard — that:

- Stores and structures raw business data in **SQL Server**
- Cleans and validates the data
- Designs a **fact and dimension model**
- Extracts customer reviews using **Python**
- Performs sentiment analysis using **NLTK VADER**
- Enriches customer reviews with sentiment scores
- Writes the enriched data back into SQL Server
- Runs **advanced SQL analytics** (CTEs, window functions, views)
- Builds a **Power BI-ready analytical view**
- Creates KPIs and analytical measures using **DAX**
- Presents insights through an **interactive Power BI dashboard**

The project answers business questions related to customer satisfaction, product performance, sentiment trends, rating-vs-sentiment mismatches, customer engagement, review activity, and customer journey behavior.

> **Why it matters:** this isn't a single-tool exercise — it demonstrates how SQL, Python/NLP, and Power BI work together as one connected analytics pipeline, from raw CSVs to an executive dashboard.

---

## 🔄 End-to-End Project Workflow

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

## 🎯 Business Problem

Businesses collect large volumes of customer feedback through reviews, ratings, engagement activity, and customer journeys — but raw data doesn't directly answer the questions that matter:

- What percentage of customer reviews are positive, neutral, or negative?
- Which products receive the highest / lowest customer satisfaction?
- Which customers are most active in providing reviews?
- How do textual sentiments compare with numerical ratings?
- Are customers giving high ratings while expressing negative sentiment?
- How does customer engagement relate to feedback?
- How does customer sentiment change over time?
- Which areas need business improvement?

---

## 🎯 Project Objectives

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
- Build DAX-based KPIs
- Build an interactive customer sentiment dashboard
- Convert analytical results into actionable business insights

---

## 📂 Dataset

The project uses multiple datasets related to customers, products, reviews, engagement, geography, and customer journeys.

| Table | Description |
|---|---|
| `customer_reviews` | Customer review text and ratings |
| `customers` | Customer demographic and profile information |
| `products` | Product information |
| `customer_journey` | Customer interaction and journey information |
| `engagement_data` | Customer engagement metrics |
| `geography` | Geographic information |

---

## 🏗️ Data Model

The raw data was transformed into a structured **fact and dimension model** for efficient, scalable analysis.

**Dimension Tables**
- `dim_customers`
- `dim_products`

**Fact Tables**
- `fact_customer_reviews`
- `fact_customer_journey`
- `fact_engagement_data`
- `fact_review_sentiment`

### Fact & Dimension Architecture

```text
                    dim_customers
                         |
                         ↓
                  fact_customer_reviews
                         |
                         ↓
                  fact_review_sentiment
                         |
dim_products ------------+

fact_customer_journey

fact_engagement_data
```

The model separates descriptive attributes from transactional/analytical data, making the database easier to query and connect with Power BI.

---

## 🧹 Data Cleaning & Validation

Before analysis, the raw data was processed and validated:

- Checking duplicate records
- Validating missing values
- Standardizing data
- Checking data types
- Normalizing engagement-related data
- Validating customer and product relationships
- Preparing review text for NLP processing
- Structuring the data into fact and dimension tables

This ensured the analytical layer was built on consistent, reliable data.

---

## 🐍 Python Data Processing

Python bridges SQL Server and the sentiment-analysis pipeline via:

```
python/customer_reviews_enrichment.py
```

```text
SQL Server → Extract Customer Reviews → Pandas DataFrame → Text Processing
    → VADER Sentiment Analysis → Sentiment Classification → Enriched Review Data → SQL Server
```

---

## 🧠 Sentiment Analysis

Customer review text was analyzed using **VADER** (Valence Aware Dictionary and sEntiment Reasoner) from the NLTK library.

VADER produces a compound sentiment score ranging from approximately:

```
-1  ← Negative
 0  ← Neutral
+1  ← Positive
```

### Sentiment Fields

| Field | Description |
|---|---|
| `SentimentScore` | Numerical VADER sentiment score |
| `TextSentimentLabel` | Original text sentiment classification |
| `SentimentCategory` | Business-oriented sentiment category |
| `SentimentBucket` | Grouped sentiment score range |

**Example:**

| Review | Sentiment Score | Sentiment |
|---|---|---|
| Excellent product, highly recommend! | 0.77 | Positive |
| Average experience | 0.00 | Neutral |
| Product did not meet expectations | -0.45 | Negative |

### Sentiment Enrichment Pipeline

Original data (`ReviewID`, `CustomerID`, `ProductID`, `ReviewDate`, `Rating`, `ReviewText`) is enriched with `SentimentScore`, `TextSentimentLabel`, `SentimentCategory`, and `SentimentBucket` — combining numerical feedback with textual feedback into one unified sentiment analysis layer.

---

## 🗄️ SQL Server Analytical Layer

The enriched review data feeds into the SQL Server analytical layer, joining customer, product, review, engagement, and sentiment information across:

`dim_customers` · `dim_products` · `fact_customer_reviews` · `fact_customer_journey` · `fact_engagement_data` · `fact_review_sentiment`

---

## 🧮 Advanced SQL Analytics

The project goes beyond basic queries into advanced analytical SQL:

- CTEs, JOINs, LEFT JOINs, GROUP BY
- Conditional Aggregation, CASE expressions, NULLIF
- **Window Functions:** `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `PERCENT_RANK()`, `SUM() OVER()`
- Cumulative calculations
- SQL Views
- Analytical percentages

### 👥 Customer-Level Performance

Total reviews · products reviewed · average rating · positive/negative reviews · positive review % · review activity percentile — used to identify highly active reviewers.

### 📦 Product Performance

Total reviews · unique customers · average rating · positive/negative review % — used to identify high- and under-performing products.

### 🏆 Product Ranking

```sql
RANK() OVER (ORDER BY AverageRating DESC) AS RatingRank
DENSE_RANK() OVER (ORDER BY AverageRating DESC) AS DenseRatingRank
ROW_NUMBER() OVER (ORDER BY AverageRating DESC, TotalReviews DESC) AS ProductRowNumber
```

| Rating | RANK | DENSE_RANK |
|---|---|---|
| 4.9 | 1 | 1 |
| 4.8 | 2 | 2 |
| 4.8 | 2 | 2 |
| 4.7 | 4 | 3 |

`RANK()` leaves gaps after ties; `DENSE_RANK()` does not; `ROW_NUMBER()` breaks ties using `TotalReviews` as a secondary sort.

### 📈 Review Activity Percentile

```sql
PERCENT_RANK() OVER (ORDER BY TotalReviews) AS ReviewActivityPercentile
```

A value closer to `0` = lower relative activity; closer to `1` = higher relative activity.

### 📊 Rating Distribution & Cumulative Analysis

```sql
SUM(ReviewCount) OVER (
    ORDER BY Rating
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
```

Used to compute review count, rating %, cumulative review count, and cumulative % across rating levels.

| Function | Purpose |
|---|---|
| `RANK()` | Product ranking |
| `DENSE_RANK()` | Ranking without gaps |
| `ROW_NUMBER()` | Unique product ordering |
| `PERCENT_RANK()` | Relative customer review activity |
| `SUM() OVER()` | Cumulative review analysis |

---

## 🔗 Power BI Analytical View

A dedicated SQL Server view — `vw_powerbi_customer_sentiment` — combines review, customer, product, rating, and sentiment data into one clean, analysis-ready dataset, generating business-friendly fields:

`ReviewYear` · `ReviewMonth` · `ReviewMonthName` · `ReviewMonthStart` · `AgeGroup` · `RatingGroup` · `RatingSentimentStatus` · `NegativeReviewFlag` · `PositiveReviewFlag` · `ReviewCount`

This centralizes business logic in SQL Server and reduces repetitive transformations inside Power BI.

**Time-based analysis** (year/month/month name/month start) enables tracking of monthly review volume, rating trends, sentiment trends, and changes in satisfaction over time.

**Customer segmentation** groups customers by age (`Under 25`, `25-34`, `35-44`, `45-54`, `55+`) so satisfaction and sentiment can be compared across segments.

---

## ⭐ Rating vs Sentiment Analysis

A key differentiator of this project: comparing **numerical ratings** against **textual sentiment** to surface mismatches a star rating alone would hide.

```text
Rating ≥ 4 + Negative Sentiment  →  Potential Hidden Customer Issue
Rating ≤ 2 + Positive Sentiment  →  Potential Rating/Text Mismatch
```

A derived field, `RatingSentimentStatus`, classifies each review as:

- **Negative Sentiment – High Rating**
- **Positive Sentiment – Low Rating**
- **Aligned**

Two binary flags — `NegativeReviewFlag` and `PositiveReviewFlag` — make filtering and KPI calculations easier in Power BI.

---

## 📊 Power BI Dashboard

The final Power BI dashboard unifies the SQL and Python outputs into one interactive analytical interface covering customer satisfaction, sentiment, product performance, review activity, rating distribution, sentiment trends, segmentation, rating-vs-sentiment analysis, engagement, and customer journey.

<p align="center">
<img width="866" alt="Dashboard overview" src="https://github.com/user-attachments/assets/f5a21be5-9906-4eb5-99ff-abaf290cc73d" />
<br/>
<img width="1333" alt="Sentiment analysis view" src="https://github.com/user-attachments/assets/fb8a4a1d-2527-4401-bbf7-a852bfbaea23" />
<br/>
<img width="1325" alt="Product performance view" src="https://github.com/user-attachments/assets/99c41f4b-4038-43e2-8238-3ebe5c70a713" />
<br/>
<img width="1317" alt="Customer analysis view" src="https://github.com/user-attachments/assets/73e66988-75c4-4ff5-8da1-0c454a10fcc9" />
<br/>
<img width="1318" alt="Rating vs sentiment view" src="https://github.com/user-attachments/assets/edd5d1d8-1652-4664-adff-979861cd4d6b" />
</p>

The dashboard supports drill-down from high-level KPIs into detail:

```text
Overall Customer Satisfaction → Product Performance → Individual Reviews → Sentiment → Potential Customer Issue
```

---

## 🎯 Power BI KPIs

| KPI | Description |
|---|---|
| Total Reviews | Total customer reviews |
| Average Rating | Average star rating |
| Positive / Negative Reviews | Count of positive / negative reviews |
| Positive / Negative / Neutral Sentiment % | Share of each sentiment class |
| Average Sentiment Score | Average VADER sentiment score |
| Products Reviewed | Number of products receiving reviews |
| Active Customers | Customers contributing reviews |

### 🧮 DAX

DAX measures power the review metrics, customer metrics, sentiment analysis, percentage calculations, and dashboard KPIs, completing the pipeline:

```text
SQL Server → Python → SQL Analytical Layer → Power BI → DAX
```

---

## 💡 Business Insights Enabled

| Area | Insight |
|---|---|
| **Customer Satisfaction** | Overall customer experience from ratings + sentiment |
| **Product Performance** | Products with consistently high or low feedback |
| **Negative Feedback** | Products and customers linked to negative reviews |
| **Rating-Sentiment Mismatch** | Cases where ratings and text tell different stories |
| **Customer Engagement** | Engagement and interaction behavior |
| **Customer Journey** | Patterns and potential drop-off points |
| **Sentiment Trends** | How customer sentiment shifts over time |

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| SQL Server | Data storage and transformation |
| SSMS | SQL development and database management |
| Python | Data processing and sentiment analysis |
| Pandas | Data manipulation |
| NLTK | Natural language processing |
| VADER | Sentiment analysis |
| PyODBC | Python–SQL Server connectivity |
| SQLAlchemy | Database connectivity support |
| Power BI | Data visualization and dashboarding |
| DAX | KPI and analytical calculations |
| Git / GitHub | Version control and project hosting |
| VS Code | Development environment |

---

## 📁 Project Structure

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

> 💡 Before publishing, double-check that every file listed above actually exists in your repository (and rename/remove entries on either side if they've drifted) — an accurate structure section builds trust with anyone reviewing the project, including recruiters.

---

## ▶️ How to Run the Project

**1. Clone the repository**

```bash
git clone https://github.com/Pushpalata-S/Customer-Sentiment-Analytics.git
cd Customer-Sentiment-Analytics
```

**2. Set up SQL Server**

Open SQL Server Management Studio (SSMS) and connect to your instance, e.g. `localhost\SQLEXPRESS`.

**3. Create the database**

```
PortfolioProject_MarketingAnalytics
```

**4. Import source data**

Import the raw CSVs into SQL Server: `customer_reviews`, `customers`, `products`, `customer_journey`, `engagement_data`, `geography`.

**5. Create fact & dimension tables**

Run the scripts in `sql/` to build:

```text
Dimension Tables → Fact Tables → Sentiment Fact Table
```

**6. Install Python dependencies**

```bash
pip install pandas nltk pyodbc sqlalchemy
```

**7. Download the VADER lexicon**

```python
import nltk
nltk.download('vader_lexicon')
```

**8. Configure the database connection**

Update the connection details in `python/customer_reviews_enrichment.py` for your local environment. **Never commit passwords or credentials to GitHub.**

**9. Run sentiment analysis**

```bash
python python/customer_reviews_enrichment.py
```

This connects to SQL Server, extracts reviews, loads them into Pandas, applies VADER sentiment analysis, classifies sentiment, and writes the enriched data back to SQL Server.

**10. Run SQL analytics**

Execute the scripts in `sql/` for KPI, customer, product, rating, sentiment, and window-function analysis, and Power BI data preparation.

**11. Open Power BI**

Open `powerbi/Customer_Sentiment_Analytics_Dashboard.pbix`, refresh the dataset, and explore via slicers and filters.

> **Note:** The SQL Server database itself is not stored in GitHub. This repo contains the CSV/data files, SQL scripts, Python pipeline, and Power BI dashboard — the database must be created and configured locally before running the full pipeline.

---

## 🔐 Security

Database credentials and local connection details should **never** be committed to GitHub. Store sensitive information locally or via environment variables, e.g.:

```
DB_SERVER
DB_DATABASE
DB_USERNAME
DB_PASSWORD
```

A `.gitignore` file prevents accidental upload of sensitive files.

---

## 🧪 Validation Performed

Duplicate records · customer relationships · product relationships · review records · data types · missing/invalid values · sentiment output · analytical table structure.

---

## 📚 Key Concepts Demonstrated

<table>
<tr><td valign="top" width="33%">

**SQL**
- SELECT / WHERE / GROUP BY / ORDER BY
- JOIN, LEFT JOIN, CASE, NULLIF
- COUNT, COUNT DISTINCT, SUM, AVG
- CTEs
- RANK, DENSE_RANK, ROW_NUMBER, PERCENT_RANK
- SUM() OVER(), SQL Views
- Conditional Aggregation

</td><td valign="top" width="33%">

**Python**
- Pandas DataFrames
- PyODBC / SQL Server connectivity
- NLTK & VADER
- Text processing
- Sentiment classification
- CSV processing & data enrichment
- ETL pipeline design

</td><td valign="top" width="34%">

**Power BI**
- Data import & modeling
- Relationships
- KPIs & Cards
- Charts & Slicers/Filters
- Drill-down analysis
- DAX measures
- Interactive dashboarding

</td></tr>
</table>

---

## 📈 Analytics Architecture

```text
┌──────────────────────────────┐
│        SOURCE DATA           │
│  CSV Customer & Product Data │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│         SQL SERVER           │
│  Cleaning + Fact/Dimensions  │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│         PYTHON NLP           │
│  Pandas + NLTK VADER         │
│  Sentiment Enrichment        │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│         ANALYTICS            │
│  Advanced SQL + SQL Views    │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│         POWER BI             │
│  DAX + KPIs + Dashboard      │
└──────────────────────────────┘
```

---

## 🎓 What I Learned

**SQL** — designing relational data models, building fact/dimension tables, writing complex analytical queries, joins and conditional aggregation, CTEs, window functions, analytical views, and preparing data for Power BI.

**Python** — connecting to SQL Server via PyODBC, manipulating data with Pandas, building an automated enrichment workflow, and integrating NLP into an analytics pipeline.

**NLP** — processing review text, applying VADER sentiment analysis, generating sentiment scores, classifying feedback, and combining textual sentiment with numerical ratings.

**Power BI** — building analytical data models, creating KPIs, writing DAX, and designing interactive dashboards.

**Business Analytics** — most importantly, how to move an idea all the way from raw data to a business decision:

```text
Raw Data → Cleaning → Data Modeling → Transformation → Analysis → Visualization → Business Insights
```

This project reinforced how SQL, Python, and Power BI work together as one connected pipeline rather than three separate tools.

---

## ⭐ Key Project Highlights

✔ End-to-end customer analytics pipeline · ✔ SQL Server database · ✔ Fact & dimension data modeling · ✔ Data cleaning & validation · ✔ Python + SQL Server integration · ✔ NLTK VADER sentiment analysis · ✔ Sentiment fact table · ✔ Advanced SQL (CTEs, window functions, conditional aggregation) · ✔ Power BI-ready analytical layer · ✔ DAX KPIs · ✔ Interactive Power BI dashboard · ✔ Rating vs sentiment analysis · ✔ Customer- and product-level analysis · ✔ Business-focused analytics

---

## 🔮 Future Improvements

- Transformer-based / BERT-based sentiment analysis
- Aspect-based sentiment analysis & topic modeling
- Customer churn prediction & sentiment forecasting
- Automated, scheduled ETL pipelines
- Real-time sentiment monitoring
- Cloud database deployment & automated Power BI refresh
- Advanced customer experience analytics

---

## 📌 Conclusion

**Customer Sentiment Analytics** demonstrates a complete, end-to-end approach to turning raw customer data into actionable business insight — combining SQL Server, Python, Pandas, NLTK VADER, advanced SQL, Power BI, and DAX into one connected pipeline.

SQL Server provides the structured data foundation and analytical layer. Python and VADER enrich customer reviews with sentiment. Advanced SQL generates customer, product, rating, and sentiment analysis. Power BI and DAX turn all of it into an interactive business dashboard.

The result shows how a Data Analyst can take raw structured and unstructured customer data and convert it into a complete business intelligence and decision-support solution — not just a single-tool demo, but a full pipeline from CSV to dashboard.

---

## 👩‍💻 Author

**Pushpalata S**
B.Tech in Chemical Engineering, Motilal Nehru National Institute of Technology Allahabad

[![GitHub](https://img.shields.io/badge/GitHub-Pushpalata--S-181717?style=flat&logo=github)](https://github.com/Pushpalata-S)

---

<div align="center">

⭐ **[View the full repository](https://github.com/Pushpalata-S/Customer-Sentiment-Analytics)** — explore the SQL scripts, Python sentiment pipeline, data model, and Power BI dashboard.

</div>

