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
    p.property_id,
    p.title,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
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
