create database covid_project;

use covid_project;

create table covid_deaths (
	iso_code varchar(10),
    continent varchar(15),
    location varchar(30),
    Dt date,
    population int,
    total_cases int,
    new_cases int,
    new_cases_smoothed int,
    total_deaths int,
    new_deaths int,
    new_deaths_smoothed float(10),
    total_cases_per_million float(10),
    new_cases_per_million float(10),
    new_cases_smoothed_per_million float(10),
    total_deaths_per_million float(10),
    new_deaths_per_million float(10),
    new_deaths_smoothed_per_million float(10),
    reproduction_rate float(10),
    icu_patients float(10),
    icu_patients_per_million float(10),
    hosp_patients float(10),
    hosp_patients_per_million float(10),
    weekly_icu_addmissions float(10),
    weekly_icu_addmissions_per_million float(10),
    weekly_hosp_addmissions float(10),
    weekly_hosp_addmissions_per_million float(10)
    );

describe covid_deaths;

SET sql_mode = "";
    
LOAD DATA INFILE 'D:/Projects/SQL_Project/covid-deaths.csv'
INTO TABLE covid_deaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select count(*) from covid_deaths;

select * from covid_deaths;

create table covid_vaccinations (
	iso_code varchar(10),
    continent varchar(10),
    location varchar(30),
    Dt date,
    total_tests bigint,
    new_tests bigint,
    total_tests_per_thousand float(15),
    new_test_per_thousand float(15),
    new_tests_smoothed float(15),
    new_tests_smoothed_per_thousand float(15),
    positive_rate float(15),
    tests_per_case float(15),
    tests_units bigint,
    total_vaccinations bigint,
    people_vaccinated bigint,
    people_fully_vaccinated bigint,
    total_boosters bigint,
    new_vaccinations bigint,
    new_vaccinations_smoothed bigint,
    total_vaccinations_per_hundred float(15),
    people_vaccinated_per_hundred float(15),
    people_fully_vaccinated_per_hundred float(15),
    total_boosters_per_hundred float(15),
    new_vaccinations_smoothed_per_million float(15),
    new_people_vaccinated_smoothed float(15),
    new_people_vaccinated_smoothed_per_hundred float(15),
    stringency_index float(15),
    population_density float(15),
    median_age float(10),
    aged_65_older bigint,
    aged_70_older bigint,
    gdp_per_capita float(15),
    extreme_poverty bigint,
    cardiovasc_death_rate float(15),
    diabetes_prevalence float(15),
    female_smokers float(15),
    male_smokers float(15),
    handwashing_facilities float(15),
    hospital_beds_per_thousand float(15),
    life_expectancy float(15),
    human_development_index float(15),
    excess_mortality_cumulative_absolute float(15),
    excess_mortality_cumulative float(15),
    excess_mortality float(15),
    excess_mortality_cumulative_per_million float(15)
);

LOAD DATA INFILE 'D:/Projects/SQL_Project/covid-vaccinations.csv'
INTO TABLE covid_vaccinations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT COUNT(*) FROM covid_vaccinations;

SELECT * FROM covid_vaccinations;
