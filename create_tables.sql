CREATE TABLE hosts (
    id INT PRIMARY KEY,
    name TEXT
);

CREATE TABLE neighbourhoods (
    id INT PRIMARY KEY,
    neighbourhood TEXT,
    neighbourhood_group TEXT
);

CREATE TABLE listings (
    id BIGINT PRIMARY KEY,
    name TEXT,
    host_id INT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    room_type TEXT,
    price FLOAT,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month FLOAT,
    calculated_host_listings_count INT,
    availability_365 INT,
    number_of_reviews_ltm INT,
    license TEXT,
    neighbourhood_id INT,
    
    FOREIGN KEY (host_id) REFERENCES hosts(id),
    FOREIGN KEY (neighbourhood_id) REFERENCES neighbourhoods(id)
);

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    listing_id BIGINT,
    review_date DATE,
    FOREIGN KEY (listing_id) REFERENCES listings(id)
);
