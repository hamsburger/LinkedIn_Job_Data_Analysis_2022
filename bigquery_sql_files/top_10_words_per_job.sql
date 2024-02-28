with word_occurrences as (
    SELECT job_id, word, count(1) as num_occurrences
    from `linkedin-jobs-401018.static_job_warehouse.job_words`
    where word not in (select stopword from `linkedin-jobs-401018.helper.stopwords`)
    group by job_id, word
),

top_word_index as (
   select *, row_number() over (partition by job_id order by num_occurrences desc) as row_num
   from word_occurrences  
),

select job_id, word, num_occurrences
from top_word_index
where row_num <= 10