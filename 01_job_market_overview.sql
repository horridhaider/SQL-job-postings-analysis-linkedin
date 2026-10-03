-- 01 — Job Market Overview

-- How many job postings are there?
SELECT COUNT(*) AS total_jobs FROM job_postings;

-- How many companies are hiring?
SELECT COUNT(company_id) AS hiring_companies FROM (
	SELECT DISTINCT company_id FROM job_postings);

-- How many countries/cities are represented?
SELECT COUNT(country) total_countries FROM (
	SELECT DISTINCT country FROM companies);
	
SELECT COUNT(city) total_cities FROM (
	SELECT DISTINCT city FROM companies);

-- What are the most common job titles?
SELECT
	title,
	COUNT(title) AS jobs_available
FROM
	job_postings
GROUP BY
	title
ORDER BY
	jobs_available DESC
LIMIT 10;

-- Which companies have the most job postings?
SELECT
	c.company_name,
	COUNT(j.job_id) AS job_postings
FROM
	companies c
INNER JOIN job_postings j ON c.company_id = j.company_id
GROUP BY
	c.company_name
ORDER BY
	job_postings DESC
LIMIT 10;

-- Which industries have the most postings?
SELECT
	cd.industry,
	COUNT(j.job_id) AS job_postings
FROM
	company_details cd
INNER JOIN job_postings j ON cd.company_id = j.company_id
GROUP BY
	cd.industry
ORDER BY
	job_postings DESC
LIMIT 10;

-- What percentage of jobs allow remote work?
SELECT 
	COUNT(*) AS total_jobs,
	COUNT(remote_allowed) AS remote_allowed_jobs,
	COUNT(remote_allowed)*100 / COUNT(*) AS percentage
FROM job_postings;


-- What percentage of jobs are sponsored?
SELECT
	COUNT(*) AS total_jobs,
	SUM(sponsored) AS sponsored_jobs,
	SUM(sponsored)*100 / COUNT(*) AS sponsored_percentage 
FROM 
	job_postings;

-- What are the most common experience levels?
SELECT 
	experience_level,
	COUNT(*) AS total_jobs
FROM 
	job_postings
GROUP BY
	experience_level
HAVING
	experience_level IS NOT NULL
ORDER BY
	total_jobs DESC;

-- What are the most common work types?
SELECT
	work_type,
	COUNT(*) AS total_jobs
FROM 
	job_postings
GROUP BY
	work_type
ORDER BY
	total_jobs DESC;