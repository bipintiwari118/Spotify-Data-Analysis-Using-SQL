-- create table
DROP TABLE IF EXISTS spotify;
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

-- Easy Level

-- Retrieve the names of all tracks that have more than 1 billion streams.
-- List all albums along with their respective artists.
-- Get the total number of comments for tracks where licensed = TRUE.
-- Find all tracks that belong to the album type single.
-- Count the total number of tracks by each artist.


-- Medium Level

-- Calculate the average danceability of tracks in each album.
-- Find the top 5 tracks with the highest energy values.
-- List all tracks along with their views and likes where official_video = TRUE.
-- For each album, calculate the total views of all associated tracks.
-- Retrieve the track names that have been streamed on Spotify more than YouTube.

-- Advanced Level

-- Find the top 3 most-viewed tracks for each artist using window functions.
-- Write a query to find tracks where the liveness score is above the average.
-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.





1. -- Retrieve the names of all tracks that have more than 1 billion streams.

SELECT * FROM spotify WHERE stream > 1000000000;



2. -- List all albums along with their respective artists.


SELECT DISTINCT album,artist FROM spotify;


3. -- Get the total number of comments for tracks where licensed = TRUE.

SELECT SUM(comments) AS total_comments FROM spotify WHERE licensed IS TRUE;


4. -- Find all tracks that belong to the album type single.

SELECT track,album_type FROM spotify WHERE album_type='single';

-- Count the total number of tracks by each artist.
SELECT COUNT(track) AS total_number_of_track,artist FROM spotify GROUP BY artist ORDER BY 1 DESC;


5. -- Calculate the average danceability of tracks in each album.

SELECT album, AVG(danceability) as average_daceability FROM spotify GROUP BY 1 ORDER BY 2 DESC;


6. -- Find the top 5 tracks with the highest energy values.

SELECT track,energy FROM spotify ORDER BY energy DESC LIMIT 5;


7. -- List all tracks along with their views and likes where official_video = TRUE.

SELECT track,SUM(views) As total_views,SUM(likes) AS total_like FROM spotify WHERE official_video IS TRUE GROUP BY 1 ;


8. -- For each album, calculate the total views of all associated tracks.

SELECT album,track,SUM(views) FROM spotify GROUP BY 1,2;

9. -- Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT track
FROM spotify
GROUP BY track
HAVING 
SUM(CASE WHEN most_played_on = 'Spotify' THEN stream ELSE 0 END)
>
SUM(CASE WHEN most_played_on = 'YouTube' THEN stream ELSE 0 END);


10. -- Find the top 3 most-viewed tracks for each artist using window functions.

WITH ranking_artist AS (SELECT artist,track,SUM(views),RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank FROM spotify GROUP BY 1,2)
	SELECT * FROM ranking_artist WHERE rank<= 3;

B ?<???>?,
M?/////////>??>>?>?>?>?//.?<?.?><?,? F
12. -- Write a query to find tracks where the liveness score is above the average.


SELECT * FROM spotify WHERE liveness > (SELECT AVG(liveness) FROM spotify);


13. -- Use a WITH clause to -- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.///ml>>>>>?>?>.<>>
<?///calculate the difference between the highest and lowest energy values for tracks in each album.


WITH energy_t AS (SELECT album,MAX(energy) AS highest_energy,MIN(energy) AS lowest_energy FROM spotify GROUP BY 1) 
SELECT album,highest_energy,lowest_energy,(highest_energy-lowest_energy) AS energy_diff FROM energy_t ORDER BY energy_diff DESC;
