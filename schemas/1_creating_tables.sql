-- 1. Companies Table
CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    url TEXT
);

-- 2. Company Details Table
CREATE TABLE company_details (
    company_id INT REFERENCES companies(company_id),
    company_size VARCHAR(50),
    industry VARCHAR(255),
    speciality TEXT,
    employee_count INT,
    follower_count INT,
    time_recorded TIMESTAMP
);

-- 3. Job Postings Table
CREATE TABLE job_postings (
    job_id BIGINT PRIMARY KEY,
    company_id INT REFERENCES companies(company_id),
    title VARCHAR(255),
    max_salary NUMERIC(12, 2),
    min_salary NUMERIC(12, 2),
    work_type VARCHAR(50),
    location VARCHAR(255),
    applies INT,
    remote_allowed BOOLEAN,
    views INT,
    job_posting_url TEXT,
    application_url TEXT,
    application_type VARCHAR(50),
    experience_level VARCHAR(50),
    sponsored INT
);

-- 4. Job Details Table
CREATE TABLE job_details (
    job_id BIGINT REFERENCES job_postings(job_id),
    skill_abr VARCHAR(50),
    industry_id VARCHAR(50)
);