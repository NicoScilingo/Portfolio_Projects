SELECT * from 
layoffs;

-- 1. Remove Duplicates
-- 2. Standarize the Data
-- 3. Null Values or Blank Values (populate or not)
-- 4. Remove unnecesary columns or rows


-- 0. not work on real data, create a staging DB to work on
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
select * 
from layoffs;

-- 1. removing duplicates
select *, 
row_number () over (
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;



WITH duplicate_cte AS
(
select *, 
row_number () over (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * from duplicate_cte
where row_num > 1;


select * from layoffs_staging2 where company = 'Casper';




CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2
where row_num >1;

insert into layoffs_staging2
select *, 
row_number () over (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

delete from layoffs_staging2
where row_num >1;

-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- 2 Standarizing Data

select * from layoffs_staging2;

UPDATE layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


select distinct location
from layoffs_staging2
order by 1;

update layoffs_staging2
set location = 'Dusseldorf'
where location like '%sseldorf';

update layoffs_staging2
set location = 'Florianapolis'
where location like 'Floria%';

select distinct country, trim(country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = 'United States'
where country like 'United States%';

select `date`
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

-- Populating NULL Blank Valus

select * from  layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

SELECT *
FROM layoffs_staging2
where industry is null
or industry = '';

-- I choose Airbnb because is the first one in order for me to confirm the industry for Airbnb

select * from layoffs_staging2 where company = 'Airbnb';

-- I see company is 'Travel', so I update it on the missing one using a joint

select * from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

select t1.industry, t2.industry from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

-- the query below didnt work because we didnte change blanks to null

UPDATE layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
SET t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;


update layoffs_staging2
set industry = null
where industry = '';

-- Removing unnecessary rows and columns

select * from  layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete from  layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging2;





alter table layoffs_staging2 drop column row_num;

-- To see how much layoffs per month there were>

SELECT SUBSTRING(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where SUBSTRING(`date`,1,7) is not null
group by `month`
order by 1 asc;

-- Rolling Total of LayOffs below with CTEs

WITH Rolling_Total AS (
SELECT SUBSTRING(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where SUBSTRING(`date`,1,7) is not null
group by `month`
order by 1 asc
)
SELECT `MONTH`, total_off,
sum(total_off) over (order by `month`) as rolling_total
from Rolling_Total;

-- Multiple CTEs to filter top 5 total layoffs per year by company

SELECT company, YEAR(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`date`)
order by 3 desc;

with Company_Year (company, years, total_laid_off) as
(
SELECT company, YEAR(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`date`)
), Company_Year_Rank as 
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
from Company_Year
WHERE years is not null
)
select * from company_year_rank
WHERE Ranking <=5;
