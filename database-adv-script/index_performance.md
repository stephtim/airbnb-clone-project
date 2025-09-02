# High usage columns
### User table
The users table is typically queried to find specific users or link them to other data.
user_id: This is the primary key and the most frequently used column. It's essential for JOIN operations with the bookings table. It's also often used in WHERE clauses to look up a specific user.
email: This column is commonly used for user login, so it's a prime candidate for a WHERE clause to find a user quickly. It should have a unique index.

### Booking Table
The bookings table often serves as the central point for connecting users and properties.
booking_id: As the primary key, it's used in WHERE clauses to retrieve a specific booking.
user_id: This is a foreign key that links to the users table. It's heavily used in JOIN operations to find all bookings for a user and in WHERE clauses to filter bookings by a specific user.
property_id: This is a foreign key that links to the properties table. It's crucial for JOIN operations to find all bookings for a specific property and in WHERE clauses to filter by property.
booking_date or start_date: These date columns are frequently used in WHERE clauses to filter bookings by a specific date range, and in ORDER BY clauses to sort by recency.

### Property Table
The properties table is often the starting point for searching and filtering.

property_id: This is the primary key. It's used in JOIN operations with the bookings and reviews tables and in WHERE clauses to look up a specific property.
location: Users frequently search for properties by location. This column is a very common part of WHERE clauses.
price or nightly_rate: These columns are used in WHERE and ORDER BY clauses to filter or sort properties based on price.

average_rating (if pre-calculated): This column would be used in a WHERE clause to find properties with good reviews and in an ORDER BY clause to sort by rating.

# indexes commands
### users table
- Index on the primary key, user_id, for faster lookups and joins
CREATE UNIQUE INDEX idx_user_id ON users (user_id);

-- Index on the email column for quick user lookups during login.
-- This should be a unique index as emails are typically unique.
CREATE UNIQUE INDEX idx_user_email ON users (email);

### bookings table
-- Index on the foreign key user_id for efficient joins with the users table.
CREATE INDEX idx_bookings_user_id ON bookings (user_id);

-- Index on the foreign key property_id for efficient joins with the properties table.
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Index on the booking_date for quick filtering and sorting by date.
CREATE INDEX idx_bookings_date ON bookings (booking_date);

### properties table
-- Index on the primary key, property_id, for faster joins and lookups.
CREATE UNIQUE INDEX idx_properties_id ON properties (property_id);

-- Index on the location for faster searches by location.
CREATE INDEX idx_properties_location ON properties (location);

-- Index on the nightly_rate or price for faster sorting and filtering.
CREATE INDEX idx_properties_price ON properties (nightly_rate);

-- Index on average_rating for quick filtering and sorting.
CREATE INDEX idx_properties_rating ON properties (average_rating);

## measure query performance
### before index
EXPLAIN ANALYZE
SELECT
  p.property_name,
  b.booking_date
FROM
  properties p
JOIN
  bookings b ON p.property_id = b.property_id
WHERE
  p.location = 'Mombasa';

  ### after index
  CREATE INDEX idx_properties_location ON properties (location);
CREATE INDEX idx_properties_property_id ON properties (property_id);

EXPLAIN ANALYZE
SELECT
  p.property_name,
  b.booking_date
FROM
  properties p
JOIN
  bookings b ON p.property_id = b.property_id
WHERE
  p.location = 'Mombasa';
