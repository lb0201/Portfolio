/**
COVID-19 Data Analysis
**/

--Select All Data
SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4


-- Select Data that going to be used

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- Total Cases vs Total Deaths
-- Death rate of COVID in South Korea
   
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%korea%'
ORDER BY 1,2

-- Total Cases vs population
-- Percentage of the population infected with Covid in South Korea

SELECT Location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%korea%'
ORDER BY 1,2

-- Countries with the Highest Infection Rate compared to the Population

SELECT Location, population, MAX(total_cases) AS highestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Countries with the Highest Death Count per Population

SELECT Location, MAX(CAST(Total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


--BREAKING THINGS DOWN BY CONTINENT

-- Showing continents with the highest death count per population

SELECT continent, MAX(CAST(Total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC 



-- GLOBAL NUMBERS

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE continent like '%korea%'
WHERE continent IS NOT NULL
--Group by date
ORDER BY 1,2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has received at least one COVID-19 vaccine
   
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition BY dea.location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac 
         ON dea.location = vac.location 
         AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3



--USE CTE to perform Calculation on Partition By in the previous query

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS int)) OVER (Partition BY dea.location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac 
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--order by 1,2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac





--TEMP TABLE to perform calculation By in previous query

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopleVacinated numeric
)


INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition BY dea.location ORDER BY dea.location, 
dea.Date) AS RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac 
   ON dea.location = vac.location 
   AND dea.date = vac.date
--where dea.continent is not null
--order by 1,2,3

SELECT *, (RollingPeopleVacinated/Population)*100
FROM #PercentPopulationVaccinated

-- Creating View to store data for later visualization

CREATE VIEW percentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition BY dea.location ORDER BY dea.location, 
dea.Date) AS RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac 
         ON dea.location = vac.location 
         AND dea.date = vac.date
WHERE dea.continent IS NOT NULL


SELECT *
FROM percentPopulationVaccinated
