# E-Commerce Conversion Funnel Analysis: Themed Apparel Drop

![Tableau Dashboard](https://public.tableau.com/app/profile/chris.cortes2425/viz/E-CommerceConversionFunnelAnalysis_17811379985940/Dashboard1)

## Project Overview

This project maps and analyzes the e-commerce conversion funnel for a modern streetwear brand that recently launched an anime-inspired apparel collection. The primary objective is to identify specific bottlenecks in the user journey—from the initial landing page view to the completed purchase—and provide data-driven recommendations to the product and marketing teams to optimize the conversion rate.

## Tech Stack & Skills Demonstrated

- **Python (Pandas, Faker):** Synthetic data generation, chronological event sequencing, and drop-off simulation.
- **SQL (MySQL):** Relational database design (DDL), Common Table Expressions (CTEs), Window Functions (`LAG()`), multi-table `JOIN`s, and advanced data aggregations.
- **Tableau:** Data visualization, calculated table calculations (`LOOKUP`), dual-axis charts, and visual storytelling applying the McCandless Method.

## Executive Summary & Actionable Insights

After extracting and analyzing the event logs of 10,000 unique website visitors during the 30-day launch window, the following insights were uncovered:

- **Overall Conversion Rate:** The campaign yielded a **4.28%** overall conversion rate (428 purchases / 10,000 landing page visitors).
- **The Primary Bottleneck:** The most significant point of friction occurs early in the funnel. Only **31.15%** of users who view an item proceed to add it to their cart.
- **Device-Agnostic Friction:** Device segmentation via highlight tables reveals that this cart-addition bottleneck is consistent across all platforms: Desktop (31.1%), Mobile (31.5%), and Tablet (30.8%).
- **Business Recommendation:** Because the drop-off is uniform across devices, it is highly unlikely to be a platform-specific UI/UX glitch (e.g., a broken "Add to Cart" button on mobile). The marketing and product teams should investigate non-technical friction points on the product pages, such as:
  - "Sticker shock" or unexpected shipping costs displayed early.
  - Inventory stock-outs for popular sizes.
  - Lack of compelling product imagery or sizing charts.

## Repository Structure

- `data_generation.ipynb`: The Python script used to define the user parameters, simulate the sequential traffic, and export the raw CSV datasets.
- `schema_setup.sql`: The Data Definition Language (DDL) queries establishing the strict relational database structure, utilizing `TIMESTAMP`, `ENUM` constraints, and cascading foreign keys.
- `funnel_analysis.sql`: The core analytical queries utilizing CTEs and `LAG()` window functions to calculate absolute drop-off volume and stage-to-stage conversion rates.
- `users.csv` & `event_logs.csv`: The generated datasets. _(Note: Typically excluded via .gitignore in production, included here for reproducibility)._
