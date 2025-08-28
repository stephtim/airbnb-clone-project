# seed database with sample data
-- USERS (hosts and guests)
INSERT INTO users (name, email, role) VALUES
('Alice Kioko', 'alice@example.com', 'host'),
('Bob Mtemi', 'bob@example.com', 'guest'),
('Carol Ooko', 'carol@example.com', 'both'),
('David Baule', 'david@example.com', 'guest'),
('Evelyn Mecha', 'evelyn@example.com', 'host');

-- PROPERTIES (owned by hosts)
INSERT INTO properties (host_id, title, description, location) VALUES
(1, 'Cozy Apartment in Nairobi', '2-bedroom apartment near city center', 'Nairobi, Kenya'),
(1, 'Beachfront Villa', 'Luxury villa with ocean view', 'Mombasa, Kenya'),
(3, 'Countryside Cottage', 'Quiet cottage surrounded by nature', 'Naivasha, Kenya'),
(5, 'Modern Loft', 'Stylish loft in downtown', 'Kisumu, Kenya');

-- BOOKINGS (guests book properties)
INSERT INTO bookings (guest_id, property_id, start_date, end_date, status) VALUES
(2, 1, '2025-09-10', '2025-09-15', 'confirmed'),
(4, 2, '2025-10-01', '2025-10-07', 'pending'),
(2, 3, '2025-11-05', '2025-11-10', 'completed'),
(4, 4, '2025-09-20', '2025-09-25', 'cancelled');

-- PAYMENTS (linked to bookings)
INSERT INTO payments (booking_id, amount, method, status) VALUES
(1, 250.00, 'credit_card', 'completed'),
(2, 700.00, 'paypal', 'pending'),
(3, 300.00, 'bank_transfer', 'completed'),
(4, 450.00, 'credit_card', 'failed');

-- REVIEWS (one per completed booking)
INSERT INTO reviews (booking_id, reviewer_id, rating, comment) VALUES
(3, 2, 5, 'Amazing stay! The cottage was peaceful and host very welcoming.');

-- MESSAGES (users chatting, optionally tied to properties)
INSERT INTO messages (sender_id, receiver_id, property_id, content) VALUES
(2, 1, 1, 'Hi Alice, is the apartment available in September?'),
(1, 2, 1, 'Yes Bob, it is available. Would you like to book it?'),
(4, 5, 4, 'Hi Evelyn, I am interested in your modern loft.'),
(5, 4, 4, 'Hello David, sure! What dates are you considering?');
