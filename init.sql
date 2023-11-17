-- public.actor definition

-- Drop table

-- DROP TABLE actor;

CREATE TABLE actor (
	actor_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	actor_name varchar NOT NULL,
	CONSTRAINT actor_pk PRIMARY KEY (actor_id)
);


-- public.country definition

-- Drop table

-- DROP TABLE country;

CREATE TABLE country (
	country_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	country_name varchar NOT NULL,
	CONSTRAINT country_pk PRIMARY KEY (country_id)
);


-- public.director definition

-- Drop table

-- DROP TABLE director;

CREATE TABLE director (
	director_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	director_name varchar NOT NULL,
	CONSTRAINT director_pk PRIMARY KEY (director_id)
);


-- public.genre definition

-- Drop table

-- DROP TABLE genre;

CREATE TABLE genre (
	genre_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	genre varchar NOT NULL,
	CONSTRAINT genre_pk PRIMARY KEY (genre_id)
);


-- public.platform definition

-- Drop table

-- DROP TABLE platform;

CREATE TABLE platform (
	platform_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	platform varchar NOT NULL,
	CONSTRAINT platform_pk PRIMARY KEY (platform_id)
);


-- public.rating definition

-- Drop table

-- DROP TABLE rating;

CREATE TABLE rating (
	rating_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	rating varchar NOT NULL,
	CONSTRAINT rating_pk PRIMARY KEY (rating_id)
);


-- public."type" definition

-- Drop table

-- DROP TABLE "type";

CREATE TABLE "type" (
	type_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	"type" varchar NOT NULL,
	CONSTRAINT type_pk PRIMARY KEY (type_id)
);


-- public."content" definition

-- Drop table

-- DROP TABLE "content";

CREATE TABLE "content" (
	content_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	title varchar NOT NULL,
	date_added date NULL,
	release_year int4 NULL,
	rating_id int4 NOT NULL,
	duration varchar NULL,
	description varchar NULL,
	type_id int4 NOT NULL,
	platform_id int4 NOT NULL,
	CONSTRAINT content_pk PRIMARY KEY (content_id),
	CONSTRAINT content_fk_platform FOREIGN KEY (platform_id) REFERENCES platform(platform_id),
	CONSTRAINT content_fk_rating FOREIGN KEY (rating_id) REFERENCES rating(rating_id),
	CONSTRAINT content_fk_type FOREIGN KEY (type_id) REFERENCES "type"(type_id)
);


-- public.content_actor definition

-- Drop table

-- DROP TABLE content_actor;

CREATE TABLE content_actor (
	content_id int4 NOT NULL,
	actor_id int4 NOT NULL,
	CONSTRAINT content_actor_pk PRIMARY KEY (content_id, actor_id),
	CONSTRAINT content_actor_fk FOREIGN KEY (content_id) REFERENCES "content"(content_id),
	CONSTRAINT content_actor_fk_1 FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);


-- public.content_country definition

-- Drop table

-- DROP TABLE content_country;

CREATE TABLE content_country (
	content_id int4 NOT NULL,
	country_id int4 NOT NULL,
	CONSTRAINT content_country_pk PRIMARY KEY (content_id, country_id),
	CONSTRAINT content_country_fk FOREIGN KEY (country_id) REFERENCES country(country_id),
	CONSTRAINT content_country_fk_1 FOREIGN KEY (content_id) REFERENCES "content"(content_id)
);


-- public.content_director definition

-- Drop table

-- DROP TABLE content_director;

CREATE TABLE content_director (
	director_id int4 NOT NULL,
	content_id int4 NOT NULL,
	CONSTRAINT content_director_pk PRIMARY KEY (director_id, content_id),
	CONSTRAINT content_director_fk FOREIGN KEY (content_id) REFERENCES "content"(content_id),
	CONSTRAINT content_director_fk_1 FOREIGN KEY (director_id) REFERENCES director(director_id)
);


-- public.content_genre definition

-- Drop table

-- DROP TABLE content_genre;

CREATE TABLE content_genre (
	content_id int4 NOT NULL,
	genre_id int4 NOT NULL,
	CONSTRAINT content_genre_pk PRIMARY KEY (content_id, genre_id),
	CONSTRAINT content_genre_fk FOREIGN KEY (content_id) REFERENCES "content"(content_id),
	CONSTRAINT content_genre_fk_1 FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);
