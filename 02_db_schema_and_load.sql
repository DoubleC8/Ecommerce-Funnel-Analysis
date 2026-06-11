/* ==============================================================================
   Project: E-Commerce Funnel Analysis (Themed Apparel Drop)
   Purpose: Defines the relational database schema and enforces data integrity 
            for users and web event logs.
============================================================================== */

-- Reset environment to prevent duplicate table errors during testing
DROP TABLE IF EXISTS event_logs;
DROP TABLE IF EXISTS users; 

/* ------------------------------------------------------------------------------
   Table: users
   Description: Stores unique customer dimensions and acquisition channels.
------------------------------------------------------------------------------ */
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, 
    join_date TIMESTAMP, 
    -- Using ENUM rather than VARCHAR to enforce strict data quality and prevent typos
    device_type ENUM('Mobile', 'Desktop', 'Tablet'), 
    traffic_source ENUM('Organic', 'Paid Social', 'Direct', 'Email')
);

/* ------------------------------------------------------------------------------
   Table: event_logs
   Description: Time-series log of all user interactions within the conversion funnel.
------------------------------------------------------------------------------ */
CREATE TABLE event_logs (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT, 
    event_time TIMESTAMP, 
    -- Strict ENUM enforces the exact predefined funnel stages
    event_type ENUM('landing_page_view', 'viewed_item', 'added_to_cart', 'initiated_checkout', 'completed_purchase'), 
    product_name VARCHAR(100) NOT NULL, 
    
    -- Foreign key establishes relational integrity with the users table.
    -- ON DELETE CASCADE ensures orphaned event logs are removed if a user is deleted.
    CONSTRAINT fk_user_event
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);