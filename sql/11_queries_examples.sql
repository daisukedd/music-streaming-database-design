-- 1. Buscar todas as músicas com artista e álbum
SELECT t.title, a.name AS artist, al.title AS album
FROM track t
JOIN artist a ON t.artist_id = a.artist_id
JOIN album al ON t.album_id = al.album_id;

-- 2. Buscar músicas por gênero
SELECT t.title, g.name AS genre
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Electronic';

-- 3. Playlists e músicas
SELECT p.name AS playlist, t.title AS track, pt.position
FROM playlist p
JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
JOIN track t ON pt.track_id = t.track_id
ORDER BY p.playlist_id, pt.position;

-- 4. Top artistas mais tocados
SELECT a.name AS artist, COUNT(*) AS plays
FROM history h
JOIN track t ON h.track_id = t.track_id
JOIN artist a ON t.artist_id = a.artist_id
GROUP BY a.artist_id
ORDER BY plays DESC;

-- 5. Gênero mais ouvido
SELECT g.name, COUNT(*) AS total_plays
FROM history h
JOIN track t ON h.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.genre_id
ORDER BY total_plays DESC
LIMIT 1;

-- 6. Música mais tocada
SELECT t.title, COUNT(*) AS plays
FROM history h
JOIN track t ON h.track_id = t.track_id
GROUP BY t.track_id
ORDER BY plays DESC
LIMIT 1;

-- 7. Usuários que mais ouviram música (em minutos)
SELECT u.name, SUM(h.duration_listened_seconds) / 60 AS minutes_listened
FROM history h
JOIN user u ON h.user_id = u.user_id
GROUP BY u.user_id
ORDER BY minutes_listened DESC;
