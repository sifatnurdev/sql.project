CREATE TABLE users(
	id serial primary key,
	public_id uuid,
	full_name VARCHAR(200) NOT	NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone VARCHAR(20),
	password VARCHAR(100) NOT NULL,
	google_id VARCHAR(255),
	avatar_url TEXT,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE product_images(
	id serial primary key,
	public_id uuid, 
	product_id INT REFERENCES products(id),
	url TEXT NOT NULL,
	alt_TEXT NOT NULL,
	sort_order NOT NULL
);


CREATE TABLE categories(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	parent_id INT REFERENCES categories(id),
	name character VARCHAR(100),
	slug character VARCHAR(100),
	image_url TEXT ,
	sort_order INT,
	is_active BOOLEAN
);


CREATE TABLE products(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	category_id INT REFERENCES categories(id),
	name character VARCHAR(100),
	slug character VARCHAR(100),
	short_description character VARCHAR(100),
	description TEXT,
	benefits TEXT[],
	is_featured BOOLEAN,
	is_active BOOLEAN,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,	
);

CREATE TABLE product_variants(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	product_id INT REFERENCES products(id),
	sku character VARCHAR(100),
	weight_grams INT,
	price numeric(10,2),
	compare_at_price numeric(10,2),
	stock_quantity INT,
	is_active BOOLEAN,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL
);


CREATE TABLE orders(
	id SERIAL PRIMARY KEY,
	public_id UUID,	
	order_number character VARCHAR(30),
	user_id INT payments(status ),
	customer_name character VARCHAR(100),
	customer_phone character VARCHAR(100),
	customer_email character VARCHAR(100),
	shipping_address TEXT,
	shipping_district character VARCHAR(100),
	shipping_thana character VARCHAR(100),
	note TEXT,
	subtotal numeric(10,2),
	shipping_fee numeric(10,2),
	discount_amount numeric(10,2),
	total_amount numeric(10,2),
	coupon_id INT REFERENCES coupons(id),
	estimated_delivery_data date,
	delivered_at TIMESTAMPTZ NOT NULL,
	cancelled_at TIMESTAMPTZ NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE wishlist_items(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	user_id INT REFERENCES users(id),
	product_id INT REFERENCES products(id),
	created_at TIMESTAMPTZ NOT NULL
);


CREATE TABLE order_items(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	order_id INT REFERENCES orders(id),
	variant_id INT REFERENCES product_variants(id),
	product_name character VARCHAR(200),
	weight_grams INT,
	unit_price numeric(10,2),
	kuantity INT
);

CREATE TABLE reviews(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	product_id INT REFERENCES products(id),
	user_id INT REFERENCES users(id),
	rating smallint,
	title character VARCHAR(200),
	body TEXT,
	is_verified_purchase BOOLEAN,
	is_approved BOOLEAN,
	created_at TIMESTAMPTZ NOT NULL,

);

CREATE TABLE payments(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	order_id INT REFERENCES orders(id),
	method payment_method,
	status payment_status,
	amount numeric(10,2),
	transaction_id character VARCHAR(150),
	payer_number character VARCHAR(200),
	paid_at TIMESTAMPTZ NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
);

CREATE TABLE thanas(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	district_id INT REFERENCES districts(id),
	name character VARCHAR(100),
);

CREATE TABLE disticts(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	name character VARCHAR(100),
	delivery_fee numeric(10,2d)
);

CREATE TABLE addresses(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	user_id INT REFERENCES users(id),
	recipient_name character VARCHAR(200),
	phone character VARCHAR(20),
	address_line TEXT,
	district_id INT REFERENCES districts(id),
	thana_id INT REFERENCES thanas(id),
	is_default BOOLEAN,
	created_at TIMESTAMPTZ NOT NULL	
);

CREATE TABLE cart_items(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	user_id	INT REFERENCES users(id),
	variant_id INT REFERENCES product_variant(id),
	quantity INT,
	created_at TIMESTAMPTZ NOT NULL	
);

CREATE TABLE coupons(
	id SERIAL PRIMARY KEY,
	public_id UUID,
	code character VARCHAR(50),
	discount_type coupon_discount_type,
	discount_value numeric(10,2),
	max_discount numeric(10,2),
	mon_order_amount numeric(10,2)
	starts_at TIMESTAMPTZ NOT NULL,
	expires_ta TIMESTAMPTZ NOT NULL,
	usage_limit INT,
	used_count INT,
	is_active BOOLEAN,
	created_at TIMESTAMPTZ NOT NULL
);