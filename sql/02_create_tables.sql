CREATE TABLE `artist` (
    `artist_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255),
    `country` VARCHAR(255),
    `debut_year` INTEGER,
    `bio` TEXT
);

CREATE TABLE `album` (
  `album_id` integer PRIMARY KEY AUTO_INCREMENT,
  `artist_id` integer NOT NULL,
  `title` varchar(255),
  `release_year` integer,
  `label` varchar(255)
);

CREATE TABLE `genre` (
  `genre_id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `description` text
);

CREATE TABLE `track` (
  `track_id` integer PRIMARY KEY AUTO_INCREMENT,
  `album_id` integer,
  `artist_id` integer,
  `genre_id` integer NOT NULL,
  `title` varchar(255),
  `duration_seconds` integer,
  `release_date` date
);

CREATE TABLE `user` (
  `user_id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `email` varchar(255) UNIQUE,
  `password_hash` varchar(255),
  `created_at` timestamp
);

CREATE TABLE `playlist` (
  `playlist_id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer NOT NULL,
  `name` varchar(255),
  `description` text,
  `created_at` timestamp
);

CREATE TABLE `playlist_track` (
  `playlist_id` integer NOT NULL,
  `track_id` integer NOT NULL,
  `position` integer,
  `added_at` timestamp,
  PRIMARY KEY (`playlist_id`, `track_id`)
);

CREATE TABLE `history` (
  `history_id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer NOT NULL,
  `track_id` integer NOT NULL,
  `listened_at` timestamp,
  `device` varchar(255),
  `duration_listened_seconds` integer
);

ALTER TABLE `album` ADD CONSTRAINT `artist_album` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`);
ALTER TABLE `track` ADD CONSTRAINT `album_track` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`);
ALTER TABLE `track` ADD CONSTRAINT `track_genre` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`);
ALTER TABLE `track` ADD CONSTRAINT `track_artist` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`);
ALTER TABLE `playlist` ADD CONSTRAINT `playlist_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
ALTER TABLE `playlist_track` ADD CONSTRAINT `playlisttrack_playlist` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`playlist_id`);
ALTER TABLE `playlist_track` ADD CONSTRAINT `playlisttrack_track` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`);
ALTER TABLE `history` ADD CONSTRAINT `history_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
ALTER TABLE `history` ADD CONSTRAINT `history_track` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`);
