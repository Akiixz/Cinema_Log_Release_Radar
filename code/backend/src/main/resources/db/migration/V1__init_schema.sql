-- Initial database schema for Cinema Log & Release Radar

-- =========================
-- 1. USERS
-- =========================
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- =========================
-- 2. USER PROFILES
-- =========================
CREATE TABLE user_profiles (
    id BIGSERIAL PRIMARY KEY,
    bio TEXT,
    avatar_url VARCHAR(500),
    preferred_channel VARCHAR(50),
    user_id BIGINT NOT NULL UNIQUE,
    CONSTRAINT fk_user_profiles_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =========================
-- 3. MOVIES
-- =========================
CREATE TABLE movies (
    id BIGSERIAL PRIMARY KEY,
    tmdb_id BIGINT NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    overview TEXT,
    poster_url VARCHAR(500),
    release_date DATE
);

-- =========================
-- 4. GENRES
-- =========================
CREATE TABLE genres (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- =========================
-- 5. MOVIE <-> GENRE
-- =========================
CREATE TABLE movie_genres (
    movie_id BIGINT NOT NULL,
    genre_id BIGINT NOT NULL,
    PRIMARY KEY (movie_id, genre_id),
    CONSTRAINT fk_movie_genres_movie FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    CONSTRAINT fk_movie_genres_genre FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- =========================
-- 6. WATCH LOGS
-- =========================
CREATE TABLE watch_logs (
    id BIGSERIAL PRIMARY KEY,
    watched_date DATE,
    rating INTEGER,
    note TEXT,
    user_id BIGINT NOT NULL,
    movie_id BIGINT NOT NULL,
    CONSTRAINT chk_watch_logs_rating CHECK (
        rating BETWEEN 1
        AND 10
    ),
    CONSTRAINT fk_watch_logs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_watch_logs_movie FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- =========================
-- 7. REVIEWS
-- =========================
CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    content TEXT,
    score INTEGER,
    created_at TIMESTAMP,
    movie_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    CONSTRAINT fk_reviews_movie FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =========================
-- 8. RELEASE ALERTS
-- =========================
CREATE TABLE release_alerts (
    id BIGSERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP,
    user_id BIGINT NOT NULL,
    movie_id BIGINT NOT NULL,
    CONSTRAINT fk_release_alerts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_release_alerts_movie FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- =========================
-- 9. NOTIFICATIONS
-- =========================
CREATE TABLE notifications (
    id BIGSERIAL PRIMARY KEY,
    channel VARCHAR(50) NOT NULL,
    sent_at TIMESTAMP,
    success BOOLEAN,
    release_alert_id BIGINT NOT NULL,
    CONSTRAINT fk_notifications_release_alert FOREIGN KEY (release_alert_id) REFERENCES release_alerts(id) ON DELETE CASCADE
);