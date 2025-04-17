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
order by review_months asc;
-- Where's it  most expensive to stay? (Top 5 neighbourhoods by average price)
select
n.neighbourhood as neighbourhood,
round(avg(l.price)::numeric,2) as avg_price
from listings as l
left join neighbourhoods as n on l.neighbourhood_id=n.id
where not l.price is null
group by n.neighbourhood
order by avg_price desc
limit 5;

-- find overpriced listings (Listings with price > average +2 std deviations (possible outliers))
with  stats as (
select avg(price) as avg_price, stddev(price) as std_dev
from listings
)
select listings.*
from listings, stats
where price > avg_price +2*std_dev;

-- Host with most listings (Superhost candidate)
select
h.id as host_id,
h.name as host_name,
count(*) as listing_count
from listings as l left join hosts h on l.host_id=h.id
group by h.id,h.name
order by listing_count desc
limit 1;

-- listings that are available all year
select id,name,availability_365
from listings
where availability_365=365;

-- Low Reviewed listings with high prices
select
id,
name,
price,
number_of_reviews
from listings
where number_of_reviews<5 and price>200
order by price desc;

-- review frequency per listings (most active listings based on reviewd per month)
select
id,
name,
number_of_reviews,
reviews_per_month
from listings
where not reviews_per_month is null
order by reviews_per_month desc
limit 10;

