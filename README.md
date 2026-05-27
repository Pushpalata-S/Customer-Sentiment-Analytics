# Customer Sentiment Analytics

SQL Server • Python • Customer Review Sentiment Analysis using Python and NLTK VADER • Data Analytics

---

# Project Overview

This project is an end-to-end Customer Sentiment Analytics project built using SQL Server and Python. The objective of this project is to transform raw customer review and engagement data into meaningful business insights using SQL-based data modeling and customer review sentiment analysis.

The project follows a practical analytics workflow:

```text
Raw CSV Data
        ↓
SQL Server Database
        ↓
Data Cleaning & Validation
        ↓
Fact and Dimension Tables
        ↓
Python Data Extraction
        ↓
Customer Review Sentiment Analysis using Python and NLTK VADER
        ↓
Enriched Customer Reviews Dataset
        ↓
Business Insights & Analytics
```

This project demonstrates practical skills in:

- SQL Server data modeling
- Data validation and transformation
- Python data analysis
- Customer review sentiment analysis
- ETL workflow development
- Business analytics storytelling

---

# Business Problem

Businesses receive thousands of customer reviews and engagement records, but raw textual data alone does not provide actionable business insights.

Decision-makers need a structured analytics solution to answer questions such as:

- What percentage of reviews are positive, neutral, or negative?
- Which products receive the highest customer satisfaction?
- Which products or services receive poor sentiment?
- How do customer ratings align with textual sentiment?
- Which customer segments are most engaged?
- How does customer engagement affect review sentiment?
- Which business areas require improvement?

This project helps transform unstructured customer feedback into measurable analytical insights.

---

# Project Objectives

The key objectives of this project are:

- Import raw customer data into SQL Server
- Build a structured relational database model
- Validate and clean raw business data
- Extract SQL Server data using Python
- Apply sentiment analysis using Python and NLTK VADER
- Generate enriched analytical datasets
- Prepare processed datasets for future dashboarding and reporting
- Demonstrate an end-to-end analytics workflow suitable for portfolio projects

---

# Dataset Description

The project uses customer review and engagement datasets stored inside SQL Server.

## Main Tables

| Table Name | Description |
|---|---|
| customer_reviews | Customer review and rating data |
| customer_journey | Customer interaction journey data |
| customers | Customer dimension data |
| products | Product dimension data |
| engagement_data | Customer engagement metrics |
| geography | Customer geographic information |

---

# Tools and Technologies Used

| Tool / Technology | Purpose |
|---|---|
| SQL Server | Database storage and transformation |
| SQL Server Management Studio (SSMS) | SQL development and execution |
| Python | Data extraction and sentiment analysis |
| Pandas | Data manipulation |
| NLTK VADER | Customer review sentiment analysis |
| PyODBC | SQL Server database connection |
| CSV | Processed analytical output |
| GitHub | Project documentation and version control |
| VS Code | Python development |

---

# Project Architecture

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
│   ├── dim_customers.sql
│   ├── dim_products.sql
│   ├── fact_customer_reviews.sql
│   ├── fact_engagement_data.sql
│   └── fact_customer_journey.sql
│
├── python/
│   └── customer_reviews_enrichment.py
│
├── images/
│
├── README.md
└── .gitignore
```

---

# Data Processing Approach

The project uses SQL Server as the primary data storage and transformation layer.

The workflow includes:

1. Loading raw customer datasets into SQL Server
2. Organizing business data into relational tables
3. Extracting review data using Python
4. Performing customer review sentiment analysis using Python and NLTK VADER
5. Creating enriched datasets with sentiment scores and categories
6. Exporting processed analytical datasets as CSV files

---

# Sentiment Analysis Process

Customer review text is analyzed using the VADER (Valence Aware Dictionary and sEntiment Reasoner) sentiment analysis model from the NLTK library.

## Generated Sentiment Columns

| Column | Description |
|---|---|
| SentimentScore | Numerical sentiment polarity score |
| SentimentCategory | Positive / Negative / Neutral classification |
| SentimentBucket | Grouped sentiment ranges |

---

# Example Sentiment Output

| ReviewText | SentimentScore | SentimentCategory |
|---|---|---|
| Excellent product, highly recommend! | 0.77 | Positive |
| Average experience, nothing special. | -0.30 | Mixed Negative |
| Product did not meet expectations. | -0.45 | Negative |

---

# Python Workflow

The Python pipeline performs:

- SQL Server database connection using PyODBC
- SQL query execution
- Data extraction into Pandas DataFrame
- Customer review sentiment scoring
- Sentiment categorization
- Processed CSV generation

---

# SQL Skills Demonstrated

- Relational database design
- Fact and dimension modeling
- SQL querying
- Data extraction
- Join operations
- Data validation
- SQL Server database management
- Table relationship understanding

---

# Python Skills Demonstrated

- Pandas DataFrames
- SQL Server connectivity
- PyODBC usage
- Customer review sentiment analysis
- Text processing
- CSV export automation
- Data enrichment workflow

---

# Key Business Insights

The project enables insights such as:

- Customer satisfaction analysis
- Product-level sentiment tracking
- Negative review identification
- Rating vs sentiment comparison
- Customer engagement behavior
- Product feedback trends
- Sentiment distribution analysis

---

# How to Run This Project

## Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/customer-sentiment-analytics.git
```

---

## Step 2: Open SQL Server Management Studio

Connect to your SQL Server instance.

Example:

```text
localhost\SQLEXPRESS
```

---

## Step 3: Create Database

Create:

```text
PortfolioProject_MarketingAnalytics
```

---

## Step 4: Import Raw CSV Files

Import the datasets into SQL Server tables.

Tables:

- customer_reviews
- customer_journey
- customers
- products
- engagement_data
- geography

---

## Step 5: Execute SQL Scripts

Run SQL scripts inside:

```text
sql/
```

---

## Step 6: Install Python Dependencies

```bash
pip install pandas nltk pyodbc sqlalchemy
```

---

## Step 7: Run Python Sentiment Analysis Script

```bash
python "customer_reviews_enrichment.py"
```

---

## Step 8: Generate Processed Dataset

The script generates:

```text
fact_customer_reviews_enrich.csv
```

inside:

```text
data/processed/
```

---

# Future Improvements

Possible future enhancements include:

- Power BI dashboard integration
- Advanced NLP models
- Topic modeling
- Customer segmentation
- Interactive business dashboards
- Automated ETL pipelines
- Sentiment trend analysis
- Real-time feedback processing

---

# Author

Pushplata

Aspiring Data Analyst / BI Developer skilled in SQL, Python, data analytics, customer review sentiment analysis, and business intelligence workflows.

---

# License

This project is created for educational, portfolio, and resume purposes.
