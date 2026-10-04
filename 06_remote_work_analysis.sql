-- 5. Remote Work & Job Characteristics

-- Which industries have the highest percentage of remote jobs?
SELECT
	cd.industry,
	COUNT(j.job_id) AS total_jobs,
	COUNT(j.remote_allowed) AS remote_jobs,
	COUNT(j.remote_allowed)*100 / COUNT(j.job_id) AS percentage
FROM
	company_details cd
JOIN
	job_postings j ON cd.company_id = j.company_id
GROUP BY
	cd.industry
HAVING
	COUNT(j.job_id) > 10
ORDER BY
	percentage DESC;
	
	
-- Which experience levels are most likely to have remote opportunities?
SELECT
	experience_level,
	COUNT(job_id) AS total_jobs,
	COUNT(remote_allowed) AS remote_jobs,
	COUNT(remote_allowed)*100 / COUNT(job_id) AS percentage
FROM
	job_postings
WHERE
	experience_level IS NOT NULL
GROUP BY
	experience_level
ORDER BY
	percentage DESC;

	
-- Are remote jobs associated with higher or lower salaries?
SELECT
	CASE
		WHEN remote_allowed IS TRUE THEN 'remote work'
		WHEN remote_allowed IS NULL THEN 'non-remote'
	END AS work_type,
	ROUND(AVG((min_salary + max_salary)/2), 2) AS avg_salary
FROM
	job_postings
GROUP BY
	remote_allowed;


-- Which job titles are most commonly offered remotely?
SELECT
	title AS job_title,
	COUNT(remote_allowed) AS remote_jobs
FROM
	job_postings
WHERE
	LENGTH(title) < 100
GROUP BY
	job_title
ORDER BY
	remote_jobs DESC;

	
-- How does remote availability vary by location?
SELECT
	location,
	COUNT(remote_allowed) AS remote_jobs
FROM
	job_postings
WHERE
	location <> 'United States'
GROUP BY
	location
ORDER BY
	remote_jobs DESC;