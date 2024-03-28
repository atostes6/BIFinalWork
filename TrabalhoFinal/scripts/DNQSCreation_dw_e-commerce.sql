---DNQ dim_customer
INSERT INTO dim_customer (sk_customer, nk_customer, customer_name, customer_city_name, customer_gender, customer_birth_date, customer_state_province_county, customer_country_iso_code, etl_begin_date, etl_end_date, etl_version) 
VALUES (0, 0, 'NA', 'NA', 'NA', '1900-01-01', 'NA', 0, '1900-01-01', '1900-01-01', 0); 

---DNQ dim_supplier
INSERT INTO dim_supplier (sk_supplier, nk_supplier, supplier_name, supplier_city_name, supplier_state_province_county, supplier_iso_country_code,  etl_begin_date, etl_end_date, etl_version) 
VALUES (0, 0, 'NA','NA', 'NA', 'NA', '1900-01-01', '1900-01-01', 0);

---DNQ dim_product
INSERT INTO dim_product (sk_product, nk_product, product_category_id, product_sku, product_name, product_supplier_id, product_description, product_category_name, product_category_description, product_price, etl_begin_date, etl_end_date, etl_version) 
VALUES (0, 0, 0, 'NA', 'NA', 0, 'NA', 'NA', 'NA', 0,  '1900-01-01', '1900-01-01', 0);

---DNQ dim_order_distribution_channel
INSERT INTO dim_order_distribution_channel (sk_order_distribution_channel, nk_order_distribution_channel, order_distribution_channel_name, order_distribution_channel_description, etl_begin_date, etl_end_date, etl_version) 
VALUES (0, 0, 'NA', 'NA', '1900-01-01', '1900-01-01', 0);
 
 ---DNQ dim_order_put_channel
INSERT INTO dim_order_put_channel (sk_order_put_channel, nk_order_put_channel, order_put_channel_name, order_put_channel_description, etl_begin_date, etl_end_date, etl_version) 
VALUES (0, 0, 'NA', 'NA', '1900-01-01', '1900-01-01', 0);
 
 ---DNQ dim_payment_details
INSERT INTO dim_payment_details
(sk_payment_details, 
 nk_payment_details, 
 payment_provider_name, 
 payment_provider_type_id, 
 amount, created_at, 
 modified_at, 
 payment_type_description, 
 etl_begin_date, 
 etl_end_date, 
 etl_version) 
VALUES (0, 0, 'NA', 0, 0.0, '1900-01-01', '1900-01-01', 'NA', '1900-01-01', '1900-01-01', 0); 

---DNQ dim_order_items
INSERT INTO dim_order_items
(sk_order_items, 
 nk_order_items, 
 product_id,
 item_quantity,
 item_price,
 total_item_price,
  etl_begin_date, 
 etl_end_date, 
 etl_version) 
VALUES (0, 0, 0, 0, 0.0, 0.0, '1900-01-01', '1900-01-01', 0); 