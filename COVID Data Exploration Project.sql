SELECT*
FROM PortfolioProject..CovidDeaths
order by 3,4


SELECT *
FROM PortfolioProject..CovidVaccinations
order by 3,4
  

select Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
order by 1, 2

--Normalizing and Standarizing the Data Type

--First Covid Deaths Table

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidDeaths' AND TABLE_SCHEMA = 'dbo';

UPDATE PortfolioProject..CovidDeaths
SET date = TRY_CONVERT (date, date),
	population = TRY_CONVERT(BIGINT, population),
	total_cases = TRY_CONVERT(INT, total_cases),
    new_cases = TRY_CONVERT(INT, new_cases),
    new_cases_smoothed = TRY_CONVERT(FLOAT, new_cases_smoothed),
	total_deaths = TRY_CONVERT(INT, total_deaths),
    new_deaths = TRY_CONVERT(INT, new_deaths),
    total_cases_per_million = TRY_CONVERT(FLOAT, total_cases_per_million),
    new_cases_per_million = TRY_CONVERT(FLOAT, new_cases_per_million),
    new_cases_smoothed_per_million = TRY_CONVERT(FLOAT, new_cases_smoothed_per_million),
    total_deaths_per_million = TRY_CONVERT(FLOAT, total_deaths_per_million),
    new_deaths_per_million = TRY_CONVERT(FLOAT, new_deaths_per_million),
    new_deaths_smoothed_per_million = TRY_CONVERT(FLOAT, new_deaths_smoothed_per_million),
    reproduction_rate = TRY_CONVERT(FLOAT, reproduction_rate),
    icu_patients_per_million = TRY_CONVERT(FLOAT, icu_patients_per_million),
    hosp_patients_per_million = TRY_CONVERT(FLOAT, hosp_patients_per_million),
    weekly_icu_admissions_per_million = TRY_CONVERT(FLOAT, weekly_icu_admissions_per_million),
    weekly_hosp_admissions_per_million = TRY_CONVERT(FLOAT, weekly_hosp_admissions_per_million);

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN date DATE;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN population BIGINT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_cases INT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_cases INT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_cases_smoothed FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_deaths INT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_deaths INT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_cases_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_cases_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_cases_smoothed_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_deaths_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_deaths_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_deaths_smoothed_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN reproduction_rate FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN icu_patients_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN hosp_patients_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN weekly_icu_admissions_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN weekly_hosp_admissions_per_million FLOAT;



SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidDeaths' AND TABLE_SCHEMA = 'dbo';


UPDATE PortfolioProject..CovidDeaths
SET 
    continent = NULLIF(continent,''),
	population = NULLIF(population, '0'),
    total_cases = NULLIF(total_cases, '0'),
    new_cases = NULLIF(new_cases, '0'),
    new_cases_smoothed = NULLIF(new_cases_smoothed, '0'),
    total_deaths = NULLIF(total_deaths, '0'),
    new_deaths = NULLIF(new_deaths, '0'),
    total_cases_per_million = NULLIF(total_cases_per_million, '0'),
    new_cases_per_million = NULLIF(new_cases_per_million, '0'),
    new_cases_smoothed_per_million = NULLIF(new_cases_smoothed_per_million, '0'),
    total_deaths_per_million = NULLIF(total_deaths_per_million, '0'),
    new_deaths_per_million = NULLIF(new_deaths_per_million, '0'),
    new_deaths_smoothed_per_million = NULLIF(new_deaths_smoothed_per_million, '0'),
    reproduction_rate = NULLIF(reproduction_rate, '0'),
    icu_patients_per_million = NULLIF(icu_patients_per_million, '0'),
    hosp_patients_per_million = NULLIF(hosp_patients_per_million, '0'),
    weekly_icu_admissions_per_million = NULLIF(weekly_icu_admissions_per_million, '0'),
    weekly_hosp_admissions_per_million = NULLIF(weekly_hosp_admissions_per_million, '0');


-- Second CovidVaccinations Table

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidVaccinations' AND TABLE_SCHEMA = 'dbo';

UPDATE PortfolioProject..CovidVaccinations
SET 
    date = TRY_CONVERT(DATE, date),
    new_tests = TRY_CONVERT(INT, new_tests),
    total_tests = TRY_CONVERT(INT, total_tests),
    total_tests_per_thousand = TRY_CONVERT(FLOAT, total_tests_per_thousand),
    new_tests_per_thousand = TRY_CONVERT(FLOAT, new_tests_per_thousand),
    new_tests_smoothed = TRY_CONVERT(INT, new_tests_smoothed),
    new_tests_smoothed_per_thousand = TRY_CONVERT(FLOAT, new_tests_smoothed_per_thousand),
    positive_rate = TRY_CONVERT(FLOAT, positive_rate),
    tests_per_case = TRY_CONVERT(FLOAT, tests_per_case),
    total_vaccinations = TRY_CONVERT(INT, total_vaccinations),
    people_vaccinated = TRY_CONVERT(INT, people_vaccinated),
    people_fully_vaccinated = TRY_CONVERT(INT, people_fully_vaccinated),
    new_vaccinations = TRY_CONVERT(INT, new_vaccinations),
    new_vaccinations_smoothed = TRY_CONVERT(FLOAT, new_vaccinations_smoothed),
    total_vaccinations_per_hundred = TRY_CONVERT(INT, total_vaccinations_per_hundred),
    people_vaccinated_per_hundred = TRY_CONVERT(FLOAT, people_vaccinated_per_hundred),
    people_fully_vaccinated_per_hundred = TRY_CONVERT(FLOAT, people_fully_vaccinated_per_hundred),
    new_vaccinations_smoothed_per_million = TRY_CONVERT(FLOAT, new_vaccinations_smoothed_per_million),
    stringency_index = TRY_CONVERT(FLOAT, stringency_index),
    population_density = TRY_CONVERT(FLOAT, population_density),
    median_age = TRY_CONVERT(FLOAT, median_age),
    aged_65_older = TRY_CONVERT(FLOAT, aged_65_older),
    aged_70_older = TRY_CONVERT(FLOAT, aged_70_older),
    gdp_per_capita = TRY_CONVERT(FLOAT, gdp_per_capita),
    extreme_poverty = TRY_CONVERT(FLOAT, extreme_poverty),
    cardiovasc_death_rate = TRY_CONVERT(FLOAT, cardiovasc_death_rate),
    diabetes_prevalence = TRY_CONVERT(FLOAT, diabetes_prevalence),
    female_smokers = TRY_CONVERT(FLOAT, female_smokers),
    male_smokers = TRY_CONVERT(FLOAT, male_smokers),
    handwashing_facilities = TRY_CONVERT(FLOAT, handwashing_facilities),
    hospital_beds_per_thousand = TRY_CONVERT(FLOAT, hospital_beds_per_thousand),
    life_expectancy = TRY_CONVERT(FLOAT, life_expectancy),
    human_development_index = TRY_CONVERT(FLOAT, human_development_index);



ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN date DATE;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN new_tests INT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN total_tests INT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN total_tests_per_thousand FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN new_tests_per_thousand FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN new_tests_smoothed INT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN new_tests_smoothed_per_thousand FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN positive_rate FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN tests_per_case FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN total_vaccinations INT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN people_vaccinated INT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN people_fully_vaccinated INT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN new_vaccinations INT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN new_vaccinations_smoothed FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN total_vaccinations_per_hundred FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN people_vaccinated_per_hundred FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN people_fully_vaccinated_per_hundred FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN new_vaccinations_smoothed_per_million FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN stringency_index FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN population_density FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN median_age FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN aged_65_older FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN aged_70_older FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN gdp_per_capita FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN extreme_poverty FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN cardiovasc_death_rate FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN diabetes_prevalence FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN female_smokers FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN male_smokers FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN handwashing_facilities FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN hospital_beds_per_thousand FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN life_expectancy FLOAT;

ALTER TABLE PortfolioProject..CovidVaccinations
ALTER COLUMN human_development_index FLOAT;


UPDATE PortfolioProject..CovidVaccinations
SET 
    continent = NULLIF(continent,''),
	population_density = NULLIF(population_density, '0'),
    total_vaccinations = NULLIF(total_vaccinations, '0'),
    people_vaccinated = NULLIF(people_vaccinated, '0'),
    people_fully_vaccinated = NULLIF(people_fully_vaccinated, '0'),
    new_vaccinations = NULLIF(new_vaccinations, '0'),
    new_vaccinations_smoothed = NULLIF(new_vaccinations_smoothed, '0'),
    total_vaccinations_per_hundred = NULLIF(total_vaccinations_per_hundred, '0'),
    people_vaccinated_per_hundred = NULLIF(people_vaccinated_per_hundred, '0'),
    people_fully_vaccinated_per_hundred = NULLIF(people_fully_vaccinated_per_hundred, '0'),
    new_vaccinations_smoothed_per_million = NULLIF(new_vaccinations_smoothed_per_million, '0'),
    stringency_index = NULLIF(stringency_index, '0'),
    median_age = NULLIF(median_age, '0'),
    aged_65_older = NULLIF(aged_65_older, '0'),
    aged_70_older = NULLIF(aged_70_older, '0'),
    gdp_per_capita = NULLIF(gdp_per_capita, '0'),
    extreme_poverty = NULLIF(extreme_poverty, '0'),
    cardiovasc_death_rate = NULLIF(cardiovasc_death_rate, '0'),
    diabetes_prevalence = NULLIF(diabetes_prevalence, '0'),
    female_smokers = NULLIF(female_smokers, '0'),
    male_smokers = NULLIF(male_smokers, '0'),
    handwashing_facilities = NULLIF(handwashing_facilities, '0'),
    hospital_beds_per_thousand = NULLIF(hospital_beds_per_thousand, '0'),
    life_expectancy = NULLIF(life_expectancy, '0'),
    human_development_index = NULLIF(human_development_index, '0');


--Total Cases vs Total Deaths Query

SELECT 
    Location, 
    date, 
    total_cases, 
    total_deaths, 
    CAST(total_deaths AS FLOAT) / NULLIF(total_cases, 0) * 100 AS DeathRate_per_Cases
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2;

SELECT 
    Location, 
    date, 
    total_cases, 
    total_deaths, 
    CAST(total_deaths AS FLOAT) / NULLIF(total_cases, 0) * 100 AS DeathRate_per_Cases
FROM PortfolioProject..CovidDeaths
WHERE Location = 'Argentina'
ORDER BY 1, 2;


-- Total Cases VS Population

SELECT 
    Location, 
    date, 
    total_cases, 
    population, 
    CAST(total_cases AS FLOAT) / NULLIF(Population, 0) * 100 AS Population_Percentage_Infected
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2;

SELECT 
    Location, 
    date, 
    total_cases, 
    population, 
    CAST(total_cases AS FLOAT) / NULLIF(Population, 0) *100 AS Population_Percentage_Infected
FROM PortfolioProject..CovidDeaths
WHERE Location = 'Argentina'
ORDER BY 1, 2;


-- Countries with Highest Infection Rates vs Population

SELECT 
    Location,  
    MAX(total_cases) as Highest_Infection_Count, 
    population, 
    CAST(MAX(total_cases) AS FLOAT) / NULLIF(Population, 0) * 100 AS Population_Percentage_Infected
FROM PortfolioProject..CovidDeaths
group by Location, population
order by Population_Percentage_Infected desc;

-- Countries with the highest Death count per Population

SELECT Location, MAX(total_deaths) as Highest_Death_Count
FROM PortfolioProject..CovidDeaths
where continent is not null
group by Location
order by Highest_Death_Count desc;

SELECT 
    Location,  
    MAX(total_deaths) as Highest_Death_Count, 
    population, 
    CAST(MAX(total_deaths) AS FLOAT) / NULLIF(Population, 0) * 100 AS Total_Death_Percentage
FROM PortfolioProject..CovidDeaths
group by Location, population
order by Total_Death_Percentage desc;


-- Continents with Highest DeathCount

SELECT location, MAX(total_deaths) as Highest_Death_Count
FROM PortfolioProject..CovidDeaths
where continent is  null
group by location
order by Highest_Death_Count desc;


-- Global Numbers

Select date, SUM(new_cases) as total_world_cases, SUM(cast(new_deaths as int)) as total_world_deaths, SUM(cast(new_deaths as float))/SUM(New_Cases)*100 as total_worlds_DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
Group By date
order by 1,2


Select SUM(new_cases) as total_world_cases, SUM(cast(new_deaths as int)) as total_world_deaths, SUM(cast(new_deaths as float))/SUM(New_Cases)*100 as total_worlds_DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2


-- Joining tables to have a good view

SELECT*
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date

--Total Population vs Total Vaccinations 2 Options

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT (float, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- Option 1: CTE  for Total Population vs Total Vaccinations

With PopVSVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT (float, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null)

select *, (RollingPeopleVaccinated/Population)*100 as Percentage_Of_Vaccinated_Population
from PopVSVac


-- Option 2: Temp Table for Total Population vs Total Vaccinations

Drop Table if exists #Percentage_Of_Vaccinated_Population
Create Table #Percentage_Of_Vaccinated_Population
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric,
)

INSERT INTO #Percentage_Of_Vaccinated_Population
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT (float, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

select *, (RollingPeopleVaccinated/Population)*100 as Percentage_Of_Vaccinated_Population
from #Percentage_Of_Vaccinated_Population


-- Creating Views to store data for later visualizations

-- Percentage of Vaccinated Population View

create view Percentage_Of_Vaccinated_Population as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT (float, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null


-- Continents with Highest DeathCount View
create view Highest_DeathCount as
SELECT location, MAX(total_deaths) as Highest_Death_Count
FROM PortfolioProject..CovidDeaths
where continent is  null
group by location
--order by Highest_Death_Count desc;


-- Total Worlds Deaths View
create view Total_Worlds_Deaths as
Select SUM(new_cases) as total_world_cases, SUM(cast(new_deaths as int)) as total_world_deaths, SUM(cast(new_deaths as float))/SUM(New_Cases)*100 as total_worlds_DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
--order by 1,2

-- Conuntries with Highest DeathCount per Population
create view Conuntries_with_Highest_DeathCount_per_Population as
SELECT 
    Location,  
    MAX(total_deaths) as Highest_Death_Count, 
    population, 
    CAST(MAX(total_deaths) AS FLOAT) / NULLIF(Population, 0) * 100 AS Total_Death_Percentage
FROM PortfolioProject..CovidDeaths
group by Location, population
--order by Total_Death_Percentage desc;

-- Countries Death per Date
create view Countries_Death_Per_Date as
SELECT 
    Location, 
    date, 
    total_cases, 
    total_deaths, 
    CAST(total_deaths AS FLOAT) / NULLIF(total_cases, 0) * 100 AS DeathRate_per_Cases
FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;


--Argentina's Death per Date
create view Argentina_Death_Per_Date as
SELECT 
    Location, 
    date, 
    total_cases, 
    total_deaths, 
    CAST(total_deaths AS FLOAT) / NULLIF(total_cases, 0) * 100 AS DeathRate_per_Cases
FROM PortfolioProject..CovidDeaths
WHERE Location = 'Argentina'
--ORDER BY 1, 2;
