# table partitioning to optimize queries on large datasets
## migrate data
-- Backup old table first
ALTER TABLE Bookings RENAME TO Bookings_old;

## partition by range on start date
CREATE TABLE Bookings (
    booking_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES Users(user_id),
    property_id BIGINT NOT NULL REFERENCES Properties(property_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

## partition by desired time frame
-- 2024 bookings
CREATE TABLE Bookings_2024
    PARTITION OF Bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- 2025 bookings
CREATE TABLE Bookings_2025
    PARTITION OF Bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Future bookings (default partition)
CREATE TABLE Bookings_future
    PARTITION OF Bookings
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

## add indexes
-- Indexes for filtering
CREATE INDEX idx_bookings_2024_status_date ON Bookings_2024 (status, start_date);
CREATE INDEX idx_bookings_2025_status_date ON Bookings_2025 (status, start_date);

-- Indexes for joins
CREATE INDEX idx_bookings_2024_user ON Bookings_2024 (user_id);
CREATE INDEX idx_bookings_2025_user ON Bookings_2025 (user_id);

CREATE INDEX idx_bookings_2024_property ON Bookings_2024 (property_id);
CREATE INDEX idx_bookings_2025_property ON Bookings_2025 (property_id);

## run efficient query
EXPLAIN
SELECT *
FROM Bookings
WHERE start_date >= '2025-01-01'
  AND start_date < '2025-06-01'
  AND status = 'confirmed';
## Tests
### query without partitioning
EXPLAIN ANALYZE
SELECT *
FROM Bookings_old
WHERE start_date >= '2025-01-01'
  AND start_date < '2025-06-30'
  AND status = 'confirmed';
### 
Expected Execution Plan (Non-Partitioned)
-Seq Scan on Bookings_old (scans the entire table).
-Filter applied only after scanning.
-Cost/time increases as table grows.

  ### Query With Partitioning
### Query on partitioned table
EXPLAIN ANALYZE
SELECT *
FROM Bookings
WHERE start_date >= '2025-01-01'
  AND start_date < '2025-06-30'
  AND status = 'confirmed';

###Expected Execution Plan (Partitioned)
-PostgreSQL prunes partitions and scans only Bookings_2025.
-If you add an index on (status, start_date), it can use Index Scan instead of Seq Scan.

###  Example output
Index Scan using idx_bookings_2025_status_date on bookings_2025  
  (cost=0.43..120.00 rows=50 width=120)
  Index Cond: ((status = 'confirmed') AND (start_date >= '2025-01-01') AND (start_date < '2025-06-30'))


  

