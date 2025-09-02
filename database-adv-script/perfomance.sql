# query to retrieve all bookings
SELECT
  b.booking_id,
  b.booking_date,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  p.property_id,
  p.property_name,
  p.location,
  pay.payment_id,
  pay.amount,
  pay.payment_date,
  pay.payment_method
FROM
  bookings b
JOIN
  users u ON b.user_id = u.user_id
JOIN
  properties p ON b.property_id = p.property_id
JOIN
  payments pay ON b.booking_id = pay.booking_id;
