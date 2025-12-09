# SPOTIFY CLEANING DATA ANALYSIS PROJECT - SQL

## Table of Contents
• [Introduction](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#introduction)

• [Dataset Overview](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#dataset-overview)

• [Problem Statement](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#problem-statement)

• [Data Quality Issues](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#data-quality-issues)

• [Data Cleaning Process](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#data-cleaning-process)

• [Results and Observations](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#results-and-observations)

• [Potential Use Cases](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#potential-use-cases)

• [Issues Resolved (Issue Tracking Table)](https://github.com/KeerthiReddyBojja/Spotify_data_analysis---SQL-Project/edit/main/README.md#issue-tracking-table)

## Introduction
This project analyzes a Spotify dataset containing information about tracks, artists, albums and audio features. The focus is on generating insights about platform-specific engagement, song durations, and artist popularity, while also addressing data inconsistencies. The analysis was conducted using PostgreSQL in pgAdmin. 
The dataset was sourced from [Kaggle.](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset/data?select=cleaned_dataset.csv) 

## Dataset Overview
The dataset provides a detailed compilation of music-related information, focusing on song attributes, popularity metrics, and performance on platforms like Spotify and YouTube. This dataset contains information about 24 columns and 20,000+ rows.
## Columns
    • Track Information: artist, track, album, album_type.
    • Audio features: danceability, energy, tempo, valence, loudness, etc.
    • Platform Engagement: views, stream, most_played_on (Spotify/YouTube).
## Key Features
    • artist: Name of the artist(s) performing the track.
    • track: Name of the song/track.
    • album: Name of the album the track belongs to.
    • album_type: Type of album (e.g., single, album).
    • danceability: A value indicating how suitable the track is for dancing, based on tempo, rhythm stability, and 
                                overall beat strength.
    • energy: A measure of the song’s intensity and activity.
    • loudness: Overall loudness of the track, measured in decibels (dB).
    • speechiness: Measure of the presence of spoken words in a track.
    • acousticness: A score indicating the likelihood of the track being acoustic.
    • instrumentalness: Predicts the absence of vocals (higher values indicate less vocal presence).
    • liveness: Indicates the probability of the track being a live recording.
    • valence: Describes the musical positiveness conveyed by the track.
    • tempo: Beats per minute (BPM) of the track.
    • duration_min: Duration of the track in minutes.
    • title: Title of the song.
    • channel: YouTube channel associated with the track.
    • views: Total number of views the track received on YouTube.
    • likes: Total number of likes on YouTube.
    • comments: Total number of comments on YouTube.
    • licensed: Indicates whether the track is licensed for YouTube.
    • official_video: Boolean value indicating whether the track has an official music video.
    • stream: Total number of streams on Spotify.
    • energy_liveness: A combined metric of energy and liveness.
    • most_played_on: Indicates the platform where the track is most popular (e.g., Spotify, YouTube).

## Problem Statement
With vast amounts of music data on platforms like Spotify, extracting meaningful insights is both crucial and challenging. This project addresses these challenges by cleaning, organizing, and analyzing Spotify's dataset to uncover trends, detect anomalies, and flag inconsistencies. Through SQL queries, it identifies key metrics such as the most popular tracks, artists, and albums based on views and streams, while performing statistical analyses.

## Data Quality Issues
1. **Tracks with Zero Views or Streams:** 1024 tracks have either zero views or streams recorded, with some having both metrics missing, raising concerns about data accuracy.
2. **Platform Discrepancies:** Out of these, 576 tracks were most played on YouTube and 449 on Spotify, suggesting incomplete or consistent recording of views and streams.
3. **No Data:** 21 tracks had both views and streams equal to zero, alongside missing metrics like title, comments, and likes.
4. **Incomplete data:** Certain tracks lack critical information such as audio features, or comments.
5. Popular artists with significant audiences also appear in the zero-views or zero-streams category, contradicting expected data trends.

## Data Cleaning Process
**Identified Issues**
1. Zero Engagement: 1024 tracks have either views or streams as '0'. Of these:

   • 470 tracks had views = 0

   • 576 tracks had views = 0

   • 21 tracks had views and streams = 0.
3. Fan-Made Content: Tracks uploaded by non-artist accounts or channels.
4. Collaboration Content: OSTs and group songs associated with channels not matching the artist.
5. Data Gaps: Missing fields like title, comments, and likes in specific records.

**Cleaning Steps**
1. Handled Zero Values:

   • Replaced '0' in views and streams with 'NULL' to signify missing data.

   • Flagged records with views and streams = 'NULL'  for investigation.
3. Analyzed official_video and Channel discrepancies:

   • Identified tracks with official_video = 'false' and mismatched artist and channel.

   • Flagged records that appeared to be fan-made or unofficial content, ensuring transparency and accuracy in the dataset.
5. Add Investigation flag:
      Introduced flagged_for_investigation to tag records for further inspection.

   • Flagged for Investigation 1 - Tracks with both views and streams = NULL.

   • Flagged for Investigation 2 - Tracks with stream = NULL, official_video = false, and artist not matching channel.

   • Flagged for Investigation 3 - Tracks with views = NULL, official_video = false.
7. Addressed Platform-Specific trends:

   • Validated most_played_on with associated metrics (views and streams).

## Assumptions and Challenges
1. Channels using artist names but not owned by them were flagged.
2. Verified content types like lyric videos, and soundtracks.
3. Tracks with engagement only on one platform were assumed to be exclusive releases.

## Results and Observations
1. Flagged 21 records - tracks with no engagement on both platforms.
2. Fan-Made Content - 160 records uploaded by non-artist channels.
3. Validated and retained records  like OSTs, collaborations.
4. 469 records with views = NULL and most_played_on = Spotify flagged for exclusivity.
5. Cleaned and prepared dataset for analysis.

## Potential Use Cases
1. Platform Comparisons: Analyze track performance on Spotify versus YouTube.
2. Artist Popularity: Examine which artists perform best across platforms.
3. Song Attributes Analysis: Study how features like danceability or acousticness impact popularity.
4. Data Cleaning Projects: Identify and resolve inconsistencies in the dataset.
5. Trend Analysis: Observe how musical trends evolve over time.

## Issue Tracking Table

| ISSUE ID | ISSUE DESCRIPTION                    | RESOLVED YES/NO | RESOLUTION NOTES                           |
|----------|-------------------------------------|----------------|-------------------------------------------------------|
| 1        | Zero views or streams               | Yes              | Replaced '0' with NULL for missing data               |
| 2        | Fan-made content                    | Yes              | Flagged records where stream = NULL, official_video = false, and artist does not match channel.       |
| 3        | Missing audio features             | Yes              | Investigated and flagged incomplete records            |
| 4        | Invalid duration values             | Yes              | Removed records with duration = 0                     |
| 5        | Platform discrepancies             | Yes              | Validated 'most_played_on' with associated metrics    |

