# INNER JOIN
SELECT
  b.booking_id,
  b.booking_date,
  b.booking_details,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email
FROM
  bookings b
INNER JOIN
  users u ON b.user_id = u.user_id;

# LEFT JOIN
SELECT 
    p.property_id,
    p.title,
    p.location,
    p.price,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at
FROM 
    Properties p
LEFT JOIN 
    Reviews r 
ON 
    p.property_id = r.property_id
ORDER BY 
    p.property_id, r.created_at DESC;

# FULL OUTER JOIN
SELECT
  u.user_id,
  u.first_name,
  u.last_name,
  b.booking_id,
  b.booking_date,
  b.booking_details
FROM
  users u
FULL OUTER JOIN
  bookings b ON u.user_id = b.user_id;
