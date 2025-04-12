-- Total number of listings
select count(*) as total_listings from listings;

--Avg. price of listings
select avg(price) as avg_price from listings;

-- Listings by neighbourhood
select neighbourhoods.neighbourhood, count(*) as total_listings from listings
right join neighbourhoods on neighbourhoods.id=listings.neighbourhood_id
group by neighbourhoods.neighbourhood
order by total_listings desc;

-- most common room types
select room_type, count(*) as total_listings from listings
group by room_type
order by total_listings desc;

-- Top 10 reviewed listings
select id,name, number_of_reviews from listings
order by number_of_reviews desc
limit 10;

--Avg. Price by room type
select room_type, ROUND(AVG(price)::numeric, 2) as avg_price 
from listings
group by room_type
order by avg_price desc;

-- Monthly review trend
select to_char(date_trunc('month',review_date),'YYYY-MM') as review_months,count(*) as total_count
from reviews
group by review_months
order by review_months asc