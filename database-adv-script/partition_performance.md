# Performance Analysis
| Query Type            | Plan Type                      | Expected Speed                           |
| --------------------- | ------------------------------ | ---------------------------------------- |
| Non-Partitioned (old) | Seq Scan on full table         | ❌ Slow (full table scan)                 |
| Partitioned (new)     | Partition Pruning + Index Scan | ✅ Fast (only relevant partition scanned) |
✅ Result: Partitioning drastically reduces query time because PostgreSQL skips irrelevant partitions and leverages indexes within each partition.
