 
    SELECT countif(job_id is not null) as job_id_count, 
           countif(title is not null) as title_count, 
           countif(company is not null) as company_count, 
           countif(description is not null) as description_count, 
           countif(onsite_remote is not null) as onsite_remote_count, 
           countif(location is not null) as location_count, 
           countif(posted_date is not null) as posted_date_count, 
           countif(country is not null) as country_count, 
           countif(seniority_level is not null) as seniority_level_count, 
           countif(employment_type is not null) as employment_type_count, 
           countif(job_function is not null) as job_function_count, 
           countif(industries is not null) as industries_count, 
           countif(salary_lb is not null) as salary_lb_count, 
           countif(salary_ub is not null) as salary_ub_count, 
           countif(salary_text is not null) as salary_text_count
    FROM `linkedin-jobs-401018.static_job_warehouse.jobs`
