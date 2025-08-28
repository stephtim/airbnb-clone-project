# Indexes necessary for optimal performance

Users

PRIMARY KEY (user_id) → auto-indexed.

UNIQUE (email) → auto-indexed.

Likely queries: find hosts/guests quickly, filter by role, lookups by created_at for auditing.

CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_created_at ON users(created_at);

Properties

PRIMARY KEY (property_id) → auto-indexed.

host_id frequently used in joins (all properties of a host).

CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_created_at ON properties(created_at);

Bookings

PRIMARY KEY (booking_id) → auto-indexed.

Foreign keys: guest_id, property_id — critical for lookups (guest’s bookings, property’s bookings).

Queries often filter by status, start_date, end_date.

CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_date_range ON bookings(start_date, end_date);

Payments

PRIMARY KEY (payment_id) → auto-indexed.

booking_id needed for joins.

Reporting often by status or payment_date.

CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_payment_date ON payments(payment_date);

Reviews

PRIMARY KEY (review_id) → auto-indexed.

booking_id is UNIQUE + FK → already indexed.

reviewer_id useful for queries like all reviews by user.

CREATE INDEX idx_reviews_reviewer_id ON reviews(reviewer_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

Messages

PRIMARY KEY (message_id) → auto-indexed.

Common queries: all messages between two users, messages on a property.

sender_id + receiver_id often used together.

CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_receiver_id ON messages(receiver_id);
CREATE INDEX idx_messages_property_id ON messages(property_id);
CREATE INDEX idx_messages_sender_receiver ON messages(sender_id, receiver_id);
