# SPOTIFY DATA ANALYSIS PROJECT - SQL
This project analyzes a Spotify dataset containing information about tracks, artists, albums and audio features. The focus is on generating insights about platform-specific engagement, song durations, and artist popularity, while also addressing data inconsistencies. The analysis was conducted using PostgreSQL in pgAdmin. 
The dataset was sourced from [Kaggle.](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset/data?select=cleaned_dataset.csv) 

## 1. Dataset Overview
The dataset provides a detailed compilation of music-related information, focusing on song attributes, popularity metrics, and performance on platforms like Spotify and YouTube. This dataset contains information about 24 columns and 20,000+ rows.
## Columns
          • Track Information: artist, track, album, album_type.
          • Audio features: danceability, energy, tempo, valence, loudness, etc.
          • Platform Engagement: views, stream, most_played_on (Spotify/YouTube).
## Key Features
          • artist: Name of the artist(s) performing the track.
	  • track: Name of the song/track

## Data Inconsistencies 
      • 469 tracks had '0' views and/or streams, yet 21 of them were marked as ''most played on YouTube".
      • 468 tracks had licensed = 'false'.
      • 576 tracks have '0' streams which includes globally popular tracks such as "Enter Sandman (Remastered)" by Metallica and "The Great Gig in the Sky" by Pink Floyd, which is implausible. 

