USE covid_project;

SELECT * FROM covid_deaths
ORDER BY 3,4;

SELECT Location, Dt, total_cases, new_cases, total_deaths, new_deaths, population
FROM covid_deaths
ORDER BY 1, 2;

-- Total Cases vs Total Deaths
-- Shows Likelihood of death if infected by covid across the time

SELECT Location, Dt, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Percentage_deaths
FROM covid_deaths
WHERE location LIKE "%India%"
ORDER BY 1, 2;


-- Total Cases vs Population
-- Finding out the percentage of population affected by covid over time

SELECT Location, Dt, total_cases, population, (total_cases/population)*100 AS Percentage_population
FROM covid_deaths
WHERE location LIKE "%India%"
ORDER BY 1, 2;


-- Countries with highest infection rate vs population

SELECT Location, MAX(total_cases) AS Total_Cases, population, MAX(Total_Cases/population)*100 AS Percentage_population
FROM covid_deaths
GROUP BY location, population
ORDER BY Percentage_population DESC;

-- Showing countries in descending order of the number of deaths

select location, MAX(total_deaths) AS TotalDeaths
from covid_deaths
where NOT(TRIM(continent)='')
group by location
order by TotalDeaths desc;

-- Showing continents in descending order of the number of deaths

SELECT continent, MAX(total_deaths) AS Total_Deaths
FROM covid_deaths
WHERE NOT(TRIM(continent)='')
GROUP BY continent
ORDER BY Total_Deaths DESC;


SELECT location, MAX(total_deaths) AS Total_Deaths
FROM covid_deaths
WHERE TRIM(continent)=''
GROUP BY location
ORDER BY Total_Deaths DESC;

-- Global Numbers

SELECT  
	SUM(new_cases) AS TotalCases, 
	SUM(new_deaths) AS TotalDeaths, 
    (sum(new_deaths) / sum(new_cases)) * 100 AS DeathPercentage
FROM covid_deaths
WHERE NOT((continent)='')
ORDER BY 1, 2;


SELECT Dt,
	SUM(new_cases) AS TotalNewCases, 
	SUM(new_deaths) AS TotalNewDeaths
FROM covid_deaths
WHERE NOT((continent)='')
Group by Dt
ORDER BY 1, 2;



-- COVID VACCINATIONS

SELECT *
FROM covid_vaccinations;

SELECT dea.continent,
	dea.location, 
    dea.Dt, 
    dea.population, 
    vac.new_vaccinations,
	SUM(new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.Dt) AS TotalVaccinations
FROM covid_deaths dea
JOIN covid_vaccinations vac
	ON dea.location = vac.location
    AND dea.Dt = vac.Dt
WHERE dea.continent <> ''
ORDER BY 2, 3

-- Using CTE

With PopVSVac AS
(
	SELECT dea.continent,
		dea.location, 
		dea.Dt, 
		dea.population, 
		vac.new_vaccinations,
		SUM(new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.Dt) AS TotalVaccinations
	FROM covid_deaths dea
	JOIN covid_vaccinations vac
		ON dea.location = vac.location
		AND dea.Dt = vac.Dt
	WHERE dea.continent <> ''
)
SELECT *, (TotalVaccinations / population) * 100 AS PercentPopVaccinated
FROM PopVSVac

-- Using Temp Table

Drop Temporary Table if exists PercentPopVac;
Create temporary Table PercentPopVac 
(
	continent varchar(255),
    location varchar(255),
    Date date,
    Population numeric,
    new_vaccinations numeric,
    TotalVaccinations numeric
);

INSERT INTO PercentPopVac (
	SELECT dea.continent,
		dea.location, 
		dea.Dt, 
		dea.population, 
		vac.new_vaccinations,
		SUM(new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.Dt) AS TotalVaccinations
	FROM covid_deaths dea
	JOIN covid_vaccinations vac
		ON dea.location = vac.location
		AND dea.Dt = vac.Dt
	WHERE dea.continent <> ''
);

SELECT *, (TotalVaccinations / population) * 100 AS PercentPopVaccinated
FROM PercentPopVac; 



create view PercentagePeopleVaccinated AS (
SELECT dea.continent,
		dea.location, 
		dea.Dt, 
		dea.population, 
		vac.new_vaccinations,
		SUM(new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.Dt) AS TotalVaccinations
	FROM covid_deaths dea
	JOIN covid_vaccinations vac
		ON dea.location = vac.location
		AND dea.Dt = vac.Dt
	WHERE dea.continent <> ''
)

SELECT *
FROM PercentagePeopleVaccinated