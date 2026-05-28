# 🎵 Spotify Data Analysis Using SQL

## 📌 Project Overview

This project focuses on analyzing Spotify music data using SQL.
The goal is to practice real-world SQL queries commonly used in Data Analyst and Business Intelligence roles.

The dataset contains information about:

* Artists
* Tracks
* Albums
* Audio Features
* Views & Streams
* Likes & Comments
* Platform Performance (Spotify vs YouTube)

This project demonstrates SQL skills ranging from beginner to advanced concepts including:

* Filtering
* Aggregation
* Grouping
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions

---

# 🛠️ Technologies Used

* SQL
* PostgreSQL / MySQL / SQLite
* GitHub

---

# 📂 Dataset Information

The dataset includes the following columns:

| Column Name      | Description                 |
| ---------------- | --------------------------- |
| artist           | Artist name                 |
| track            | Song/Track name             |
| album            | Album name                  |
| album_type       | Album category              |
| danceability     | Danceability score          |
| energy           | Energy score                |
| loudness         | Loudness level              |
| speechiness      | Speech score                |
| acousticness     | Acoustic score              |
| instrumentalness | Instrumental score          |
| liveness         | Liveness score              |
| valence          | Positivity score            |
| tempo            | BPM of track                |
| duration_min     | Track duration              |
| views            | YouTube views               |
| likes            | Total likes                 |
| comments         | Total comments              |
| stream           | Spotify streams             |
| official_video   | Official video availability |
| most_played_on   | Platform where most played  |

---

# 🧱 Database Schema

```sql
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
```

---

# 📊 SQL Analysis Performed

## 🟢 Easy Level Queries

### 1. Tracks with More Than 1 Billion Streams

```sql
SELECT * 
FROM spotify 
WHERE stream > 1000000000;
```

### 2. List All Albums with Artists

```sql
SELECT DISTINCT album, artist 
FROM spotify;
```

### 3. Total Comments for Licensed Tracks

```sql
SELECT SUM(comments) AS total_comments
FROM spotify
WHERE licensed IS TRUE;
```

### 4. Tracks Belonging to Single Albums

```sql
SELECT track, album_type
FROM spotify
WHERE album_type = 'single';
```

### 5. Count Total Tracks by Artist

```sql
SELECT COUNT(track) AS total_number_of_track,
       artist
FROM spotify
GROUP BY artist
ORDER BY 1 DESC;
```

---

# 🟡 Medium Level Queries

### 6. Average Danceability Per Album

```sql
SELECT album,
       AVG(danceability) AS average_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;
```

### 7. Top 5 Tracks with Highest Energy

```sql
SELECT track, energy
FROM spotify
ORDER BY energy DESC
LIMIT 5;
```

### 8. Official Videos with Views and Likes

```sql
SELECT track,
       SUM(views) AS total_views,
       SUM(likes) AS total_likes
FROM spotify
WHERE official_video IS TRUE
GROUP BY 1;
```

### 9. Total Views Per Album

```sql
SELECT album,
       track,
       SUM(views)
FROM spotify
GROUP BY 1,2;
```

### 10. Tracks Streamed More on Spotify Than YouTube

```sql
SELECT track
FROM spotify
GROUP BY track
HAVING 
SUM(CASE WHEN most_played_on = 'Spotify'
         THEN stream ELSE 0 END)
>
SUM(CASE WHEN most_played_on = 'YouTube'
         THEN stream ELSE 0 END);
```

---

# 🔴 Advanced Level Queries

### 11. Top 3 Most Viewed Tracks Per Artist

```sql
WITH ranking_artist AS (
    SELECT artist,
           track,
           SUM(views),
           RANK() OVER(
               PARTITION BY artist
               ORDER BY SUM(views) DESC
           ) AS rank
    FROM spotify
    GROUP BY 1,2
)

SELECT *
FROM ranking_artist
WHERE rank <= 3;
```

### 12. Tracks with Above Average Liveness

```sql
SELECT *
FROM spotify
WHERE liveness > (
    SELECT AVG(liveness)
    FROM spotify
);
```

### 13. Difference Between Highest & Lowest Energy by Album

```sql
WITH energy_t AS (
    SELECT album,
           MAX(energy) AS highest_energy,
           MIN(energy) AS lowest_energy
    FROM spotify
    GROUP BY 1
)

SELECT album,
       highest_energy,
       lowest_energy,
       (highest_energy - lowest_energy) AS energy_diff
FROM energy_t
ORDER BY energy_diff DESC;
```

---

# 📈 Key Insights

* Identified highly streamed tracks exceeding 1 billion plays.
* Compared Spotify vs YouTube streaming performance.
* Analyzed artist popularity using views and engagement metrics.
* Used window functions to rank top-performing tracks.
* Applied aggregation techniques for album-level analysis.

---

# 🚀 Skills Demonstrated

✅ SQL Query Writing
✅ Data Cleaning
✅ Aggregation Functions
✅ GROUP BY & HAVING
✅ Subqueries
✅ CTEs
✅ Window Functions
✅ Analytical Thinking
✅ Business Insight Generation



# ⭐ If You Like This Project

Give this repository a ⭐ and share it with others!

---
