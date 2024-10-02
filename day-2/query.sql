

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values 
('2019-01-01','success'),
('2019-01-02','success'),
('2019-01-03','success'),
('2019-01-04','fail'),
('2019-01-05','fail'),
('2019-01-06','success')

SELECT * from tasks

WITH date_group AS
(
         SELECT   *,
                  Row_number() OVER (partition BY state ORDER BY date_value)                                               AS rn,
                  (date_value::date - interval '1 day' * row_number() OVER (partition BY state ORDER BY date_value))::date AS adjusted_date
         FROM     tasks )
SELECT   min(date_value) AS start_date,
         max(date_value) AS end_date,
         state
FROM     date_group
GROUP BY state,
         adjusted_date
ORDER BY start_date;
