# SPOTIFY DATA ANALYSIS PROJECT - SQL
This project analyzes a Spotify dataset containing information about tracks, artists, albums and audio features. The focus is on generating insights about platform-specific engagement, song durations, and artist popularity, while also addressing data inconsistencies. The analysis was conducted using PostgreSQL in pgAdmin. 
The dataset was sourced from [Kaggle.](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset/data?select=cleaned_dataset.csv) 

## 1. Dataset Overview
This dataset contains information about 24 columns and 20,000+ rows, including audio features like danceability, energy, and liveliness.

## Columns
          • Track Information: artist, track, album, album_type.
          • Audio features: danceability, energy, tempo, valence, loudness, etc.
          • Platform Engagement: views, stream, most_played_on (Spotify/YouTube).

## Data Inconsistencies 
      • 469 tracks had '0' views and/or streams, yet 21 of them were marked as ''most played on YouTube".
      • 468 tracks had licensed = 'false'.
      • 576 tracks have '0' streams which includes globally popular tracks such as "Enter Sandman (Remastered)" by Metallica and "The Great Gig in the Sky" by Pink Floyd, which is implausible. 

## 2. Key Insights

## Basic Exploration
     • Total rows in the dataset: 20,595 rows (including headers).
     • Distinct Album types: Single, Album, Compilation.
     • Track Distribution by Platform: 
          a. Majority of tracks are marked as "most played on Spotify".
          b. YouTube accounts for fewer tracks in the dataset. 

## Performance Metrics 
    • Top Artists by Total Streams: 
               SELECT artist, SUM(stream) AS total_streams
               FROM spotify
               GROUP BY artist
               ORDER BY total_streams DESC
               LIMIT 10;
               
    • Most Viewed Tracks on YouTube:
              SELECT track, artist, views
              FROM spotify
              ORDER BY views DESC
              LIMIT 10;

    • Top 3 Most-Viewed Tracks per Artist:
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
            
    • Top 3 Most-Streamed Tracks per Artist: 
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

## Song Duration Analysis
    • Categories by Duration: 
       SELECT 
              CASE 
	         WHEN duration_min < 3 THEN 'Short'
	         WHEN duration_min BETWEEN 3 AND 4 THEN 'Medium'
	         ELSE 'Long'
	    END AS duration_category, 
	   COUNT(*) AS count
       FROM spotify
       GROUP BY duration_category;
Short tracks (<3 minutes): 5159 tracks
Medium tracks (3-4 minutes): 9066 tracks
Long tracks (>4 minutes): 6367 tracks

