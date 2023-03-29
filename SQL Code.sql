-- data cleaning --

-- remove unnecesary columnss
ALTER TABLE steam
DROP COLUMN "english";

ALTER TABLE steam
DROP COLUMN "required_age"
-- trim whitespace
trim whitespace
select *
from steam
trim
-- check duplicates
select appid
from steam
    GROUP BY appid
    HAVING COUNT(*) > 1
-- check for null values
delete from steam
where name is NULL or appid is NULL or release_date is NULL or developer is NULL or publisher is NULL or platforms is NULL or categories is NULL or genres is NULL or steamspy_tags is NULL or achievements is NULL or  positive_ratings is NULL or  negative_ratings is NULL or average_playtime is NULL or median_playtime is NULL or owners is NULL or price is NULL

-- clean owners COLUMN
UPDATE steam
SET owners = CAST(SUBSTR(owners, INSTR(owners, '-') + 1) AS UNSIGNED);

--export view 
SELECT *
from steam
-- Explotatory data analysis--

SELECT *,
    average_playtime * owners AS total_playtime
FROM steam
-- calculate averages
SELECT AVG(price) AS avg_price,
       AVG(positive_ratings) AS avg_reviews,
       AVG(negative_ratings) AS avg_neg_reviews,
       AVG(price/(positive_ratings+negative_ratings)) AS avg_spending_per_player
FROM steam
-- calculate positive_ratings and negative_ratings by year
SELECT strftime('%Y', release_date) as release_year, 
		AVG(positive_ratings) as avg_positive_ratings, 
		AVG(negative_ratings) as avg_negative_reviews
FROM steam
GROUP BY release_year
-- playing time by year
SELECT strftime('%Y', release_date) as release_year, 
		AVG(average_playtime) as avg_playing_time
FROM steam
GROUP BY release_year
-- total playtime by year
SELECT  average_playtime * owners AS total_playtime,  strftime('%Y', release_date) as release_year
from steam
GROUP by release_year
-- Does achievements increase the likely to more player retention?
SELECT (
	SELECT avg(average_playtime)
	FROM steam
	where achievements > 1
	) as yes_achievements,
	(	SELECT avg(average_playtime)
	FROM steam
	where achievements = 0
	) as no_achievements
from steam 
limit 1
-- expenditure by achievements
SELECT (
	SELECT avg(price*owners)
	FROM steam
	where achievements > 1
	) as yes_achievements,
	(	SELECT avg(price*owners)
	FROM steam
	where achievements = 0
	) as no_achievements
from steam 
limit 1
--  




