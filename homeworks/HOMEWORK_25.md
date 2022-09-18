## Транзакции в MySQL


Создаем новый заказ и сразу же обновляем статус
```sql
DELIMITER $$
    
CREATE procedure create_new_order(product_id int unsigned, client_id int unsigned)
BEGIN
  start transaction;
      insert into order_status(enum) values ('WAITING');
      SET @status_id = mysql_insert_id();  
      insert into order_(product_id, client_id, status_id);
  commit;   
END
$$
```

#### Загрузка данных

```sql
create database otus_load_mysql;
USE otus_load_mysql;
```

```sql
create table if not exists apparel(
id int unsigned primary key auto_increment,
handle varchar(50) not null,
title varchar(50),
body text,
vendor varchar(100),
type_ varchar(50),    
tags varchar(50),   
published boolean,
option1_name varchar(50),
option1_value varchar(50),
option2_name varchar(50),
option2_value varchar(50),
option3_name varchar(50),
option3_value varchar(50),
variant_sku varchar(50),
variant_grams int,
variant_inventory_tracker varchar(50),
variant_inventory_qty int,
variant_inventory_policy varchar(50),
variant_fulfillment_service varchar(50),
variant_price decimal,
variant_compare_at_price decimal,
variant_requires_shipping boolean,
variant_taxable boolean,
variant_barcode text,
img_source text,
img_all_text text,
gift_card boolean,
seo_title varchar(100),
seo_description text,
google_product_category text,
gender text,
age_group text,
mpn text,
adwords_grouping text,
adwords_label text,
condition_ text,
custom_product text,
custom_label_1 text,
custom_label_2 text,
custom_label_3 text,
custom_label_4 text,
variant_image text,
variant_weight_unit varchar(20) 
);
```

```sql
LOAD DATA INFILE '/var/lib/mysql-files/test.csv'
	 INTO TABLE apparel
 	 LINES TERMINATED BY '\n';
```

Загрузка данных через утилиту mysqlimport
`mysqlimport otus_load_mysql 
                    --lines-terminated-by="\n" 
                    --fields-terminated-by="," 
                    --fields-enclosed-by="\""  
                    -c body "/var/lib/mysql-files/test.csv"`

```sql
select * from test;
```