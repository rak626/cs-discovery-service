CREATE TABLE IF NOT EXISTS users (
    user_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    preferences JSONB DEFAULT '{}'
);

CREATE TABLE IF NOT EXISTS events (
    event_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    show_times JSONB NOT NULL, -- Array of show times
    total_seats INT NOT NULL
);

CREATE TABLE IF NOT EXISTS pricing (
    price_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID NOT NULL REFERENCES events(event_id) ON DELETE CASCADE,
    seat_category VARCHAR(50) NOT NULL, -- e.g., Regular, VIP
    show_time TIMESTAMP NOT NULL,
    base_price NUMERIC(10, 2) NOT NULL,
    discount_rules JSONB DEFAULT '{}', -- JSON for discount logic
    surge_rules JSONB DEFAULT '{}' -- JSON for surge pricing
);

CREATE TABLE IF NOT EXISTS bookings (
    booking_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    event_id UUID NOT NULL REFERENCES events(event_id) ON DELETE CASCADE,
    seat_numbers JSONB NOT NULL, -- Array of booked seats
    payment_status VARCHAR(20) CHECK (payment_status IN ('Paid', 'Failed', 'Pending')) NOT NULL,
    booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    booking_id UUID NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Success', 'Failed', 'Pending')) NOT NULL,
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS notifications (
    notification_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Sent', 'Failed', 'Pending')) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
