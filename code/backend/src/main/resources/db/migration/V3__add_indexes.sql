-- Add indexes to improve database query performance

-- =========================
-- MOVIE GENRES
-- =========================

CREATE INDEX idx_movie_genres_genre_id
ON movie_genres (genre_id);

-- =========================
-- WATCH LOGS
-- =========================

CREATE INDEX idx_watch_logs_user_id
ON watch_logs (user_id);

CREATE INDEX idx_watch_logs_movie_id
ON watch_logs (movie_id);

-- =========================
-- REVIEWS
-- =========================

CREATE INDEX idx_reviews_movie_id
ON reviews (movie_id);

CREATE INDEX idx_reviews_user_id
ON reviews (user_id);

-- =========================
-- RELEASE ALERTS
-- =========================

CREATE INDEX idx_release_alerts_user_id
ON release_alerts (user_id);

CREATE INDEX idx_release_alerts_movie_id
ON release_alerts (movie_id);

CREATE INDEX idx_release_alerts_status
ON release_alerts (status);

-- =========================
-- MOVIES
-- =========================

CREATE INDEX idx_movies_release_date
ON movies (release_date);

-- =========================
-- NOTIFICATIONS
-- =========================

CREATE INDEX idx_notifications_release_alert_id
ON notifications (release_alert_id);