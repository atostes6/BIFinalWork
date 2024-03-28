
CREATE SEQUENCE public.dim_order_items_sk_order_items_seq;

CREATE TABLE public.dim_order_items (
                sk_order_items INTEGER NOT NULL DEFAULT nextval('public.dim_order_items_sk_order_items_seq'),
                nk_order_items INTEGER NOT NULL,
                product_id INTEGER NOT NULL,
                item_quantity INTEGER NOT NULL,
                item_price REAL NOT NULL,
                total_item_price REAL NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_order_items PRIMARY KEY (sk_order_items)
);


ALTER SEQUENCE public.dim_order_items_sk_order_items_seq OWNED BY public.dim_order_items.sk_order_items;

CREATE SEQUENCE public.dim_payment_details_sk_payment_details_seq;

CREATE TABLE public.dim_payment_details (
                sk_payment_details INTEGER NOT NULL DEFAULT nextval('public.dim_payment_details_sk_payment_details_seq'),
                nk_payment_details INTEGER NOT NULL,
                payment_provider_name VARCHAR(100) NOT NULL,
                payment_provider_type_id INTEGER NOT NULL,
                amount REAL NOT NULL,
                payment_type_description VARCHAR(100) NOT NULL,
                created_at TIMESTAMP NOT NULL,
                modified_at TIMESTAMP NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_payment_details PRIMARY KEY (sk_payment_details)
);


ALTER SEQUENCE public.dim_payment_details_sk_payment_details_seq OWNED BY public.dim_payment_details.sk_payment_details;

CREATE SEQUENCE public.dim_order_distribution_channel_sk_order_distribution_channel345;

CREATE TABLE public.dim_order_distribution_channel (
                sk_order_distribution_channel INTEGER NOT NULL DEFAULT nextval('public.dim_order_distribution_channel_sk_order_distribution_channel345'),
                nk_order_distribution_channel INTEGER NOT NULL,
                order_distribution_channel_name VARCHAR NOT NULL,
                order_distribution_channel_description VARCHAR(100) NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_order_distribution_channel PRIMARY KEY (sk_order_distribution_channel)
);


ALTER SEQUENCE public.dim_order_distribution_channel_sk_order_distribution_channel345 OWNED BY public.dim_order_distribution_channel.sk_order_distribution_channel;

CREATE SEQUENCE public.dim_order_put_channel_sk_order_put_channel_seq;

CREATE TABLE public.dim_order_put_channel (
                sk_order_put_channel INTEGER NOT NULL DEFAULT nextval('public.dim_order_put_channel_sk_order_put_channel_seq'),
                nk_order_put_channel INTEGER NOT NULL,
                order_put_channel_name VARCHAR(100) NOT NULL,
                order_put_channel_description VARCHAR(100) NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_order_put_channel_id PRIMARY KEY (sk_order_put_channel)
);


ALTER SEQUENCE public.dim_order_put_channel_sk_order_put_channel_seq OWNED BY public.dim_order_put_channel.sk_order_put_channel;

CREATE SEQUENCE public.dim_supplier_sk_supplier_seq;

CREATE TABLE public.dim_supplier (
                sk_supplier INTEGER NOT NULL DEFAULT nextval('public.dim_supplier_sk_supplier_seq'),
                nk_supplier INTEGER NOT NULL,
                supplier_name VARCHAR(50) NOT NULL,
                supplier_city_name VARCHAR(50) NOT NULL,
                supplier_state_province_county VARCHAR(50) NOT NULL,
                supplier_iso_country_code VARCHAR(3) NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_supplier PRIMARY KEY (sk_supplier)
);


ALTER SEQUENCE public.dim_supplier_sk_supplier_seq OWNED BY public.dim_supplier.sk_supplier;

CREATE SEQUENCE public.dim_customer_sk_customer_seq;

CREATE TABLE public.dim_customer (
                sk_customer INTEGER NOT NULL DEFAULT nextval('public.dim_customer_sk_customer_seq'),
                nk_customer INTEGER NOT NULL,
                customer_name VARCHAR(100) NOT NULL,
                customer_city_name VARCHAR(50) NOT NULL,
                customer_gender VARCHAR(10) NOT NULL,
                customer_birth_date DATE NOT NULL,
                customer_state_province_county VARCHAR(50),
                customer_country_iso_code VARCHAR(3) NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_customer PRIMARY KEY (sk_customer)
);


ALTER SEQUENCE public.dim_customer_sk_customer_seq OWNED BY public.dim_customer.sk_customer;

CREATE SEQUENCE public.dim_date_sk_date_seq;

CREATE TABLE public.dim_date (
                sk_date INTEGER NOT NULL DEFAULT nextval('public.dim_date_sk_date_seq'),
                nk_date DATE NOT NULL,
                complete_date_description VARCHAR(60) NOT NULL,
                year_number INTEGER NOT NULL,
                trimester_name VARCHAR(20) NOT NULL,
                year_trimestrer_name VARCHAR(20) NOT NULL,
                month_number INTEGER NOT NULL,
                month_name VARCHAR(20) NOT NULL,
                year_month VARCHAR(20) NOT NULL,
                weekday_number INTEGER NOT NULL,
                year_week VARCHAR(20) NOT NULL,
                day_number INTEGER NOT NULL,
                day_year_number INTEGER NOT NULL,
                weekday_name VARCHAR(20) NOT NULL,
                weekend_flag VARCHAR(3) NOT NULL,
                holiday_flag VARCHAR(3) NOT NULL,
                holiday_name VARCHAR(60) NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_date PRIMARY KEY (sk_date)
);


ALTER SEQUENCE public.dim_date_sk_date_seq OWNED BY public.dim_date.sk_date;

CREATE SEQUENCE public.dim_product_sk_product_seq;

CREATE TABLE public.dim_product (
                sk_product INTEGER NOT NULL DEFAULT nextval('public.dim_product_sk_product_seq'),
                nk_product INTEGER NOT NULL,
                product_category_id INTEGER NOT NULL,
                product_sku VARCHAR(50) NOT NULL,
                product_name VARCHAR(100) NOT NULL,
                product_supplier_id INTEGER NOT NULL,
                product_description VARCHAR(200) NOT NULL,
                product_category_name VARCHAR(100) NOT NULL,
                product_category_description VARCHAR NOT NULL,
                product_price REAL NOT NULL,
                etl_begin_date DATE NOT NULL,
                etl_end_date DATE NOT NULL,
                etl_version INTEGER NOT NULL,
                CONSTRAINT sk_product PRIMARY KEY (sk_product)
);


ALTER SEQUENCE public.dim_product_sk_product_seq OWNED BY public.dim_product.sk_product;

CREATE TABLE public.ft_customer_order (
                sk_customer INTEGER NOT NULL,
                sk_order_items INTEGER NOT NULL,
                sk_product INTEGER NOT NULL,
                sk_supplier INTEGER NOT NULL,
                sk_order_distribution_channel INTEGER NOT NULL,
                sk_order_put_channel INTEGER NOT NULL,
                sk_payment_details INTEGER NOT NULL,
                sk_date INTEGER NOT NULL,
                date_order_placed DATE NOT NULL,
                date_order_paid DATE NOT NULL,
                order_total_price REAL NOT NULL
);


ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_order_items_ft_customer_order_fk
FOREIGN KEY (sk_order_items)
REFERENCES public.dim_order_items (sk_order_items)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_payment_details_ft_order_fk
FOREIGN KEY (sk_payment_details)
REFERENCES public.dim_payment_details (sk_payment_details)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_order_distribution_channel_ft_order_fk
FOREIGN KEY (sk_order_distribution_channel)
REFERENCES public.dim_order_distribution_channel (sk_order_distribution_channel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_order_put_channel_ft_order_fk
FOREIGN KEY (sk_order_put_channel)
REFERENCES public.dim_order_put_channel (sk_order_put_channel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_supplier_ft_order_fk
FOREIGN KEY (sk_supplier)
REFERENCES public.dim_supplier (sk_supplier)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_customer_ft_costumer_order_fk
FOREIGN KEY (sk_customer)
REFERENCES public.dim_customer (sk_customer)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_date_ft_order_fk
FOREIGN KEY (sk_date)
REFERENCES public.dim_date (sk_date)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_customer_order ADD CONSTRAINT dim_product_ft_order_fk
FOREIGN KEY (sk_product)
REFERENCES public.dim_product (sk_product)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;