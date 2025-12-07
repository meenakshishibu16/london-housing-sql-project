INSERT INTO house_type (type_name)
SELECT DISTINCT `House Type`
FROM london_raw
WHERE `House Type` IS NOT NULL;

INSERT INTO location (location_name, city_county)
SELECT DISTINCT `Location`, `City/County`
FROM london_raw
WHERE `Location` IS NOT NULL;

INSERT INTO listing (
    raw_id,
    property_name,
    location_id,
    house_type_id,
    area_sqft,
    bedrooms,
    bathrooms,
    receptions,
    price,
    postal_code,
    year
)
SELECT
    r.`Unnamed: 0`,
    r.`Property Name`,
    l.location_id,
    ht.house_type_id,
    r.`Area in sq ft`,
    r.`No. of Bedrooms`,
    r.`No. of Bathrooms`,
    r.`No. of Reception`,
    r.`Price`,
    r.`Postal Code`,
    r.`Year`
FROM london_raw r
JOIN location l
  ON r.`Location` = l.location_name
 AND r.`City/County` = l.city_county
JOIN house_type ht
  ON r.`House Type` = ht.type_name;
