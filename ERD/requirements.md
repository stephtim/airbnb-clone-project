# Entities and their attributes
## User
-User_id: Primary Key:UUID, indexed
-first_name: VARCHAR, NOT NULL
-last_name: VARCHAR, NOT NULL
-email: VARCHAR, UNIQUE, NOT NULL
-password_hash: VARCHAR, NOT NULL
-phone_number: VARCHAR, NULL
-role: ENUM (guest, host, admin), NOT NULL
-created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Property
-property_id: Primary Key, UUID, Indexed
-host_id: Foreign Key, references User(user_id)
-name: VARCHAR, NOT NULL
-description: TEXT, NOT NULL
-location: VARCHAR, NOT NULL
-pricepernight: DECIMAL, NOT NULL
-created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
-updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

## Booking
-booking_id: Primary Key, UUID, Indexed
-property_id: Foreign Key, references Property(property_id)
-user_id: Foreign Key, references User(user_id)
-start_date: DATE, NOT NULL
-end_date: DATE, NOT NULL
-total_price: DECIMAL, NOT NULL
-status: ENUM (pending, confirmed, canceled), NOT NULL
-created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Payment
-payment_id: Primary Key, UUID, Indexed
-booking_id: Foreign Key, references Booking(booking_id)
-amount: DECIMAL, NOT NULL
-payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
-payment_method: ENUM (credit_card, paypal, stripe), NOT NULL

## Review
-review_id: Primary Key, UUID, Indexed
-property_id: Foreign Key, references Property(property_id)
-user_id: Foreign Key, references User(user_id)
-rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
-comment: TEXT, NOT NULL
-created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Message
-message_id: Primary Key, UUID, Indexed
-sender_id: Foreign Key, references User(user_id)
-recipient_id: Foreign Key, references User(user_id)
-message_body: TEXT, NOT NULL
-sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

# Relationhip between entities.
-User–Property: One-to-Many (1 user owns many properties)

-User–Booking: One-to-Many (1 user makes many bookings)

-Property–Booking: One-to-Many (1 property has many bookings)

-Booking–Payment: One-to-Many (1 booking may have multiple payments)

-Booking–Review: One-to-One (1 booking can generate at most one review)

-User–Review: One-to-Many (1 user can write many reviews)

-User–Message–User: One-to-Many self-reference (users send/receive many messages)

-Message–Property (optional): Many-to-One (many messages may relate to one property)


<img width="609" height="361" alt="ER drawio" src="https://github.com/user-attachments/assets/f558cad8-c321-4081-9b09-866a8af7f61c" />



<img width="609" height="361" alt="ER1 drawio" src="https://github.com/user-attachments/assets/f7d30a32-17b5-4f8e-9e7d-391c9bc940d4" />
