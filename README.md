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

## Potential Use Cases
1. Platform Comparisons: Analyze track performance on Spotify versus YouTube.
2. Artist Popularity: Examine which artists perform best across platforms.
3. Song Attributes Analysis: Study how features like danceability or acousticness impact popularity.
4. Data Cleaning Projects: Identify and resolve inconsistencies in the dataset.
5. Trend Analysis: Observe how musical trends evolve over time.

## Data Quality Issues
1. **Duplicate Records:** Analysis revealed 81 duplicate records in the dataset. 
2. **Tracks with Zero Views or Streams:** 1024 tracks have either zero views or streams recorded, with some having both metrics missing, raising concerns about data accuracy.
3. **Platform Discrepancies:** Out of these, 576 tracks were most played on YouTube and 449 on Spotify, suggesting incomplete or consistent recording of views and streams.
4. **No Data:** 21 tracks had both views and streams equal to zero, alongside missing metrics like title, comments, and likes.
5. **Incomplete data:** Certain tracks lack critical information such as audio features, or comments.
5. Popular artists with significant audiences also appear in the zero-views or zero-streams category, contradicting expected data trends. 

## Data Cleaning Framework
1. Cross-validate zero values for views and streams for tracks using external sources.
2. Exclude or flag tracks with both views and streams equal to zero.

## Data Cleaning Process
1. 
1. Queried tracks with zero views or streams or both to identify the extent of inconsistencies.
2. Replaced zero values with NULL to better reflect missing data.
3. Flagged records with views and streams as NULL for further investigation.
4. Compared track attributes with external data sources to validate anomalies.

## Observations and Patterns in Data Quality Issues
1. **Tracks with Zero views by Artist:** There are 168 tracks with zero views on YouTube. Several artists were found to have tracks with zero views on YouTube.
        • Jesse & Joy - 10 tracks
        • Zé Neto & Cristiano - 10 tracks, and more
    This issue also extends to globally recognized artists:
        • Simon & Garfunkel - 10 tracks
        • Selena Gomez & The Scene - 10 tracks
    **Pattern Observed:**
        • Many of the songs of artists are duets.
