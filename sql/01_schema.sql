USE london_housing;

CREATE TABLE location (
    location_id   INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL,
    city_county   VARCHAR(100) NOT NULL
);

CREATE TABLE house_type (
    house_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name     VARCHAR(50) NOT NULL
);

CREATE TABLE listing (
    listing_id    INT AUTO_INCREMENT PRIMARY KEY,
    raw_id        INT UNIQUE,
    property_name VARCHAR(255),
    location_id   INT NOT NULL,
    house_type_id INT NOT NULL,
    area_sqft     INT,
    bedrooms      INT,
    bathrooms     INT,
    receptions    INT,
    price         INT,
    postal_code   VARCHAR(20),
    year          INT NOT NULL,
    CONSTRAINT fk_listing_location
        FOREIGN KEY (location_id) REFERENCES location(location_id),
    CONSTRAINT fk_listing_house_type
        FOREIGN KEY (house_type_id) REFERENCES house_type(house_type_id)
);

CREATE INDEX idx_listing_location_year ON listing(location_id, year);
CREATE INDEX idx_listing_price ON listing(price);
