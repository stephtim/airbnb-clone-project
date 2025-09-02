# Identified Inefficiencies
-The primary inefficiencies revealed by this EXPLAIN plan are a direct result of missing or inefficient indexing.
-Sequential Scans: The most significant inefficiency is the use of Seq Scan (sequential scan) on the bookings, users, and properties tables. This means the database is forced to read every row in each table to find a match, which is extremely slow and inefficient for tables with thousands or millions of records.
-Lack of Indexed Joins: The Hash Join and Nested Loop Join operations are being used because the database lacks fast Index Joins. When a join column isn't indexed, the database can't quickly locate the matching rows. Instead, it must resort to more expensive join methods that involve scanning or hashing entire tables. For instance, without an index on b.user_id, the database has no quick way to find a user's bookings.
-Suboptimal Join Order: The order in which the tables are joined can also impact performance. While the database's optimizer tries to pick the best order, it can make a poor choice without the right indexes to guide it.

## refactored query
-- Index on the foreign key user_id in the bookings table
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
-- Index on the foreign key property_id in the bookings table
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
-- Index on the foreign key booking_id in the payments table
CREATE INDEX idx_payments_booking_id ON payments (booking_id);
