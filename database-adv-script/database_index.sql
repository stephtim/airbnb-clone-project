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
