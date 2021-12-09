/**********************************************************************
 * NAME: Zach Sahlin
 * CLASS: CPSC 321 Fall 2021
 * DATE: 11/08/2021
 * HOMEWORK: 7
 * DESCRIPTION: Runs queries on the skiing database
 **********************************************************************/


-- (a) find all ski resorts with new snow in 48 hours, ordered by most new snow in 48 hours, and then by most new snow in 24 hours
SELECT name, 24hr, 48hr
FROM resort
WHERE 48hr > 0
ORDER BY 48hr DESC, 24hr DESC;

-- (b) find all ski resorts with Seattle as their nearest city
SELECT resort.name
FROM resort
WHERE resort.nearest_city = 'Seattle';

-- (c) find all ski resorts, ordered by most open double black trails
SELECT resort.name, COUNT(run.name)
FROM resort JOIN run ON resort.name = run.resort
WHERE run.difficulty = 'double black' AND run.status = 'open'
GROUP BY resort.name
ORDER BY COUNT(run.name) DESC;

-- (d) find the total open chairlift capacity of each resort
SELECT resort.name, SUM(chairlift.capacity)
FROM resort JOIN chairlift on resort.name = chairlift.resort
WHERE chairlift.status = 'open'
GROUP BY resort.name
ORDER BY SUM(chairlift.capacity) DESC;

-- (e) find all skiers that have won races, ordered by the most wins
SELECT skier.first_name, skier.last_name, COUNT(skier.id)
FROM skier JOIN competition ON skier.id = competition.1st_place
GROUP BY skier.id
ORDER BY COUNT(skier.id) DESC;
