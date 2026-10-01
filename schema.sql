CREATE TABLE users(
	id serial primary key,
	public_id uuid,
	full_name VARCHAR(200) NOT	NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone VARCHAR(20),
	password VARCHAR(100) NOT NULL,
	google_id VARCHAR(255),
	avatar_url text,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL
);