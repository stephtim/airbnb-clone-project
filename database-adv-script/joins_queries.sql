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
  p.property_name,
  p.location,
  r.review_id,
  r.rating,
  r.review_text
FROM
  properties p
LEFT JOIN
  reviews r ON p.property_id = r.property_id;

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
