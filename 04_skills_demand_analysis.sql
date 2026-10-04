-- 4. Skills Demand


-- What are the most demanded skills?
SELECT
	jd.skill_abr AS skills,
	COUNT(j.job_id) AS job_postings
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
SELECT
	j.experience_level,
	jd.skill_abr,
	COUNT(j.job_id) AS job_postings
FROM
	job_postings j
INNER JOIN
	job_details jd ON j.job_id = jd.job_id
WHERE
	experience_level IS NOT NULL
GROUP BY
	j.experience_level,
	jd.skill_abr
ORDER BY
	experience_level, job_postings DESC;


-- NOTE: MADY BY A.I (rebuild it yourself later after understanding the concept)
WITH RankedSkills AS (
    SELECT 
        j.experience_level, 
        jd.skill_abr, 
        COUNT(j.job_id) AS job_postings,
        ROW_NUMBER() OVER(
            PARTITION BY j.experience_level 
            ORDER BY COUNT(j.job_id) DESC
        ) AS rank
    FROM job_postings j 
    INNER JOIN job_details jd ON j.job_id = jd.job_id 
    WHERE j.experience_level IS NOT NULL 
    GROUP BY j.experience_level, jd.skill_abr
)
SELECT 
    experience_level, 
    skill_abr, 
    job_postings
FROM RankedSkills
WHERE rank = 1
ORDER BY job_postings DESC;

-- What skills are most common within different industries?
-- Which skills appear most frequently within particular job titles?
-- Which skills frequently appear together?
-- How does salary differ between jobs requiring different skills?