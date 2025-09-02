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
-- Indexes for Users table
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_role ON Users(role);

-- Indexes for Properties table
CREATE INDEX idx_properties_host_id ON Properties(host_id);
CREATE INDEX idx_properties_location ON Properties(location);
CREATE INDEX idx_properties_price ON Properties(price);

-- Indexes for Bookings table
CREATE INDEX idx_bookings_guest_id ON Bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_bookings_status ON Bookings(status);
CREATE INDEX idx_bookings_dates ON Bookings(start_date, end_date);

-- Indexes for Reviews table
CREATE INDEX idx_reviews_property_id ON Reviews(property_id);
CREATE INDEX idx_reviews_guest_id ON Reviews(guest_id);

-- Indexes for Payments table
CREATE INDEX idx_payments_booking_id ON Payments(booking_id);
CREATE INDEX idx_payments_user_id ON Payments(user_id);
CREATE INDEX idx_payments_status ON Payments(status);

-- Indexes for Messages table
CREATE INDEX idx_messages_sender_id ON Messages(sender_id);
CREATE INDEX idx_messages_receiver_id ON Messages(receiver_id);
CREATE INDEX idx_messages_property_id ON Messages(property_id);

## measure query performance
### before indexing
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.title,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    Properties p
LEFT JOIN 
    Bookings b 
ON 
    p.property_id = b.property_id
GROUP BY 
    p.property_id, p.title
ORDER BY 
    booking_rank;
 ### after indexing
 EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.title,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    Properties p
LEFT JOIN 
    Bookings b 
ON 
    p.property_id = b.property_id
GROUP BY 
    p.property_id, p.title
ORDER BY 
    booking_rank;
