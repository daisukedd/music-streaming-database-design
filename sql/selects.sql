-- 1. Buscar todas as músicas com artista e álbum
-- RN1:  Um artista pode lançar vários álbuns; 
-- RN2: Um álbum possui várias músicas.
SELECT t.title, a.name AS artist, al.title AS album
FROM track t
JOIN artist a ON t.artist_id = a.artist_id
JOIN album al ON t.album_id = al.album_id;

-- 2. Buscar músicas por gênero
-- RN3: Uma música pertence a um único gênero musical.
SELECT t.title, g.name AS genre
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Electronic';

-- 3. Playlists e músicas
-- RN5: Uma playlist contém muitas músicas; 
-- RN6: Uma música pode estar em várias playlists.
SELECT p.name AS playlist, t.title AS track, pt.position
FROM playlist p
JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
JOIN track t ON pt.track_id = t.track_id
ORDER BY p.playlist_id, pt.position;

-- 4. Top artistas mais tocados
-- RN1: Um artista pode lançar vários álbuns; 
-- RN7: O sistema registra cada música reproduzida pelo usuário.
SELECT a.name AS artist, COUNT(*) AS plays
FROM history h
JOIN track t ON h.track_id = t.track_id
JOIN artist a ON t.artist_id = a.artist_id
GROUP BY a.artist_id
ORDER BY plays DESC;

-- 5. Gênero mais ouvido
-- RN7: O sistema registra cada música reproduzida pelo usuário.
SELECT g.name, COUNT(*) AS total_plays
FROM history h
JOIN track t ON h.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.genre_id
ORDER BY total_plays DESC
LIMIT 1;

-- 6. Música mais tocada
-- RN3: Uma música pertence a um único gênero musical; 
-- RN7: O sistema registra cada música reproduzida pelo usuário.
SELECT t.title, COUNT(*) AS plays
FROM history h
JOIN track t ON h.track_id = t.track_id
GROUP BY t.track_id
ORDER BY plays DESC
LIMIT 1;

-- 7. Usuários que mais ouviram música (em minutos)
-- RN7: O sistema registra cada música reproduzida pelo usuário; 
-- RN9: O sistema deve registrar a duração que o usuário escutou de cada música, permitindo calcular quanto tempo ouviu no total. 
SELECT u.name, SUM(h.duration_listened_seconds) / 60 AS minutes_listened
FROM history h
JOIN user u ON h.user_id = u.user_id
GROUP BY u.user_id
ORDER BY minutes_listened DESC;

-- 8. Quantidade de músicas por artista
-- RN1:  Um artista pode lançar vários álbuns; 
SELECT a.name AS artist, COUNT(t.track_id) AS total_tracks
FROM artist a
LEFT JOIN track t ON a.artist_id = t.artist_id
GROUP BY a.artist_id
ORDER BY total_tracks DESC;

-- 9. Quantidade de álbuns por artista
-- RN1:  Um artista pode lançar vários álbuns; 
SELECT a.name AS artist, COUNT(al.album_id) AS total_albums
FROM artist a
LEFT JOIN album al ON a.artist_id = al.artist_id
GROUP BY a.artist_id
ORDER BY total_albums DESC;

-- 10. Duração total de um álbum
-- RN2: Um álbum possui várias músicas;
-- RN10: Cada música deve armazenar sua duração em segundos, permitindo calcular a duração total de um álbum.
SELECT al.title AS album, SUM(t.duration_seconds)/60 AS total_minutes
FROM album al
JOIN track t ON t.album_id = al.album_id
GROUP BY al.album_id
ORDER BY total_minutes DESC;

-- 11. Playlists criadas por cada usuário
-- RN4: Um usuário pode criar várias playlists.
SELECT u.name, COUNT(p.playlist_id) AS total_playlists
FROM user u
LEFT JOIN playlist p ON u.user_id = p.user_id
GROUP BY u.user_id
ORDER BY total_playlists DESC;

-- 12. Músicas que aparecem em mais playlists
-- RN5: Uma playlist contém muitas músicas;
-- RN6: Uma música pode estar em várias playlists;
SELECT t.title, COUNT(pt.playlist_id) AS playlist_count
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
GROUP BY t.track_id
ORDER BY playlist_count DESC;

-- 13. Qual usuário escuta mais um determinado gênero
-- RN3: Uma música pertence a um único gênero musical;
-- RN7: O sistema registra cada música reproduzida pelo usuário.
SELECT u.name, COUNT(*) AS total_plays
FROM history h
JOIN track t ON h.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
JOIN user u ON h.user_id = u.user_id
WHERE g.name = 'Pop' 
GROUP BY u.user_id
ORDER BY total_plays DESC;

-- 14. Listar reporduções com data e hora
-- RN7: O sistema registra cada música reproduzida pelo usuário;
-- RN8: Cada reprodução mantém data/hora e dispositivo. 
SELECT u.name AS user, t.title AS track, h.listened_at
FROM history h
JOIN user u ON h.user_id = u.user_id
JOIN track t ON h.track_id = t.track_id
ORDER BY h.listened_at DESC;

-- 15. Lista a quantidade de reproduções por disposotivo
-- RN7: O sistema registra cada música reproduzida pelo usuário;
-- RN8: Cada reprodução mantém data/hora e dispositivo.
SELECT h.device, COUNT(*) AS total_plays
FROM history h
GROUP BY h.device
ORDER BY total_plays DESC;
