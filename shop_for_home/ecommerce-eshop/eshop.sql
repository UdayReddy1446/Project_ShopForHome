-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Books', 0, '2022-06-23 23:03:26', '2022-07-05 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Clocks', 1, '2022-06-23 23:03:26', '2022-07-05 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Curtains', 2, '2022-06-23 23:03:26', '2022-07-05 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Paintings', 3, '2022-06-23 23:03:26', '2022-07-05 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 3, '2022-07-05 23:03:26', ' This Painting Is Made On 6 MM Heavy Wooden Mdf Board', 'https://m.media-amazon.com/images/I/61ArVSbNUHL._SX679_.jpg', 'Perpetual Wall Painting For Bedroom', 50.00, 0, 22, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 3, '2022-07-05 23:03:26', ' This is perfect wall decor for living room which is Uv Coated Which Makes It Dust Resistant ', 'https://m.media-amazon.com/images/I/71BtgMTf6fL._SX679_.jpg', 'Perpetual Paintings for Wall Decoration', 65.00, 0, 60, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 3, '2022-07-05 23:03:26', 'India's first effervesThis Set Of Five Wall Painting is An Ideal Piece For Decirating Beautiful Walls Of Your Placecent instant recharge and energy drink', 'https://m.media-amazon.com/images/I/81Nt45bKngL._SX679_.jpg', 'Saumic Craft Set of Five Painting for Wall Decoration', 45.00, 0, 40, '2022-07-05 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 0, '2022-07-05 23:03:26', 'It's been nearly 25 years since Robert Kiyosaki???s???Rich Dad Poor Dad???first made waves in the Personal Finance arena', 'https://images-na.ssl-images-amazon.com/images/I/51u8ZRDCVoL._SX330_BO1,204,203,200_.jpg', 'Rich Dad Poor Dad', 53.00, 0, 22, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 0, '2022-07-05 23:03:26', 'A Manifesto For Everyday Greatness In The Little Black Book for Stunning Succes', 'https://images-eu.ssl-images-amazon.com/images/I/41U5eJtIQRL._SY264_BO1,204,203,200_QL40_FMwebp_.jpg', 'Little Black Book for Stunning Success', 85.00, 0, 10, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 0, '2022-07-05 23:03:26', 'Core Java ? An Integrated Approach covers all core concepts in a methodical way. ', 'https://images-na.ssl-images-amazon.com/images/I/51z+MsmqesL._SX377_BO1,204,203,200_.jpg', 'Core Java: An Integrated Approach', 45.00, 0, 50, '2022-07-05 23:03:26');


INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-07-05 23:03:26', '100% Polyester ; There might be minor color variation between actual product and image shown on screen due to lighting on the photography & your mobile or display settings, Curtain doesn???t come with curtain rings', 'https://m.media-amazon.com/images/I/81ruWAgz9tL._SY450_.jpg', 'Polyester Solid Darkening Blackout Curtain Set', 73.00, 0, 45, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-07-05 23:03:26', 'Enhances the look of the room.Every Curtain of any Length,Width is 4 Feet(48inch)', 'https://m.media-amazon.com/images/I/61YwI6JY+0L.jpg', 'RED RIBBON DECOR Polyester Classic Curtain', 57.00, 0, 53, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-07-05 23:03:26', 'Color: Brown, Size Name: Window - 5 feet', 'https://m.media-amazon.com/images/I/81wBRjeS9IL._SY450_.jpg', 'Fashion String Polyester 2 Pieces Window Curtain', 95.00, 0, 70, '2022-07-05 23:03:26');


INSERT INTO "public"."product_info" VALUES ('AF001', 1, '2022-07-05 23:03:26', 'Easy to read: Wall clock with large numbers and front glass cover are clear to read.', 'https://images-eu.ssl-images-amazon.com/images/I/416m3AQTDiL._SX300_SY300_QL70_FMwebp_.jpg', 'NSTER Wall Clock for Home Stylish Latest VIVNITS ', 90.00, 0, 39, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 1, '2022-07-05 23:03:26', 'Dial size: 12 inches in diameter', 'https://m.media-amazon.com/images/I/81XEPquUw3L._SY450_.jpg', 'Tulsi California WalnutsSolimo 12-inch Wall Clock Kernels Premium', 76.00, 0, 75, '2022-07-05 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 1, '2022-07-05 23:03:26', 'Non-ticking Wall Clock--- Built-in quiet sweep continuous-movement second hand, wall clock ensures a silent sleeping or working environment.', 'https://images-eu.ssl-images-amazon.com/images/I/51vCXGdDF8L._SX300_SY300_QL70_FMwebp_.jpg', 'RYLAN 12" Silent Quartz Decorative Latest Wall Clock', 82.00, 0, 20, '2022-07-05 23:03:26');




------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');

---------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS

public.hibernate_sequence
INCREMENT 1
START 1
MINVALUE 1 
MAXVALUE 
9223372036854775807
CACHE 1;

ALTER SEQUENCE
public.hibernate_sequence 
   OWNER TO postgres;

