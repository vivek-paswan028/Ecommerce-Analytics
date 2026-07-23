-- =====================================================
-- VIEW 1 : USER SEGMENTS
-- =====================================================

CREATE OR REPLACE VIEW vw_user_segments AS
SELECT
    user_segment,
    COUNT(*) AS total_events
FROM fact_user_behavior
GROUP BY user_segment;


-- =====================================================
-- VIEW 2 : HOURLY CONVERSION
-- =====================================================

CREATE OR REPLACE VIEW vw_hourly_conversion AS
SELECT
    hour_of_day,
    SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END) AS views,
    SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END)*100.0/
        NULLIF(SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END),0),
        2
    ) AS conversion_rate
FROM fact_user_behavior
GROUP BY hour_of_day;


-- =====================================================
-- VIEW 3 : CATEGORY PERFORMANCE
-- =====================================================

CREATE OR REPLACE VIEW vw_category_performance AS
SELECT
    category_id,

    SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END) AS views,

    SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END) AS purchases,

    ROUND(
        SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END)*100.0/
        NULLIF(
            SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS conversion_rate

FROM fact_user_behavior
GROUP BY category_id
HAVING views >= 100;


-- =====================================================
-- VIEW 4 : FUNNEL METRICS
-- =====================================================

CREATE OR REPLACE VIEW vw_funnel_metrics AS
SELECT

    SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END) AS views,

    SUM(CASE WHEN behavior_type='fav' THEN 1 ELSE 0 END) AS favorites,

    SUM(CASE WHEN behavior_type='cart' THEN 1 ELSE 0 END) AS carts,

    SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END) AS purchases,

    ROUND(
        SUM(CASE WHEN behavior_type='fav' THEN 1 ELSE 0 END)
        *100.0/
        NULLIF(SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END),0),
        2
    ) AS view_to_fav_pct,

    ROUND(
        SUM(CASE WHEN behavior_type='cart' THEN 1 ELSE 0 END)
        *100.0/
        NULLIF(SUM(CASE WHEN behavior_type='fav' THEN 1 ELSE 0 END),0),
        2
    ) AS fav_to_cart_pct,

    ROUND(
        SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END)
        *100.0/
        NULLIF(SUM(CASE WHEN behavior_type='cart' THEN 1 ELSE 0 END),0),
        2
    ) AS cart_to_buy_pct,

    ROUND(
        SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END)
        *100.0/
        NULLIF(SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END),0),
        2
    ) AS view_to_buy_pct

FROM fact_user_behavior;
SELECT *
FROM vw_funnel_metrics;
CREATE OR REPLACE VIEW vw_funnel_metrics AS
SELECT

    COUNT(DISTINCT CASE
        WHEN behavior_type='pv'
        THEN user_id
    END) AS viewers,

    COUNT(DISTINCT CASE
        WHEN behavior_type='fav'
        THEN user_id
    END) AS favoriters,

    COUNT(DISTINCT CASE
        WHEN behavior_type='cart'
        THEN user_id
    END) AS cart_users,

    COUNT(DISTINCT CASE
        WHEN behavior_type='buy'
        THEN user_id
    END) AS buyers,

    ROUND(
        COUNT(DISTINCT CASE WHEN behavior_type='fav' THEN user_id END)
        *100.0/
        COUNT(DISTINCT CASE WHEN behavior_type='pv' THEN user_id END),
        2
    ) AS view_to_fav_pct,

    ROUND(
        COUNT(DISTINCT CASE WHEN behavior_type='cart' THEN user_id END)
        *100.0/
        COUNT(DISTINCT CASE WHEN behavior_type='fav' THEN user_id END),
        2
    ) AS fav_to_cart_pct,

    ROUND(
        COUNT(DISTINCT CASE WHEN behavior_type='buy' THEN user_id END)
        *100.0/
        COUNT(DISTINCT CASE WHEN behavior_type='cart' THEN user_id END),
        2
    ) AS cart_to_buy_pct,

    ROUND(
        COUNT(DISTINCT CASE WHEN behavior_type='buy' THEN user_id END)
        *100.0/
        COUNT(DISTINCT CASE WHEN behavior_type='pv' THEN user_id END),
        2
    ) AS view_to_buy_pct

FROM fact_user_behavior;

SELECT *
FROM vw_funnel_metrics;


-- =====================================================
-- VIEW 5 : CART ABANDONMENT
-- =====================================================

CREATE OR REPLACE VIEW vw_cart_abandonment AS
SELECT
    category_id,

    COUNT(DISTINCT CASE
        WHEN behavior_type = 'cart'
        THEN user_id
    END) AS users_carted,

    COUNT(DISTINCT CASE
        WHEN behavior_type = 'buy'
        THEN user_id
    END) AS users_purchased,

    COUNT(DISTINCT CASE
        WHEN behavior_type = 'cart'
        THEN user_id
    END)
    -
    COUNT(DISTINCT CASE
        WHEN behavior_type = 'buy'
        THEN user_id
    END) AS cart_abandonments,

    ROUND(
        (
            COUNT(DISTINCT CASE WHEN behavior_type='cart' THEN user_id END)
            -
            COUNT(DISTINCT CASE WHEN behavior_type='buy' THEN user_id END)
        ) * 100.0
        /
        NULLIF(
            COUNT(DISTINCT CASE WHEN behavior_type='cart' THEN user_id END),
            0
        ),
        2
    ) AS abandonment_rate_pct

FROM fact_user_behavior
GROUP BY category_id
HAVING users_carted >= 50;

SELECT *
FROM vw_cart_abandonment
ORDER BY abandonment_rate_pct DESC
LIMIT 20;

-- =====================================================
-- VIEW 6 : LOYAL CUSTOMERS
-- =====================================================

CREATE OR REPLACE VIEW vw_loyal_customers AS
SELECT
    user_id,

    COUNT(CASE
        WHEN behavior_type='buy'
        THEN 1
    END) AS total_purchases,

    COUNT(DISTINCT category_id) AS unique_categories,

    COUNT(DISTINCT item_id) AS unique_products,

    CASE
        WHEN COUNT(CASE WHEN behavior_type='buy' THEN 1 END) >= 5
            THEN 'VIP'

        WHEN COUNT(CASE WHEN behavior_type='buy' THEN 1 END) >= 3
            THEN 'Loyal'

        WHEN COUNT(CASE WHEN behavior_type='buy' THEN 1 END) >= 2
            THEN 'Repeat'

        ELSE 'One-Time'
    END AS loyalty_tier

FROM fact_user_behavior
GROUP BY user_id
HAVING total_purchases >= 2;

SELECT *
FROM vw_loyal_customers
ORDER BY total_purchases DESC
LIMIT 20;

-- =====================================================
-- VIEW 7 : WISHLIST USERS
-- =====================================================

CREATE OR REPLACE VIEW vw_wishlist_users AS
SELECT
    user_id,

    COUNT(*) AS total_favorites,

    COUNT(DISTINCT item_id) AS unique_products,

    COUNT(DISTINCT category_id) AS unique_categories

FROM fact_user_behavior

WHERE behavior_type = 'fav'

GROUP BY user_id

HAVING user_id NOT IN
(
    SELECT DISTINCT user_id
    FROM fact_user_behavior
    WHERE behavior_type = 'buy'
);

SELECT *
FROM vw_wishlist_users
ORDER BY total_favorites DESC
LIMIT 20;


SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';


-- =====================================================
-- VIEW 8 : HIGH POTENTIAL CATEGORIES
-- =====================================================

CREATE OR REPLACE VIEW vw_highpotential_categories AS
SELECT
    category_id,

    SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END) AS views,

    SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END) AS purchases,

    ROUND(
        SUM(CASE WHEN behavior_type='buy' THEN 1 ELSE 0 END)
        *100.0/
        NULLIF(
            SUM(CASE WHEN behavior_type='pv' THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS conversion_rate

FROM fact_user_behavior

GROUP BY category_id

HAVING views >= 100;

SELECT *
FROM vw_highpotential_categories
ORDER BY conversion_rate DESC
LIMIT 10;

SELECT *
FROM vw_highpotential_categories
LIMIT 10;

-- =====================================================
-- VIEW 9 : LOYALTY CAMPAIGN CANDIDATES
-- =====================================================
-- Groups users into loyalty tiers based on
-- their purchase history.
-- Useful for retention and marketing campaigns.
-- =====================================================

CREATE OR REPLACE VIEW vw_loyalty_campaign_candidates AS

SELECT

    user_id,

    -- Total purchases made by user
    COUNT(
        CASE
            WHEN behavior_type = 'buy'
            THEN 1
        END
    ) AS total_purchases,

    -- Number of categories explored
    COUNT(DISTINCT category_id) AS categories_shopped,

    -- Number of unique products interacted with
    COUNT(DISTINCT item_id) AS products_bought,

    -- Loyalty Classification
    CASE

        WHEN COUNT(
            CASE
                WHEN behavior_type = 'buy'
                THEN 1
            END
        ) >= 10
        THEN 'VIP'

        WHEN COUNT(
            CASE
                WHEN behavior_type = 'buy'
                THEN 1
            END
        ) >= 5
        THEN 'Loyal'

        WHEN COUNT(
            CASE
                WHEN behavior_type = 'buy'
                THEN 1
            END
        ) >= 2
        THEN 'Repeat'

        WHEN COUNT(
            CASE
                WHEN behavior_type = 'buy'
                THEN 1
            END
        ) = 1
        THEN 'One-Time'

        ELSE 'No Purchase'

    END AS loyalty_tier

FROM fact_user_behavior

GROUP BY user_id;

SELECT *
FROM vw_loyalty_campaign_candidates
LIMIT 20;

SELECT
    loyalty_tier,
    COUNT(*) AS users
FROM vw_loyalty_campaign_candidates
GROUP BY loyalty_tier;

DESCRIBE fact_user_behavior;


-- =====================================================
-- VIEW 10 : RETENTION SUMMARY
-- =====================================================
-- Weekly active and purchasing users.
-- Used for retention and engagement dashboards.
-- =====================================================

CREATE OR REPLACE VIEW vw_retention_summary AS

SELECT

    week_num,

    COUNT(DISTINCT user_id) AS active_users,

    COUNT(
        DISTINCT CASE
            WHEN behavior_type = 'buy'
            THEN user_id
        END
    ) AS purchasing_users,

    ROUND(
        COUNT(
            DISTINCT CASE
                WHEN behavior_type='buy'
                THEN user_id
            END
        ) * 100.0
        /
        NULLIF(
            COUNT(DISTINCT user_id),
            0
        ),
        2
    ) AS purchase_rate_pct

FROM fact_user_behavior

GROUP BY week_num;

SELECT *
FROM vw_retention_summary;