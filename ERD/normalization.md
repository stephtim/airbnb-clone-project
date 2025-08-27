# normalization
## User 
user_id (PK)
first_name
last_name
email (UNIQUE)
password_hash
phone_number
role (ENUM: guest, host, admin)
created_at
### Explanation
All the fields depend directly on the user_id. The email has been contrained as unique and herefore notued as a primary key.

## Property
property_id (PK)
host_id (FK → User.user_id)
name
description
location
price_per_night
created_at
updated_at
### Explanation
All fields depend directly on property_id and host_id depends only on property_id.

## Booking
booking_id (PK)
property_id (FK → Property.property_id)
user_id (FK → User.user_id)
start_date
end_date
total_price
status (ENUM: pending, confirmed, canceled)
created_at
### Explanation
The fields are normalized, though total price can be removed to achieve strict 3NF

## Payment
payment_id (PK)
booking_id (FK → Booking.booking_id)
amount
payment_date
payment_method (ENUM: credit_card, paypal, stripe)
### Explanation
All attributes depend on payment_id and there are no transitive dependencies.

## Review 
review_id (PK)
property_id (FK → Property.property_id)
user_id (FK → User.user_id)
rating (1–5)
comment
created_at
### Explanation
All attributes depend review_id and rating is constrained but not derived.

## Message 
message_id (PK)
sender_id (FK → User.user_id)
recipient_id (FK → User.user_id)
message_body
sent_at
### Explanation
All attributes depend on message_id and there are no transitive dependencies.
