SELECT
    DISTINCT job_details.skill_abr
FROM
    job_details
JOIN
    job_postings ON job_details.job_id = job_postings.job_id
