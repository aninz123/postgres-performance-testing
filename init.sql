-- Create tables
CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(12, 2)
);

CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER,
    price DECIMAL(10, 2)
);

-- Generate random data
INSERT INTO customers (name, email)
SELECT 
    'Customer ' || i,
    'customer' || i || '@example.com'
FROM generate_series(1, 1000000) i
ON CONFLICT DO NOTHING;

INSERT INTO products (name, price, category)
SELECT 
    'Product ' || i,
    (random() * 1000)::numeric(10,2),
    (ARRAY['Electronics', 'Clothing', 'Food', 'Books', 'Toys'])[floor(random() * 5 + 1)]
FROM generate_series(1, 100000) i
ON CONFLICT DO NOTHING;

INSERT INTO orders (customer_id, total_amount)
SELECT 
    floor(random() * 1000000 + 1)::int,
    (random() * 10000)::numeric(12,2)
FROM generate_series(1, 5000000) i
ON CONFLICT DO NOTHING;

INSERT INTO order_items (order_id, product_id, quantity, price)
SELECT 
    floor(random() * 5000000 + 1)::int,
    floor(random() * 100000 + 1)::int,
    floor(random() * 10 + 1)::int,
    (random() * 1000)::numeric(10,2)
FROM generate_series(1, 20000000) i
ON CONFLICT DO NOTHING;

-- Create indexes (comment these out initially to make initial queries even slower)
-- CREATE INDEX IF NOT EXISTS idx_customers_email ON customers(email);
-- CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
-- CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);
-- CREATE INDEX IF NOT EXISTS idx_order_items_product_id ON order_items(product_id);