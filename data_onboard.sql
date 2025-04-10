-- Assumes you have already created the tables

-- Load data into hosts table
COPY hosts(id, name)
FROM 'C:\Sanju Personal\Data Projects\NY_ARBNB\clean_data\hosts.csv'
DELIMITER ','
CSV HEADER;

-- Load data into neighbourhoods table
COPY neighbourhoods(id, neighbourhood, neighbourhood_group)
FROM 'C:\Sanju Personal\Data Projects\NY_ARBNB\clean_data\neighbourhoods.csv'
DELIMITER ','
CSV HEADER;

-- Load data into listings table
COPY listings(id, name, host_id, latitude, longitude, room_type, price,
              minimum_nights, number_of_reviews, last_review, reviews_per_month,
              calculated_host_listings_count, availability_365, number_of_reviews_ltm,
              license, neighbourhood_id)
FROM 'C:\Sanju Personal\Data Projects\NY_ARBNB\clean_data\listings.csv'
DELIMITER ','
CSV HEADER;

-- Load data into reviews table
COPY reviews(listing_id, review_date)
FROM 'C:\Sanju Personal\Data Projects\NY_ARBNB\clean_data\reviews.csv'
DELIMITER ','
CSV HEADER;
