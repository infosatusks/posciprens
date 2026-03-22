-- Disable RLS untuk kemudahan akses via API Key (sesuai bypass sebelumnya)
-- Pastikan tidak membagikan URL dan Key ke publik jika menggunakan data sensitif

CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    username TEXT UNIQUE,
    password TEXT,
    role TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE products (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    image_url TEXT,
    name TEXT,
    category TEXT,
    qty INTEGER,
    capital_price NUMERIC,
    selling_price NUMERIC,
    barcode TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE customers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT,
    address TEXT,
    phone TEXT,
    points INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE promos (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT,
    type TEXT, -- 'nominal' atau 'produk'
    target_value TEXT, -- Angka nominal ATAU id produk
    reward_points INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE sales (
    id TEXT PRIMARY KEY, -- Format INV-...
    date DATE,
    buyer_name TEXT,
    customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
    total_nominal NUMERIC,
    discount NUMERIC,
    total_payment NUMERIC,
    cashier TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE sales_details (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    sale_id TEXT REFERENCES sales(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id) ON DELETE SET NULL,
    product_name TEXT,
    qty INTEGER,
    capital_price NUMERIC,
    selling_price NUMERIC,
    subtotal NUMERIC
);

CREATE TABLE stock_in (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    date DATE,
    category TEXT,
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    product_name TEXT,
    qty_added INTEGER,
    admin TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE expenses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    date DATE,
    category TEXT,
    vendor TEXT,
    qty INTEGER,
    nominal NUMERIC,
    total NUMERIC,
    admin TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE activity_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id TEXT,
    username TEXT,
    action TEXT,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert Default Users
INSERT INTO users (username, password, role) VALUES 
('ciprens00', '00ciprens', 'Admin'), 
('ciprens01', '01ciprens', 'Kasir');