with word_occurrences as (
    SELECT job_id, word, count(1) as num_occurrences
    from `linkedin-jobs-401018.static_job_warehouse.job_words`
    where word not in (select stopword from `linkedin-jobs-401018.helper.stopwords`)
    group by job_id, word
),

select avg(num_occurrences) as average_occurrences
from word_occurrences