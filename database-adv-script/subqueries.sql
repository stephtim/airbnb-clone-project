# query
SELECT
  p.property_id,
  p.property_name,
  p.location
FROM
  properties p
WHERE
  p.property_id IN (
    SELECT
      r.property_id
    FROM
      reviews r
    GROUP BY
      r.property_id
    HAVING
      AVG(r.rating) > 4.0
  );


# subquery
SELECT
  u.user_id,
  u.first_name,
  u.last_name
FROM
  users u
WHERE
  (
    SELECT
      COUNT(*)
    FROM
      bookings b
    WHERE
      b.user_id = u.user_id
  ) > 3;
