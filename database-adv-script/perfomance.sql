# query to retrieve all bookings
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,

    -- User (Guest/Host) details
    u.user_id,
    u.full_name AS user_name,
    u.email AS user_email,
    u.role AS user_role,

    -- Property details
    p.property_id,
    p.title AS property_title,
    p.location AS property_location,
    p.price AS property_price,

    -- Payment details
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.currency,
    pay.status AS payment_status,
    pay.created_at AS payment_date

FROM 
    Bookings b

-- Join with Users
INNER JOIN Users u 
    ON b.user_id = u.user_id

-- Join with Properties
INNER JOIN Properties p 
    ON b.property_id = p.property_id

-- Join with Payments
LEFT JOIN Payments pay 
    ON b.booking_id = pay.booking_id

-- Filtering with WHERE and AND
WHERE 
    b.status = 'confirmed'             -- Only confirmed bookings
    AND b.start_date >= '2025-01-01'   -- Only bookings starting in 2025
    AND (pay.status = 'successful' OR pay.status IS NULL) -- Payments successful or not yet made

ORDER BY 
    b.start_date ASC;

# Identified Inefficiencies
### Sequential Scans on Bookings, Properties, and Users
-The DB is scanning all rows instead of using indexes.
-This is costly if you have millions of rows.
###Filter Conditions Not Indexed
-b.status = 'confirmed'
-b.start_date >= '2025-01-01'
These filters would benefit from an index.
###Join Performance
-Joins on user_id and property_id are hash joins or seq scans without indexes.
-This slows performance when tables grow.
###Sorting by b.start_date
-The final ORDER BY b.start_date forces a sort step.
-Without an index, this sort can be very expensive.
  
