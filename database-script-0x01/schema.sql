# CREATE TABLE statements
-- USER table: hosts and guests
CREATE TABLE users (
    user_id       SERIAL PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(150) UNIQUE NOT NULL,
    role          VARCHAR(20) CHECK (role IN ('host', 'guest', 'both')),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Index: email already unique (good for login lookups)
CREATE INDEX idx_users_role ON users(role);

-- PROPERTY table: owned by a user (host)
CREATE TABLE properties (
    property_id   SERIAL PRIMARY KEY,
    host_id       INT NOT NULL,
    title         VARCHAR(200) NOT NULL,
    description   TEXT,
    location      VARCHAR(200),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users(user_id)
);
-- Index: common lookups by host or location
CREATE INDEX idx_properties_host ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);

-- BOOKING table: connects user (guest) and property
CREATE TABLE bookings (
    booking_id    SERIAL PRIMARY KEY,
    guest_id      INT NOT NULL,
    property_id   INT NOT NULL,
    start_date    DATE NOT NULL,
    end_date      DATE NOT NULL,
    status        VARCHAR(20) CHECK (status IN ('pending','confirmed','cancelled','completed')),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);
-- Index: improve queries on guest, property, and date range searches
CREATE INDEX idx_bookings_guest ON bookings(guest_id);
CREATE INDEX idx_bookings_property ON bookings(property_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- PAYMENT table: tied to a booking
CREATE TABLE payments (
    payment_id    SERIAL PRIMARY KEY,
    booking_id    INT NOT NULL,
    amount        DECIMAL(10,2) NOT NULL,
    payment_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method        VARCHAR(50),
    status        VARCHAR(20) CHECK (status IN ('pending','completed','failed')),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
-- Index: useful for reporting and payment tracking
CREATE INDEX idx_payments_booking ON payments(booking_id);
CREATE INDEX idx_payments_date ON payments(payment_date);
CREATE INDEX idx_payments_status ON payments(status);

-- REVIEW table: one review per booking
CREATE TABLE reviews (
    review_id     SERIAL PRIMARY KEY,
    booking_id    INT UNIQUE, -- enforce one-to-one
    reviewer_id   INT NOT NULL,
    rating        INT CHECK (rating BETWEEN 1 AND 5),
    comment       TEXT,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (reviewer_id) REFERENCES users(user_id)
);
-- Index: searching/filtering reviews
CREATE INDEX idx_reviews_booking ON reviews(booking_id);
CREATE INDEX idx_reviews_user ON reviews(reviewer_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- MESSAGE table: user-to-user, optionally tied to property
CREATE TABLE messages (
    message_id    SERIAL PRIMARY KEY,
    sender_id     INT NOT NULL,
    receiver_id   INT NOT NULL,
    property_id   INT, -- optional link
    content       TEXT NOT NULL,
    sent_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);
-- Index: speed up inbox/outbox queries & property-linked inquiries
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_receiver ON messages(receiver_id);
CREATE INDEX idx_messages_property ON messages(property_id);
CREATE INDEX idx_messages_sent_at ON messages(sent_at);
