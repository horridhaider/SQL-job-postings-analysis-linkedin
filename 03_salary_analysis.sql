-- 3. Salary Analysis

-- What is the overall average/minimum/maximum salary in US?
SELECT
	location,
	ROUND(AVG((max_salary + min_salary)/2), 2) AS avg_salary,
	ROUND(MIN(min_salary), 2) AS min_salary,
	ROUND(MAX(max_salary), 2) AS max_salary
FROM 
	job_postings
WHERE
    min_salary > 0 
    AND max_salary > 0
GROUP BY
	location
ORDER BY
	avg_salary DESC;


-- How does salary vary by experience level?
SELECT 
    experience_level,
    ROUND(AVG((min_salary + max_salary)/2), 2) AS average_salary,
    MIN(min_salary) AS minimum_salary,
    MAX(max_salary) AS maximum_salary
FROM 
    job_postings
WHERE
	experience_level IS NOT NULL
GROUP BY 
    experience_level
ORDER BY 
    average_salary DESC;


-- How does salary vary by industry?
SELECT 
    cd.industry,
    ROUND(AVG((j.min_salary + j.max_salary)/2), 2) AS average_salary,
    MIN(j.min_salary) AS minimum_salary,
    MAX(j.max_salary) AS maximum_salary
FROM 
    company_details cd
INNER JOIN
	job_postings j ON cd.company_id = j.company_id
WHERE
	min_salary IS NOT NULL
GROUP BY 
    cd.industry
ORDER BY 
    average_salary DESC;


-- Which job titles have the highest average salaries?
SELECT	
	title,
	ROUND(AVG((min_salary + max_salary)/2), 2) AS avg_salary
FROM
	job_postings
WHERE
	min_salary IS NOT NULL AND
	LENGTH(title) < 100
GROUP BY
	title
ORDER BY
	avg_salary DESC;


-- Which locations have the highest average salaries?
SELECT
	location,
	ROUND(AVG((min_salary + max_salary)/2), 2) AS avg_salary
FROM
	job_postings
WHERE
	min_salary IS NOT NULL
GROUP BY
	location
ORDER BY
	avg_salary DESC;

-- How does salary differ between remote and non-remote jobs?
SELECT
	title AS remote_jobs,
	ROUND(AVG((min_salary + max_salary)/2), 2) AS avg_salary,
	MIN(min_salary) AS minimum_salary,
	MAX(max_salary) AS maximum_salary
FROM
	job_postings
WHERE
	min_salary IS NOT NULL AND
	remote_allowed = '1' AND
	LENGTH(title) < 100
GROUP BY
	title
ORDER BY
	avg_salary DESC;

-- How does salary vary across company sizes?
SELECT 
	cd.company_size,
	ROUND(AVG((j.min_salary + j.max_salary)/2), 2) AS avg_salary,
	MIN(j.min_salary) AS minimum_salary,
	MAX(j.max_salary) AS maximum_salary
FROM 
	company_details cd
INNER JOIN
	job_postings j ON cd.company_id = j.company_id
WHERE
	company_size IS NOT NULL
GROUP BY
	cd.company_size
ORDER BY
	company_size DESC;

-- What proportion of jobs actually provide salary information?
SELECT
	COUNT(*) AS total_jobs,
	COUNT(CASE WHEN min_salary IS NOT NULL THEN 1 END) AS jobs_with_salary_info,
	COUNT(CASE WHEN min_salary IS NULL THEN 1 END) AS jobs_without_salary_info
FROM
	job_postings