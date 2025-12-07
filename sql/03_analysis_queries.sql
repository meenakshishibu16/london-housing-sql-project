USE london_housing;


SELECT COUNT(*) AS total_listings
FROM listing;


SELECT *
FROM listing
LIMIT 20;


SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    ROUND(AVG(price), 0) AS avg_price,
    ROUND(STDDEV_SAMP(price), 0) AS stddev_price
FROM listing;


SELECT
    year,
    COUNT(*) AS num_listings
FROM listing
GROUP BY year
ORDER BY year;


SELECT
    bedrooms,
    COUNT(*) AS num_listings,
    ROUND(AVG(price), 0) AS avg_price
FROM listing
GROUP BY bedrooms
ORDER BY bedrooms;


SELECT
    li.listing_id,
    li.property_name,
    li.price,
    li.year,
    l.location_name,
    l.city_county,
    ht.type_name AS house_type
FROM listing li
JOIN location   l  ON li.location_id   = l.location_id
JOIN house_type ht ON li.house_type_id = ht.house_type_id
LIMIT 30;


SELECT
    li.property_name,
    li.price,
    li.year,
    ht.type_name AS house_type
FROM listing li
JOIN location   l  ON li.location_id   = l.location_id
JOIN house_type ht ON li.house_type_id = ht.house_type_id
WHERE l.location_name = 'Chelsea'
ORDER BY li.price DESC
LIMIT 20;


SELECT
    l.location_name AS district,
    COUNT(*) AS num_listings,
    ROUND(AVG(li.price), 0) AS avg_price
FROM listing li
JOIN location l ON li.location_id = l.location_id
GROUP BY l.location_name
HAVING COUNT(*) >= 5   
ORDER BY avg_price DESC;


SELECT
    l.location_name AS district,
    li.year,
    ROUND(AVG(li.price), 0) AS avg_price
FROM listing li
JOIN location l ON li.location_id = l.location_id
GROUP BY l.location_name, li.year
ORDER BY l.location_name, li.year;


SELECT
    l.location_name AS district,
    li.year,
    COUNT(*) AS num_listings
FROM listing li
JOIN location l ON li.location_id = l.location_id
GROUP BY l.location_name, li.year
ORDER BY l.location_name, li.year;


SELECT
    l.location_name AS district,
    ROUND(AVG(li.price), 0) AS avg_price,
    COUNT(*) AS num_listings
FROM listing li
JOIN location l ON li.location_id = l.location_id
GROUP BY l.location_name
HAVING COUNT(*) >= 10
ORDER BY avg_price DESC
LIMIT 10;


SELECT
    ht.type_name AS house_type,
    COUNT(*) AS num_listings
FROM listing li
JOIN house_type ht ON li.house_type_id = ht.house_type_id
GROUP BY ht.type_name
ORDER BY num_listings DESC;


SELECT
    ht.type_name AS house_type,
    COUNT(*) AS num_listings,
    ROUND(AVG(li.price), 0) AS avg_price
FROM listing li
JOIN house_type ht ON li.house_type_id = ht.house_type_id
GROUP BY ht.type_name
ORDER BY avg_price DESC;


SELECT
    l.location_name AS district,
    ht.type_name    AS house_type,
    COUNT(*) AS num_listings,
    ROUND(AVG(li.price), 0) AS avg_price
FROM listing li
JOIN location   l  ON li.location_id   = l.location_id
JOIN house_type ht ON li.house_type_id = ht.house_type_id
GROUP BY l.location_name, ht.type_name
HAVING COUNT(*) >= 5
ORDER BY district, avg_price DESC;


SELECT
    ht.type_name AS house_type,
    li.year,
    COUNT(*) AS num_listings,
    ROUND(AVG(li.price), 0) AS avg_price
FROM listing li
JOIN house_type ht ON li.house_type_id = ht.house_type_id
GROUP BY ht.type_name, li.year
ORDER BY ht.type_name, li.year;


SELECT
    li.listing_id,
    li.property_name,
    li.price,
    li.area_sqft,
    CASE
        WHEN li.area_sqft IS NOT NULL AND li.area_sqft > 0
        THEN ROUND(li.price * 1.0 / li.area_sqft, 2)
        ELSE NULL
    END AS price_per_sqft
FROM listing li
ORDER BY price_per_sqft DESC
LIMIT 20;


SELECT
    l.location_name AS district,
    ROUND(SUM(li.price) * 1.0 / SUM(li.area_sqft), 2) AS avg_price_per_sqft,
    COUNT(*) AS num_listings
FROM listing li
JOIN location l ON li.location_id = l.location_id
WHERE li.area_sqft IS NOT NULL AND li.area_sqft > 0
GROUP BY l.location_name
HAVING COUNT(*) >= 5
ORDER BY avg_price_per_sqft DESC;


SELECT
    ht.type_name AS house_type,
    ROUND(SUM(li.price) * 1.0 / SUM(li.area_sqft), 2) AS avg_price_per_sqft,
    COUNT(*) AS num_listings
FROM listing li
JOIN house_type ht ON li.house_type_id = ht.house_type_id
WHERE li.area_sqft IS NOT NULL AND li.area_sqft > 0
GROUP BY ht.type_name
HAVING COUNT(*) >= 5
ORDER BY avg_price_per_sqft DESC;


SELECT
    bedrooms,
    COUNT(*) AS num_listings,
    ROUND(AVG(price), 0) AS avg_price
FROM listing
GROUP BY bedrooms
ORDER BY bedrooms;


SELECT
    bathrooms,
    COUNT(*) AS num_listings,
    ROUND(AVG(price), 0) AS avg_price
FROM listing
GROUP BY bathrooms
ORDER BY bathrooms;


SELECT
    l.location_name AS district,
    li.bedrooms,
    COUNT(*) AS num_listings,
    ROUND(AVG(li.price), 0) AS avg_price
FROM listing li
JOIN location l ON li.location_id = l.location_id
GROUP BY l.location_name, li.bedrooms
HAVING COUNT(*) >= 5
ORDER BY district, bedrooms;


SELECT
    l.location_name AS district,
    li.year,
    ROUND(AVG(li.price), 0) AS avg_price
FROM listing li
JOIN location l ON li.location_id = l.location_id
GROUP BY l.location_name, li.year
ORDER BY l.location_name, li.year;


WITH district_yearly AS (
    SELECT
        l.location_id,
        l.location_name,
        li.year,
        AVG(li.price) AS avg_price
    FROM listing li
    JOIN location l ON li.location_id = l.location_id
    GROUP BY l.location_id, l.location_name, li.year
)
SELECT
    location_name,
    year,
    avg_price,
    LAG(avg_price) OVER (
        PARTITION BY location_id
        ORDER BY year
    ) AS prev_year_avg,
    ROUND(
        (avg_price - LAG(avg_price) OVER (PARTITION BY location_id ORDER BY year))
        / LAG(avg_price) OVER (PARTITION BY location_id ORDER BY year)
        * 100, 2
    ) AS yoy_growth_percent
FROM district_yearly
ORDER BY location_name, year;


WITH district_yearly AS (
    SELECT
        l.location_id,
        l.location_name,
        li.year,
        AVG(li.price) AS avg_price
    FROM listing li
    JOIN location l ON li.location_id = l.location_id
    GROUP BY l.location_id, l.location_name, li.year
),
start_end AS (
    SELECT
        location_id,
        location_name,
        MAX(CASE WHEN year = 2016 THEN avg_price END) AS avg_2016,
        MAX(CASE WHEN year = 2020 THEN avg_price END) AS avg_2020
    FROM district_yearly
    GROUP BY location_id, location_name
)
SELECT
    location_name AS district,
    ROUND(avg_2016, 0) AS avg_price_2016,
    ROUND(avg_2020, 0) AS avg_price_2020,
    ROUND((avg_2020 - avg_2016) / avg_2016 * 100, 2) AS growth_percent
FROM start_end
WHERE avg_2016 IS NOT NULL
  AND avg_2020 IS NOT NULL
ORDER BY growth_percent DESC
LIMIT 5;


WITH ranked_listings AS (
    SELECT
        li.listing_id,
        li.property_name,
        li.price,
        li.year,
        l.location_name AS district,
        ROW_NUMBER() OVER (
            PARTITION BY l.location_id
            ORDER BY li.price DESC
        ) AS price_rank
    FROM listing li
    JOIN location l ON li.location_id = l.location_id
)
SELECT
    district,
    listing_id,
    property_name,
    price,
    year,
    price_rank
FROM ranked_listings
WHERE price_rank <= 3
ORDER BY district, price_rank;


WITH district_avg AS (
    SELECT
        l.location_id,
        l.location_name AS district,
        AVG(li.price) AS avg_price
    FROM listing li
    JOIN location l ON li.location_id = l.location_id
    GROUP BY l.location_id, l.location_name
)
SELECT
    district,
    ROUND(avg_price, 0) AS avg_price,
    RANK() OVER (ORDER BY avg_price DESC) AS price_rank
FROM district_avg
ORDER BY price_rank;


WITH priced AS (
    SELECT
        li.listing_id,
        li.property_name,
        li.price,
        l.location_name AS district,
        NTILE(20) OVER (ORDER BY li.price) AS price_tile
    FROM listing li
    JOIN location l ON li.location_id = l.location_id
)
SELECT
    listing_id,
    property_name,
    district,
    price,
    price_tile
FROM priced
WHERE price_tile = 20   -- top 1/20th ~ top 5%
ORDER BY price DESC
LIMIT 50;


CREATE OR REPLACE VIEW v_district_yearly_avg AS
SELECT
    l.location_id,
    l.location_name AS district,
    li.year,
    AVG(li.price) AS avg_price
FROM listing li
JOIN location l ON li.location_id = l.location_id
GROUP BY l.location_id, l.location_name, li.year;


SELECT *
FROM v_district_yearly_avg
ORDER BY district, year;


CREATE OR REPLACE VIEW v_district_5yr_growth AS
WITH start_end AS (
    SELECT
        location_id,
        district,
        MAX(CASE WHEN year = 2016 THEN avg_price END) AS avg_2016,
        MAX(CASE WHEN year = 2020 THEN avg_price END) AS avg_2020
    FROM v_district_yearly_avg
    GROUP BY location_id, district
)
SELECT
    district,
    avg_2016,
    avg_2020,
    ROUND((avg_2020 - avg_2016) / avg_2016 * 100, 2) AS growth_percent
FROM start_end
WHERE avg_2016 IS NOT NULL
  AND avg_2020 IS NOT NULL;


SELECT
    district,
    ROUND(avg_2016, 0) AS avg_price_2016,
    ROUND(avg_2020, 0) AS avg_price_2020,
    growth_percent
FROM v_district_5yr_growth
ORDER BY growth_percent DESC
LIMIT 5;
