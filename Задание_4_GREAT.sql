CREATE TABLE IF NOT EXISTS Executor (
id SERIAL PRIMARY KEY,
name VARCHAR(70) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Genre (
id SERIAL PRIMARY KEY,
name VARCHAR(25) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Album (
id SERIAL PRIMARY KEY,
name VARCHAR(50) UNIQUE NOT NULL,
year_of_issue INTEGER
);

CREATE TABLE IF NOT EXISTS Compilation (
id SERIAL PRIMARY KEY,
name VARCHAR(55) UNIQUE NOT NULL,
year INTEGER
);

CREATE TABLE IF NOT EXISTS Track (
id SERIAL PRIMARY KEY,
name VARCHAR(85) UNIQUE NOT NULL,
duration INTEGER,
album_id INTEGER REFERENCES Album(id)
);

CREATE TABLE IF NOT EXISTS GenreExecutor (
executor_id INTEGER REFERENCES Executor(id),
genre_id INTEGER REFERENCES Genre(id),
CONSTRAINT pk PRIMARY KEY (executor_id, genre_id)
);

CREATE TABLE IF NOT EXISTS ExecutorAlbum (
executor_id INTEGER REFERENCES Executor(id),
album_id INTEGER REFERENCES Album(id),
CONSTRAINT pk2 PRIMARY KEY (executor_id, album_id)
);

CREATE TABLE IF NOT EXISTS CompilationTrack (
compilation_id INTEGER references Compilation(id),
track_id INTEGER references Track(id),
CONSTRAINT pk3 PRIMARY KEY (compilation_id, track_id)
);









