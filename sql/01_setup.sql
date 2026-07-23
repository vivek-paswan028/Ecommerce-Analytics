CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;

CREATE TABLE fact_user_behavior (
    user_id INT,
    item_id INT,
    category_id INT,
    behavior_type VARCHAR(20),
    timestamp BIGINT,
    datetime DATETIME,
    date DATE,
    hour INT,
    day INT,
    hour_of_day INT,
    day_of_week VARCHAR(20),
    is_weekend BOOLEAN,
    minute INT,
    week_num INT,
    hour_segment VARCHAR(20),
    prev_action VARCHAR(20),
    next_action VARCHAR(20),
    action_sequence TEXT,
    time_diff DOUBLE,
    new_session BOOLEAN,
    session_id VARCHAR(100),
    user_segment VARCHAR(50),
    session_num INT,
    converted BOOLEAN
);