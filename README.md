# Job Postings & Company Analytics Pipeline

A data engineering and analytics project that processes raw job posting and company datasets through an end-to-end ETL pipeline—from Python-driven cleaning and PostgreSQL database modeling to SQL analytics and upcoming Power BI visualization.

---

## 🛠️ Tech Stack & Requirements

- **Language:** Python 3.9+
- **Environment:** Jupyter Notebook / VS Code
- **Database:** PostgreSQL 13+
- **BI & Visualization (Upcoming):** Power BI Desktop
- **Python Packages:**
  - `pandas`
  - `numpy`
  - `psycopg2-binary` / `sqlalchemy` (optional, for direct database drivers)

---

## 🔄 Project Workflow & Methodology

```
Raw CSVs ──> Jupyter Notebook (ETL & EDA) ──> Cleaned CSVs ──> PostgreSQL Database ──> SQL Analysis ──> Power BI (Planned)
```

1. **Extraction & Transformation (Python/Jupyter):**
   - Ingest raw, unformatted CSV datasets.
   - Clean data types, handle missing values, drop duplicates, and standardize string formats.
   - Perform Exploratory Data Analysis (EDA) to understand distributions and missingness patterns.
   - Merge related datasets and export normalized, clean CSV files.

2. **Database Modeling & Ingestion (PostgreSQL):**
   - Design dynamic relational database schemas with appropriate Primary and Foreign Key constraints (`companies`, `company_details`, `job_postings`, `job_details`).
   - Bulk-load processed CSVs into PostgreSQL tables using bulk `COPY` / `\copy` routines.

3. **Analytics & BI (PostgreSQL & Power BI):**
   - Run complex SQL queries to extract key hiring trends, salary distribution insights, and industry/skill patterns.
   - *(In Progress)* Connect PostgreSQL tables to Power BI for interactive dashboard visualization.

---

## 🚀 Getting Started

### 1. Prerequisites
Ensure PostgreSQL and Python are installed on your machine. Install required Python packages:
```bash
pip install pandas numpy psycopg2-binary
```

### 2. Run ETL Pipeline
Open and run the notebooks in sequential order inside your Jupyter environment:
```bash
jupyter notebook
```
Export the cleaned outputs into your designated output directory.

### 3. Load Data into PostgreSQL
Execute table creation DDLs and data loading scripts in VS Code or `psql`:
```sql
-- Create schema and load cleaned CSVs
\i schemas/1_creating_tables.sql
\copy companies FROM 'path/to/3_companies.csv' WITH (FORMAT csv, HEADER true);
\copy company_details FROM 'path/to/4_company_details.csv' WITH (FORMAT csv, HEADER true);
\copy job_postings FROM 'path/to/1_job_postings.csv' WITH (FORMAT csv, HEADER true);
\copy job_details FROM 'path/to/2_job_skills_industry.csv' WITH (FORMAT csv, HEADER true);
```

---

## 📌 Project Status

- [x] Raw Data Ingestion & Data Wrangling
- [x] Exploratory Data Analysis (EDA)
- [x] Schema Design & FK Constraints
- [x] Automated CSV Bulk Ingestion Scripting
- [x] SQL Exploratory Analysis & Reporting Queries
- [x] In-Depth Analysis within different Dimensions
- [ ] Power BI Dashboard Development

## 📊 Data Source

Dataset: [LinkedIn Job Postings Dataset](https://www.kaggle.com/datasets/rajatraj0502/linkedin-job-2023?select=job_skills.csv) by [Rajat Raj], via Kaggle.
License: [CC BY-SA 4.0]
Files used: job_postings, job_skills, job_industries, companies, company_industries, company_specialities
Downloaded: October 2026. Raw files are included in `raw_datasets/` unmodified.

## 📄 Licenses
- **Code** (notebooks, SQL, scripts): [MIT](LICENSE)
- **Data** (`raw_datasets/`, `cleaned_datasets/`): CC BY-SA 4.0, as above.
  Cleaned files are adaptations and carry the same license.
