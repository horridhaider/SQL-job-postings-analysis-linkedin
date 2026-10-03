-- 2. Location Analysis


-- Which countries have the most job postings?
SELECT
	c.country,
	COUNT(j.job_id) AS job_postings
FROM
	companies c
INNER JOIN
	job_postings j ON c.company_id = j.company_id
GROUP BY
	c.country
HAVING
	country <> '0'
ORDER BY
	job_postings DESC
LIMIT 10;

-- Which cities have the most job postings?
SELECT
	c.city,
	COUNT(j.job_id) AS job_postings
FROM
	companies c
INNER JOIN
	job_postings j ON c.company_id = j.company_id
GROUP BY
	c.city
HAVING
	city <> '0'
ORDER BY
	job_postings DESC
LIMIT 10;

-- Which locations have the highest proportion of remote jobs?
SELECT
	c.city,
	COUNT(j.job_id) AS total_jobs,
	COUNT(j.remote_allowed) AS remote_jobs,
	COUNT(j.remote_allowed)*100 / COUNT(j.job_id) AS percentage_remote_jobs
FROM
	companies c
INNER JOIN
	job_postings j ON c.company_id = j.company_id
GROUP BY
	c.city
HAVING
	c.city <> '0'
	AND COUNT(j.job_id) > 20
ORDER BY
	percentage_remote_jobs DESC;

-- How does the distribution of jobs differ by experience level across locations?
SELECT
	location,
	experience_level,
	COUNT(job_id) AS job_postings
FROM 
	job_postings
GROUP BY
	location, experience_level
HAVING
	experience_level IS NOT NULL
ORDER BY
	job_postings DESC;
-- the most common exp levels
SELECT 
    experience_level, 
    COUNT(job_id) AS jobs 
FROM 
    job_postings 
WHERE 
    experience_level IS NOT NULL 
GROUP BY 
    experience_level 
ORDER BY 
    jobs DESC;

-- Which locations have the highest average salaries?
SELECT
	location,
	AVG(max_salary)::numeric(10,2) AS highest_avg_salary
FROM
	job_postings
GROUP BY
	location
HAVING
	AVG(max_salary) IS NOT NULL
ORDER BY
	highest_avg_salary DESC;
	
-- Which locations have the greatest variety of job roles?
SELECT
	location,
	COUNT(title) AS job_roles
FROM 
	job_postings
GROUP BY
	location
ORDER BY
	job_roles DESC
LIMIT 10;