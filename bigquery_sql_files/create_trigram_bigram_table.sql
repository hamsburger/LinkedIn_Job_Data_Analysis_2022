-- Create bigram and trigram table based on a list of previous words
drop table if exists `linkedin-jobs-401018.static_job_warehouse.bigram_and_trigrams`;

create temp function punctuations()
returns STRING
AS (
  ",;."
);

create table if not exists `linkedin-jobs-401018.static_job_warehouse.bigram_and_trigrams` as 
with jobs_with_row_number as (
  select row_num, job_id, word
  from `linkedin-jobs-401018.static_job_warehouse.job_words`
),

words as (
  select job_id, word, LEAD(word) over (partition by job_id order by row_num) as word1,
  LEAD(word, 2) over (partition by job_id order by row_num) as word2,  
  from jobs_with_row_number
)

select 
job_id,
case when regexp_contains(word, CONCAT("^[", punctuations(), "]+$")) 
    then NULL
    else word 
end as unigram, 
case when regexp_contains(word, CONCAT("^[", punctuations(), "]+$"))
        or regexp_contains(word1, CONCAT("^[", punctuations(), "]+$"))
    then NULL
    else concat(word, " ", word1)
end as bigram, 
case when regexp_contains(word, CONCAT("^[", punctuations(), "]+$"))
        or regexp_contains(word1, CONCAT("^[", punctuations(), "]+$"))
        or regexp_contains(word2, CONCAT("^[", punctuations(), "]+$"))
    then NULL
    else concat(word, " ", word1, " ", word2)
end as trigram, 
from words