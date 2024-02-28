select word, length(word) as word_length, count(1) as number_of_words, count(distinct job_id) as number_of_jobs
from `linkedin-jobs-401018.static_job_warehouse.job_words`
group by word