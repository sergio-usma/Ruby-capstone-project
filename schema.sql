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

CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255)
  last_name VARCHAR(255)
);

CREATE TABLE Movies (
    item_id INT PRIMARY KEY,
    director VARCHAR(255),
    release_date DATE,
    silent BOOLEAN,
    FOREIGN KEY (item_id) REFERENCES Item(id)
);

CREATE TABLE Games (
    title VARCHAR(255),
    item_id INT PRIMARY KEY,
    publish_date DATE,
    multiplayer BOOLEAN,
    last_played_at DATE,
    FOREIGN KEY (item_id) REFERENCES Item(id)
);


CREATE TABLE Sources (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    url VARCHAR(255),
    item_id INT,
    FOREIGN KEY (item_id) REFERENCES Item(id)
);


ALTER TABLE Item
ADD COLUMN director VARCHAR(255),
ADD COLUMN release_date DATE,
ADD COLUMN silent BOOLEAN;


ALTER TABLE Item
ADD FOREIGN KEY (director) REFERENCES Movies(director),
ADD FOREIGN KEY (release_date) REFERENCES Movies(release_date),
ADD FOREIGN KEY (silent) REFERENCES Movies(silent);
