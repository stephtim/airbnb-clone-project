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

-- Join with Payments (LEFT JOIN because not all bookings may have payments yet)
LEFT JOIN Payments pay 
    ON b.booking_id = pay.booking_id

ORDER BY 
    b.booking_id DESC;
