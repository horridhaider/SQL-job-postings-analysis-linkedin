-- 4. Skills Demand

-- What are the most demanded skills?
SELECT
	jd.skill_abr AS skills,
	COUNT(j.job_id) AS job_postings,
	ROUND(AVG((j.min_salary + j.max_salary)/2), 2) AS avg_salary
FROM
	job_details jd
INNER JOIN
	job_postings j ON jd.job_id = j.job_id
GROUP BY
	skills
ORDER BY
	job_postings DESC
LIMIT 10;


-- What skills are most common for different experience levels?
WITH ranked_skills AS (	
	SELECT
		j.experience_level,
		jd.skill_abr,
		COUNT(j.job_id) AS job_postings,
		ROW_NUMBER() OVER(									--this will show only one most common skill for each exp lvl
		PARTITION BY j.experience_level
		ORDER BY COUNT(j.job_id) DESC
		) AS rank
	FROM job_postings j
	INNER JOIN job_details jd ON j.job_id = jd.job_id
	WHERE experience_level IS NOT NULL
	GROUP BY j.experience_level, jd.skill_abr
)
SELECT 
	experience_level, 
	skill_abr, 
	job_postings
FROM 
	ranked_skills
WHERE 
	rank = 1
ORDER BY
	job_postings DESC;


-- What skills are most common within different industries?
WITH ranked_industries AS (
	SELECT
		cd.industry,
		jd.skill_abr,
		COUNT(j.job_id) AS total_jobs,
		ROW_NUMBER() OVER(
		PARTITION BY cd.industry
		ORDER BY COUNT(j.job_id) DESC
		) AS rank
	FROM company_details cd
	JOIN job_postings j ON cd.company_id = j.company_id
	JOIN job_details jd ON j.job_id = jd.job_id
	GROUP BY cd.industry, jd.skill_abr
)

SELECT 
	industry,
	STRING_AGG(skill_abr, ',' ORDER BY rank) AS skills,		--combines multiple skills into one row
	SUM(total_jobs) AS total_jobs							--sums the job_counts for each skill into one
FROM
	ranked_industries
WHERE
	rank in (1,2,3)
GROUP BY
	industry
ORDER BY
	industry;


-- Which skills appear most frequently within particular job titles?
WITH ranked_titles AS (	
	SELECT
		j.title as job_title,
		jd.skill_abr,
		COUNT(j.job_id) AS total_jobs,
		ROW_NUMBER() OVER(
		PARTITION BY j.title 
		ORDER BY COUNT(j.job_id) DESC
		) AS rank
	FROM job_postings j
	JOIN job_details jd ON j.job_id = jd.job_id
	WHERE LENGTH(j.title) <  100
	GROUP BY j.title, jd.skill_abr
)
SELECT
	job_title,
	STRING_AGG(skill_abr, ',' ORDER BY rank) AS skills,
	SUM(total_jobs) AS total_jobs
FROM
	ranked_titles
WHERE
	rank in (1,2,3)
GROUP BY
	job_title
ORDER BY
	job_title;


-- How does salary differ between jobs requiring different skills?
SELECT
    jd.skill_abr AS skill,
    COUNT(j.job_id) AS job_postings,
    ROUND(
        AVG((j.min_salary + j.max_salary) / 2),
        2
    ) AS avg_salary
FROM job_details jd
JOIN job_postings j
    ON jd.job_id = j.job_id
WHERE
    j.min_salary IS NOT NULL
    AND j.max_salary IS NOT NULL
GROUP BY
    jd.skill_abr
ORDER BY
    avg_salary DESC;