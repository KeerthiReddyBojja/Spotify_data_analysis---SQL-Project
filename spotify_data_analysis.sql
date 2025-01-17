-- Replacing 0 with NULL to signify missing data

UPDATE spotify
SET views = NULL
WHERE views = 0;

UPDATE spotify
SET stream = NULL
WHERE stream = 0;
---------------------------------------------------------- 
-- Adding column for further analysis

ALTER TABLE spotify
ADD COLUMN flagged_for_investigation INT DEFAULT 0;
----------------------------------------------------------
-- Flagging records where views and streams IS NULL

UPDATE spotify
SET flagged_for_investigation = 1
WHERE views IS NULL AND stream IS NULL
----------------------------------------------------------
-- Flagging records uploaded by Fan-Made Channels

UPDATE spotify
SET flagged_for_investigation = 2
WHERE stream IS NULL
  AND official_video = 'false'
  AND LOWER(artist) NOT LIKE LOWER(channel)
  AND (channel IS NOT NULL AND channel != '0')
  AND (title IS NOT NULL AND title != '0')
  AND (views IS NOT NULL AND views != 0)
  AND flagged_for_investigation <> 1;
-----------------------------------------------------------
-- Flagging records with views IS NULL

UPDATE spotify
SET flagged_for_investigation = 3
WHERE views IS NULL
  AND official_video = 'false'
  AND flagged_for_investigation <> 1;
-----------------------------------------------------------
--  Number of rows in the dataset

SELECT COUNT(*)
FROM spotify; 
----------------------------------------------------------
--  Distinct album types 

SELECT DISTINCT album_type 
FROM spotify;
----------------------------------------------------------
--  Distinct applications 

SELECT DISTINCT most_played_on 
FROM spotify;
----------------------------------------------------------
--  Top 10 tracks based on the views

SELECT track, artist, views
FROM spotify
ORDER BY views DESC
LIMIT 10;
-----------------------------------------------------------
--  Top 10 tracks based on the streams

SELECT track, artist, stream
FROM spotify
ORDER BY stream DESC
LIMIT 10;
----------------------------------------------------------
--  Top 10 artists based on their total streams

SELECT artist, SUM(stream) AS total_streams
FROM spotify
GROUP BY artist
ORDER BY total_streams DESC
LIMIT 10;
----------------------------------------------------------
--  Top 10 artists based on their total views

SELECT artist, SUM(views) AS total_views
FROM spotify
GROUP BY artist
ORDER BY total_views DESC
LIMIT 10;
---------------------------------------------------------
--  Maximum and minimum duration for the tracks

SELECT MAX(duration_min), MIN(duration_min)
FROM spotify;

/* Minimum duration for a song is 0 minutes. A song cannot be 0 minutes- */

SELECT *
FROM spotify
WHERE duration_min = 0;

--  Removing the records--
DELETE FROM spotify
WHERE duration_min = 0;
--------------------------------------------------------
--  Distributions of Song Durations

SELECT 
    CASE 
	   WHEN duration_min < 3 THEN 'Short'
	   WHEN duration_min BETWEEN 3 AND 4 THEN 'Medium'
	   ELSE 'Long'
	 END AS duration_category, 
	 COUNT(*) AS count
FROM spotify
GROUP BY duration_category;
---------------------------------------------------------
--  Distribution of most played songs by application

SELECT most_played_on, COUNT(*) AS count
FROM spotify
GROUP BY most_played_on
ORDER BY count DESC; 
---------------------------------------------------------
--  Listing albums with their respective artists

SELECT artist, album
FROM spotify;
---------------------------------------------------------
--  Listing all tracks that belong to album type 'single'

SELECT track
FROM spotify
WHERE album_type = 'single';
----------------------------------------------------------
--  Count the total number of tracks by each artist

SELECT artist, COUNT(*) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks DESC;
----------------------------------------------------------
--  Average danceability of tracks in each album

SELECT album, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;
-----------------------------------------------------------
--  Calculate total views for an album (including all tracks)

SELECT album, track, SUM(views) AS total_views
FROM spotify
GROUP BY album, track
ORDER BY total_views DESC
------------------------------------------------------------
--  Calculate total streams for an album (including all tracks)

SELECT album, track, SUM(stream) AS total_streams
FROM spotify
GROUP BY album, track
ORDER BY total_streams DESC;
-------------------------------------------------------------
--  Top 3 most-viewed tracks for each artist

WITH ranked_tracks AS (
    SELECT 
        artist,
        track,
        views,
        RANK() OVER (PARTITION BY artist ORDER BY views DESC) AS rank
    FROM spotify
)
SELECT artist, track, views
FROM ranked_tracks
WHERE rank <= 3
ORDER BY artist, rank;
--------------------------------------------------------------
-- Top 3 most-viewed tracks for each artist

WITH ranked_tracks AS (
    SELECT 
        artist,
        track,
        stream,
        RANK() OVER (PARTITION BY artist ORDER BY stream DESC) AS rank
    FROM spotify
)
SELECT artist, track, stream
FROM ranked_tracks
WHERE rank <= 3
ORDER BY artist, rank;
----------------------------------------------------------------
-- Top 3 most-streamed tracks for each artist

WITH ranked_tracks AS (
    SELECT 
        artist,
        track,
        stream,
        RANK() OVER (PARTITION BY artist ORDER BY stream DESC) AS rank
    FROM spotify
)
SELECT artist, track, stream
FROM ranked_tracks
WHERE rank <= 3
ORDER BY artist, rank;
