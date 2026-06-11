/* ==============================================================================
   Project: E-Commerce Funnel Analysis (Themed Apparel Drop)
   Purpose: Extracts absolute funnel counts, calculates stage-to-stage conversion 
            rates using window functions, and segments performance by device.
============================================================================== */

/* ------------------------------------------------------------------------------
   Query 1: Stage-to-Stage Conversion Rate (Drop-off Analysis)
   Description: Utilizes a Common Table Expression (CTE) and the LAG() window 
                function to calculate the percentage of users who successfully 
                transition from one funnel stage to the next.
------------------------------------------------------------------------------ */
WITH funnel_counts AS (
    SELECT
        event_type, 
        -- COUNT(DISTINCT) prevents overcounting if a user triggers the same event multiple times
        COUNT(DISTINCT user_id) AS num_users
    FROM 
        analysis_projects.events
    GROUP BY 
        event_type
    ORDER BY 
        -- Explicit CASE statement guarantees chronological funnel ordering regardless of volume
        CASE
            WHEN event_type = 'landing_page_view' THEN 1
            WHEN event_type = 'viewed_item' THEN 2
            WHEN event_type = 'added_to_cart' THEN 3
            WHEN event_type = 'initiated_checkout' THEN 4
            WHEN event_type = 'completed_purchase' THEN 5
        END
)

SELECT
    event_type, 
    num_users, 
    -- Calculates conversion rate by dividing current stage volume by the previous stage's volume
    ROUND(
        num_users / LAG(num_users, 1) OVER(
            ORDER BY 
                CASE
                    WHEN event_type = 'landing_page_view' THEN 1
                    WHEN event_type = 'viewed_item' THEN 2
                    WHEN event_type = 'added_to_cart' THEN 3
                    WHEN event_type = 'initiated_checkout' THEN 4
                    WHEN event_type = 'completed_purchase' THEN 5
                END
        ) * 100, 2
    ) AS drop_off
FROM 
    funnel_counts;
    
/* ------------------------------------------------------------------------------
   Query 2: Funnel Segmentation by Device Type
   Description: Joins user demographics with event logs to identify potential 
                platform-specific bottlenecks in the conversion funnel.
------------------------------------------------------------------------------ */
SELECT 
    u.device_type,
    e.event_type, 
    COUNT(DISTINCT u.user_id) AS num_of_users_per_type
FROM 
    analysis_projects.users AS u
JOIN 
    analysis_projects.events AS e 
    ON u.user_id = e.user_id
GROUP BY 
    u.device_type, 
    e.event_type
ORDER BY
    u.device_type,
    -- Explicit CASE statement guarantees chronological funnel ordering within each device group
    CASE
        WHEN e.event_type = 'landing_page_view' THEN 1
        WHEN e.event_type = 'viewed_item' THEN 2
        WHEN e.event_type = 'added_to_cart' THEN 3
        WHEN e.event_type = 'initiated_checkout' THEN 4
        WHEN e.event_type = 'completed_purchase' THEN 5
    END;
	

