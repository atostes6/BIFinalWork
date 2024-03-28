
CREATE TABLE public.payment_type (
                payment_type_id INTEGER NOT NULL,
                payment_type_description VARCHAR(50) NOT NULL,
                CONSTRAINT payment_type_id PRIMARY KEY (payment_type_id)
);


CREATE TABLE public.payment_provider (
                payment_provider_id INTEGER NOT NULL,
                payment_provider_type_id INTEGER NOT NULL,
                payment_provider_name VARCHAR(100) NOT NULL,
                CONSTRAINT payment_provider_id PRIMARY KEY (payment_provider_id)
);


CREATE TABLE public.put_channel_type (
                put_channel_type_id INTEGER NOT NULL,
                put_channel_type_description VARCHAR(100) NOT NULL,
                CONSTRAINT put_channel_type_id PRIMARY KEY (put_channel_type_id)
);
COMMENT ON COLUMN public.put_channel_type.put_channel_type_description IS 'Wholesale, Retail, Marketplace, Catalog, Distributor, Reseller, Internet, Indirect, B2B, Manufacturer, Direct sales, White label, Hybrid, Partnership, Ecommerce,  Brokers, Search engine optimization, Social media, Distribution, Affiliate sales, Mobile apps, Consultant, Indirect';


CREATE TABLE public.product_category (
                category_id INTEGER NOT NULL,
                name VARCHAR(100) NOT NULL,
                description VARCHAR(200),
                CONSTRAINT category_id PRIMARY KEY (category_id)
);


CREATE TABLE public.order_put_channel (
                order_put_channel_id INTEGER NOT NULL,
                order_put_channel_name VARCHAR(100) NOT NULL,
                put_channel_type_id INTEGER NOT NULL,
                CONSTRAINT order_put_channel_id PRIMARY KEY (order_put_channel_id)
);
COMMENT ON COLUMN public.order_put_channel.order_put_channel_name IS 'UOL MARKETPLACE
PONTO FRIO
CASAS BAHIA';


CREATE TABLE public.distribution_channel (
                distribution_channel_id INTEGER NOT NULL,
                distribution_channel_name VARCHAR(100) NOT NULL,
                distribution_channel_description VARCHAR(200),
                CONSTRAINT distribution_channel_id PRIMARY KEY (distribution_channel_id)
);
COMMENT ON COLUMN public.distribution_channel.distribution_channel_name IS 'UPS, FEDEX, USPS, AMAZON, DHL, SEDEX';


CREATE TABLE public.supplier (
                supplier_id INTEGER NOT NULL,
                supplier_name VARCHAR(50) NOT NULL,
                supplier_contact_email VARCHAR(100) NOT NULL,
                CONSTRAINT supplier_id PRIMARY KEY (supplier_id)
);


CREATE TABLE public.supplier_address (
                supplier_address_id INTEGER NOT NULL,
                supplier_id INTEGER NOT NULL,
                supplier_address_line1 VARCHAR(100) NOT NULL,
                supplier_address_line2 VARCHAR(100),
                supplier_address_line3 VARCHAR(100),
                state_province_county VARCHAR(50) NOT NULL,
                iso_country_code VARCHAR(3) NOT NULL,
                zip_code VARCHAR(9) NOT NULL,
                city_name VARCHAR(50) NOT NULL,
                CONSTRAINT supplier_address_id PRIMARY KEY (supplier_address_id)
);


CREATE TABLE public.customer (
                customer_id INTEGER NOT NULL,
                customer_first_name VARCHAR(50) NOT NULL,
                customer_last_name VARCHAR(50) NOT NULL,
                customer_gender VARCHAR(10) NOT NULL,
                customer_birth_date DATE,
                customer_email VARCHAR(100),
                CONSTRAINT customer_id PRIMARY KEY (customer_id)
);
COMMENT ON COLUMN public.customer.customer_gender IS 'MALE=''M''
FEMALE = ''F''
OTHER = ''O''';


CREATE TABLE public.order_details (
                order_details_id INTEGER NOT NULL,
                customer_id INTEGER NOT NULL,
                distribution_channel_id INTEGER NOT NULL,
                order_put_channel_id INTEGER NOT NULL,
                payment_details_id INTEGER,
                total_value DOUBLE PRECISION,
                created_at TIMESTAMP NOT NULL,
                modified_at TIMESTAMP NOT NULL,
                CONSTRAINT order_id PRIMARY KEY (order_details_id)
);


CREATE TABLE public.payment_details (
                payment_details_id INTEGER NOT NULL,
                order_details_id INTEGER NOT NULL,
                amount REAL NOT NULL,
                payment_provider_id INTEGER NOT NULL,
                payment_status INTEGER,
                created_at TIMESTAMP NOT NULL,
                modified_at TIMESTAMP NOT NULL,
                CONSTRAINT id PRIMARY KEY (payment_details_id)
);
COMMENT ON COLUMN public.payment_details.payment_status IS '-1 failed 
-2 reversed
0 in auth process 
999 payd';


CREATE TABLE public.shopping_session (
                shopping_session_id INTEGER NOT NULL,
                customer_id INTEGER NOT NULL,
                total_value REAL NOT NULL,
                created_at TIMESTAMP NOT NULL,
                modified_at TIMESTAMP NOT NULL,
                CONSTRAINT shopping_session_id PRIMARY KEY (shopping_session_id)
);


CREATE TABLE public.customer_address (
                customer_address_id INTEGER NOT NULL,
                customer_id INTEGER NOT NULL,
                line1 VARCHAR(100) NOT NULL,
                line2 VARCHAR(100),
                line3 VARCHAR(100),
                state_province_county VARCHAR(50) NOT NULL,
                iso_country_code VARCHAR(3) NOT NULL,
                zip_code VARCHAR(9) NOT NULL,
                city_name VARCHAR(50) NOT NULL,
                CONSTRAINT address_id PRIMARY KEY (customer_address_id)
);


CREATE TABLE public.customer_payment (
                customer_payment_id REAL NOT NULL,
                customer_id INTEGER NOT NULL,
                payment_type_id INTEGER NOT NULL,
                payment_provider_id INTEGER NOT NULL,
                account_number VARCHAR(50) NOT NULL,
                expire_date DATE NOT NULL,
                CONSTRAINT customer_payment_id PRIMARY KEY (customer_payment_id)
);


CREATE TABLE public.product (
                product_id INTEGER NOT NULL,
                category_id INTEGER NOT NULL,
                supplier_id INTEGER NOT NULL,
                product_name VARCHAR(100) NOT NULL,
                product_description VARCHAR(200),
                product_sku VARCHAR(50) NOT NULL,
                product_price REAL NOT NULL,
                CONSTRAINT product_id PRIMARY KEY (product_id)
);


CREATE TABLE public.cart_item (
                cart_item_id INTEGER NOT NULL,
                product_id INTEGER NOT NULL,
                shopping_session_id INTEGER NOT NULL,
                quantity INTEGER NOT NULL,
                created_at TIMESTAMP NOT NULL,
                modified_at TIMESTAMP NOT NULL,
                CONSTRAINT cart_item_id PRIMARY KEY (cart_item_id)
);


CREATE TABLE public.order_items (
                order_items_id INTEGER NOT NULL,
                product_id INTEGER NOT NULL,
                order_details_id INTEGER NOT NULL,
                quantity INTEGER NOT NULL,
                total_item_cost REAL NOT NULL,
                created_at TIMESTAMP NOT NULL,
                modified_at TIMESTAMP NOT NULL,
                CONSTRAINT order_items_id PRIMARY KEY (order_items_id)
);


ALTER TABLE public.customer_payment ADD CONSTRAINT payment_type_id_customer_payment_fk
FOREIGN KEY (payment_type_id)
REFERENCES public.payment_type (payment_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.payment_provider ADD CONSTRAINT payment_type_id_payment_provider_fk
FOREIGN KEY (payment_provider_type_id)
REFERENCES public.payment_type (payment_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.customer_payment ADD CONSTRAINT payment_provider_customer_payment_fk
FOREIGN KEY (payment_provider_id)
REFERENCES public.payment_provider (payment_provider_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.payment_details ADD CONSTRAINT payment_provider_payment_details_fk
FOREIGN KEY (payment_provider_id)
REFERENCES public.payment_provider (payment_provider_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_put_channel ADD CONSTRAINT channel_type_order_channel_fk
FOREIGN KEY (put_channel_type_id)
REFERENCES public.put_channel_type (put_channel_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.product ADD CONSTRAINT product_category_product_fk
FOREIGN KEY (category_id)
REFERENCES public.product_category (category_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_details ADD CONSTRAINT order_channel_order_details_fk
FOREIGN KEY (order_put_channel_id)
REFERENCES public.order_put_channel (order_put_channel_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_details ADD CONSTRAINT distribution_channel_order_details_fk
FOREIGN KEY (distribution_channel_id)
REFERENCES public.distribution_channel (distribution_channel_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.product ADD CONSTRAINT supplier_product_fk
FOREIGN KEY (supplier_id)
REFERENCES public.supplier (supplier_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.supplier_address ADD CONSTRAINT supplier_supplier_address_fk
FOREIGN KEY (supplier_id)
REFERENCES public.supplier (supplier_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.customer_payment ADD CONSTRAINT customer_customer_payment_fk
FOREIGN KEY (customer_id)
REFERENCES public.customer (customer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.customer_address ADD CONSTRAINT customer_address_fk
FOREIGN KEY (customer_id)
REFERENCES public.customer (customer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.shopping_session ADD CONSTRAINT customer_shopping_session_fk
FOREIGN KEY (customer_id)
REFERENCES public.customer (customer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_details ADD CONSTRAINT customer_order_details_fk
FOREIGN KEY (customer_id)
REFERENCES public.customer (customer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.payment_details ADD CONSTRAINT order_details_payment_details_fk
FOREIGN KEY (order_details_id)
REFERENCES public.order_details (order_details_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_items ADD CONSTRAINT order_details_order_items_fk
FOREIGN KEY (order_details_id)
REFERENCES public.order_details (order_details_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cart_item ADD CONSTRAINT shopping_session_cart_item_fk
FOREIGN KEY (shopping_session_id)
REFERENCES public.shopping_session (shopping_session_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_items ADD CONSTRAINT product_order_items_fk
FOREIGN KEY (product_id)
REFERENCES public.product (product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cart_item ADD CONSTRAINT product_cart_item_fk
FOREIGN KEY (product_id)
REFERENCES public.product (product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;