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