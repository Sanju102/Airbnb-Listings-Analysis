import pandas as pd

# Load raw CSVs
listings = pd.read_csv('listings.csv')
reviews = pd.read_csv('reviews.csv')
neighbourhoods = pd.read_csv('neighbourhoods.csv')

# ---------- HOSTS ----------
hosts=listings.copy()[['host_id','host_name']]
hosts.drop_duplicates(inplace=True)
hosts['id'] = hosts['host_id']
hosts['name'] = hosts['host_name']
hosts.drop(['host_id', 'host_name'], axis=1, inplace=True)

# ---------- NEIGHBOURHOODS ----------
neighbourhoods = neighbourhoods.drop_duplicates()
neighbourhoods['neighbourhood_id'] = neighbourhoods.index + 1  # Assign unique IDs

# Merge to get neighbourhood_id into listings
listings = pd.merge(
    listings,
    neighbourhoods[['neighbourhood', 'neighbourhood_group', 'neighbourhood_id']],
    on=['neighbourhood', 'neighbourhood_group'],
    how='left'
)

# ---------- LISTINGS ----------
listings.drop(['host_name', 'neighbourhood', 'neighbourhood_group'], axis=1, inplace=True)
listings.drop_duplicates(inplace=True)

# ---------- Final Neighbourhood Table Formatting ----------
neighbourhoods['id'] = neighbourhoods['neighbourhood_id']
neighbourhoods.drop('neighbourhood_id', axis=1, inplace=True)
neighbourhoods = neighbourhoods[['id', 'neighbourhood', 'neighbourhood_group']]

# ---------- Export ----------
listings.to_csv('clean_data/listings.csv', index=False)
hosts.to_csv('clean_data/hosts.csv', index=False)
reviews.to_csv('clean_data/reviews.csv', index=False)
neighbourhoods.to_csv('clean_data/neighbourhoods.csv', index=False)

print("Data cleaned and exported successfully!")
