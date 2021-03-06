-- 0 SELECT basics
-- 1.
SELECT population FROM world WHERE name = 'Germany';
-- 2.
SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway', 'Denmark');
-- 3.
SELECT name, area FROM world WHERE area BETWEEN 200000 AND 250000;
-- 1 SELECT name ???
-- 1.
-- 2.
-- 3.
-- 4.
-- 5.
-- 6.
-- 7.
-- 8.
-- 9.
-- 10.
-- 11.
-- 12.
-- 13, 14, and 15 have a bug, please skip them

-- 2 SELECT from World
-- 1.
SELECT name, continent, population FROM world;
-- 2.
SELECT name FROM world WHERE population > 200000000;
-- 3.
SELECT name, gdp/population FROM world WHERE population > 200000000;
-- 4.
SELECT name, population/1000000 FROM world WHERE continent = 'South America';
-- 5.
SELECT name, population FROM world WHERE name= 'France' OR name= 'Germany' OR name= 'Italy';
-- 6.
SELECT name FROM world WHERE name LIKE 'United%';
-- 7.
SELECT name, population, area FROM world
WHERE area > 3000000 OR population > 250000000;
-- 8.
SELECT name, population, area FROM world
WHERE area > 3000000 XOR population > 250000000;
-- 9.
SELECT name, ROUND(population/1000000, 2), ROUND(GDP/1000000000, 2) FROM world
WHERE continent='South America';
-- 10.
SELECT name, ROUND(GDP/population, -3) FROM world
WHERE GDP>1000000000000;
-- 11.
SELECT name, capital FROM world WHERE LENGTH(name) = LENGTH(capital);
-- 12.
SELECT name, capital FROM world WHERE LEFT(name,1) = LEFT(capital,1) AND capital <> name;

-- 3 SELECT from Nobel
-- 1.
SELECT yr, subject, winner FROM nobel WHERE yr = 1950;
-- 2.
SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'Literature';
-- 3.
SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein';
-- 4.
SELECT winner FROM nobel WHERE subject = 'Peace' AND yr > 1999;
-- 5.
SELECT * FROM nobel WHERE subject = 'Literature' AND yr BETWEEN '1980' AND '1989';
-- 6.
SELECT * FROM nobel WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
-- 7.
SELECT winner FROM nobel WHERE winner LIKE 'John%';
-- 8.
SELECT * FROM nobel WHERE subject = 'Physics' AND yr = '1980' OR subject = 'Chemistry' AND yr = '1984';
-- 9.
SELECT * FROM nobel WHERE yr = '1980' AND subject <> 'Chemistry' AND subject <> 'Medicine';
-- 10.
SELECT * FROM nobel WHERE subject = 'Medicine' AND yr < 1910 OR subject = 'Literature' AND yr >= '2004';
-- 11.
SELECT * FROM nobel WHERE winner LIKE 'Peter Gr%';
-- 12.
SELECT * FROM nobel WHERE winner LIKE 'Eugene O%';
-- 13.
SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC;
-- 14.
SELECT winner, subject FROM nobel WHERE yr = 1984 ORDER BY subject IN ('Physics', 'Chemistry'), subject, winner; 


-- 4 SELECT within SELECT
-- 1.
SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia');
-- 2.
SELECT name FROM world WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom');
-- 3.
SELECT name, continent FROM world WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina') OR continent = (SELECT continent FROM world WHERE name = 'Australia') ORDER BY name
-- 4.
SELECT name, population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');
-- 5.
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany') * 100, 0), '%') FROM world WHERE continent = 'Europe'; 

-- As noted in the tutorial, questions 6 - 10 in this unit are considered bonuses, just like units 6 - 8+
-- 6.
SELECT name FROM world WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0)
-- 7.
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0);

-- 8.
SELECT continent, name FROM world x 
WHERE name <= ALL(SELECT name FROM world y 
WHERE x.continent=y.continent AND name IS NOT NULL);
-- 9.
SELECT name, continent, population FROM world WHERE continent <> ALL(SELECT continent FROM world WHERE population >= 25000000)
-- 10.



-- 5 SUM and COUNT
-- 1.
SELECT SUM(population) FROM world
-- 2.
SELECT DISTINCT(continent) FROM world
-- 3.
SELECT SUM(gdp) FROM world WHERE continent = 'Africa'
-- 4.
SELECT COUNT(name) FROM world WHERE area > 1000000
-- 5.
SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
-- 6.
SELECT continent, COUNT(name) FROM world GROUP BY continent
-- 7.
SELECT continent, COUNT(name) FROM world WHERE population >= 10000000 GROUP BY continent
-- 8.
SELECT continent FROM world GROUP BY continent HAVING SUM(population) > 100000000

-- Note: the units below this are bonus for this weekend, and they will be required in a future assignment. If you do them now you will be ahead of the game!
-- 6 JOIN
-- 1.
SELECT matchid, player FROM goal WHERE teamid = 'GER' 
-- 2.
SELECT id,stadium,team1,team2 FROM game WHERE id = 1012
-- 3.
SELECT player, teamid, stadium, mdate FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER'
-- 4.
SELECT team1, team2, player FROM game JOIN goal ON (id=matchid) WHERE player LIKE 'Mario%'
-- 5.
SELECT player, teamid, coach, gtime FROM goal JOIN eteam ON (teamid=id) WHERE gtime <=10
-- 6.
SELECT mdate, teamname FROM game JOIN eteam ON (team1=eteam.id) WHERE coach = 'Fernando Santos'
-- 7.
SELECT player FROM goal JOIN game ON (id=matchid) WHERE stadium = 'National Stadium, Warsaw'
-- 8.
SELECT DISTINCT(player) FROM goal JOIN game ON (id=matchid) WHERE teamid != 'GER' AND (team1 = 'GER' OR team2 = 'GER')
-- 9.
SELECT teamname, COUNT(player) FROM eteam JOIN goal ON id=teamid GROUP BY teamname
-- 10.
SELECT stadium, COUNT(stadium) FROM game JOIN goal ON id=matchid GROUP BY stadium
-- 11.
SELECT matchid, mdate, COUNT(teamid) FROM game JOIN goal ON (matchid=id) WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate
-- 12.
SELECT matchid, mdate, COUNT(teamid) FROM game JOIN goal ON (matchid=id) WHERE teamid = 'GER' GROUP BY matchid, mdate
-- 13.



-- 7 More JOIN operations
-- 1.
SELECT id, title FROM movie WHERE yr=1962
-- 2.
SELECT yr FROM movie WHERE title = 'Citizen Kane'
-- 3.
SELECT id, title, yr FROM movie WHERE title LIKE 'Star Trek%' ORDER BY yr
-- 4.
SELECT id FROM actor WHERE name = 'Glenn Close'
-- 5.
SELECT id FROM movie WHERE title = 'Casablanca'
-- 6.
SELECT name FROM actor JOIN casting ON (actorid=id) WHERE movieid=11768 
-- 7.
SELECT name FROM actor JOIN casting ON (actor.id=actorid) JOIN movie ON (movie.id=movieid) WHERE title = 'Alien'

-- 8.
SELECT title FROM movie JOIN casting ON (movie.id=movieid) JOIN actor ON (actor.id=actorid) WHERE name = 'Harrison Ford'
-- 9.
SELECT title, name FROM movie JOIN casting ON (movie.id=movieid) JOIN actor ON (actor.id=actorid) WHERE yr = 1962 AND ord = 1
-- 10.
SELECT title FROM movie JOIN casting ON (movie.id=movieid) JOIN actor ON (actor.id=actorid) WHERE name = 'Harrison Ford' AND ord != 1
-- 11.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON (movie.id=movieid)
        JOIN actor   ON (actorid=actor.id)
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
-- 12.
SELECT title, name FROM movie
JOIN casting ON (movie.id=movieid)
JOIN actor ON (actor.id=actorid)
WHERE ord = 1 AND movieid IN
(SELECT movieid FROM casting
JOIN actor ON (actor.id=actorid)
WHERE name='Julie Andrews')
-- 13.
SELECT name FROM actor 
JOIN casting ON (actor.id=actorid) 
WHERE actorid IN (SELECT actorid FROM casting WHERE ord = 1 GROUP BY actorid HAVING COUNT(actorid) > 15) GROUP BY name
-- 14.

-- 15.


-- 8 Using Null
-- 1.
SELECT name FROM teacher WHERE dept IS NULL
-- 2.
SELECT teacher.name, dept.name FROM teacher INNER JOIN dept ON (teacher.dept=dept.id)
-- 3.
SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)
-- 4.
SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)
-- 5.
SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher 
-- 6.
SELECT COALESCE(teacher.name, 'None'), COALESCE(dept.name, 'None') FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)
-- 7.
SELECT COUNT(teacher.name), COUNT(mobile) FROM teacher 
-- 8.
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id) GROUP BY dept.name
-- 9.
SELECT teacher.name, CASE WHEN dept=1 THEN 'Sci' WHEN dept=2 THEN 'Sci' ELSE 'Art' END
FROM teacher 
-- 10.
SELECT teacher.name, CASE WHEN dept=1 THEN 'Sci' WHEN dept=2 THEN 'Sci' WHEN dept=3 THEN 'Art' Else 'None' END
FROM teacher


-- 8+ Numeric Examples
-- 1.

-- 2.

-- 3.

-- 4.

-- 5.

-- 6.

-- 7.

-- 8.

