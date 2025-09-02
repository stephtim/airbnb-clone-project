# aggregations and window functions
SELECT
  user_id,
  COUNT(booking_id) AS total_bookings
FROM
  bookings
GROUP BY
  user_id
ORDER BY
  total_bookings DESC;

# window function
SELECT
  property_id,
  property_name,
  total_bookings,
  RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
  SELECT
    p.property_id,
    p.property_name,
    COUNT(b.booking_id) AS total_bookings
  FROM
    properties p
  JOIN
    bookings b ON p.property_id = b.property_id
  GROUP BY
    p.property_id, p.property_name
) AS subquery_result
ORDER BY
  booking_rank;
