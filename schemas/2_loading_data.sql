COPY companies FROM 'E:/coding/projects/sql/project2/cleaned_datasets/3_companies.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY company_details FROM 'E:/coding/projects/sql/project2/cleaned_datasets/4_company_details.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY job_postings FROM 'E:/coding/projects/sql/project2/cleaned_datasets/1_job_postings.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY job_details FROM 'E:/coding/projects/sql/project2/cleaned_datasets/2_job_skills_industry.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');