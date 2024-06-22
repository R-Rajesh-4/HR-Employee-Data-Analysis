Create database hrproject
  
SELECT * FROM hrproject.human_resources;

use hrproject;

select * from human_resources;

-- Data Cleaning ---
Alter table human_resources
change column ï»¿id emp_id varchar(20) null;

SET sql_safe_updates=0;

update human_resources
set birthdate = CASE
WHEN birthdate LIKE '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
WHEN birthdate LIKE '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
else null
end;

ALTER table human_resources
MODIFY column birthdate DATE;

ALTER table human_resources
MODIFY column hire_date DATE;

update human_resources
set hire_date = CASE
WHEN hire_date LIKE '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
WHEN hire_date LIKE '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
else null
end;

update human_resources
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate != '';


SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE human_resources
MODIFY COLUMN termdate DATE;

alter table human_resources
add column age int;

UPDATE human_resources
set age=timestampdiff(YEAR,birthdate,CURDATE());

select min(age) as Youngest, max(age) as oldest from human_resources;

select count(*) from human_resources where age<18;
