CREATE TABLE music_albums (
  id SERIAL PRIMARY KEY,
  genre VARCHAR(255),
  author VARCHAR(255),
  source VARCHAR(255),
  label VARCHAR(255),
  publish_date INT,
  archived BOOLEAN,
  title VARCHAR(255),
  artist VARCHAR(255),
  on_spotify BOOLEAN
);

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);