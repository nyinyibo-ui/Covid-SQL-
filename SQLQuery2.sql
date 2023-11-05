-- Shows likelihood of a person would be died in case of he or she has been infected?
SELECT 
	location,sum(dead) deadCount,sum(infected) infectedCount,(sum(dead)*1.0/Sum(infected)*100) as deadInfectedProbability
FROM 
	data
GROUP BY 
	location
ORDER BY deadInfectedProbability DESC;

-- Shows likelihood of a person would be died in case of he or she has been vaccinated?
SELECT 
	location,sum(dead) deadCount,sum(vaccinated) vaccinatedCount,(sum(dead)*1.0/Sum(vaccinated)*100) as deadVaccinatedProbability
FROM 
	data
GROUP BY 
	location
ORDER BY deadVaccinatedProbability DESC;

-- Shows vaccinated infected ration?
SELECT 
	location,sum(infected) infectedCount,sum(vaccinated) vaccinatedCount,(sum(infected)*1.0/Sum(vaccinated)) as vaccinatedInfected
FROM 
	data
GROUP BY 
	location
ORDER BY vaccinatedInfected DESC;


--Shows country death rate compared to population
SELECT 
	DISTINCT(location) ,population,
	sum(dead) OVER (PARTITION BY location) as deadCount,
	(sum(dead) OVER (PARTITION BY location)*1.0/population)*100 as deathPct
FROM 
	data
ORDER BY deathPct DESC;

-- ..............................................................................--
-- EXPORT THE ABOVE DATA INTO CSV
SELECT location
	,(sum(dead)*1.0/Sum(infected)*100) as deadInfectedProbability
	,(sum(dead)*1.0/Sum(vaccinated)*100) as deadVaccinatedProbability
	,(sum(infected)*1.0/Sum(vaccinated)) as vaccinatedInfectedRatio
	,(sum(dead)*1.0/population)*100 as deathPCT
FROM 
	data
GROUP BY 
	location,population
ORDER BY deathPCT DESC;


