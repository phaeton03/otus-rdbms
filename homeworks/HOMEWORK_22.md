## Типы данных в MySQL

Во всех таблица параметр id заменен на 'id int unsigned primary key auto_increment' 
вместо 'id bigint primary key generated always as identity' в POSTGRESQL
auto_increment - играет роль generated always as identity
bigint заменен на int потому что предполагается что записей будет меньше 100 млн
unsigned - числа в id могут быть только положительными

В таблицу products добавил поле description типа json, для складывания в него неструктуированных данных.
Такого как описание продукта. Пример приведен ниже после скрипта на создание таблицы

В качестве формата даты в таблицах взят timestamp. 


Создаем БД отус
```sql
create database otus;
USE otus;
```

Создаем роль otus_developer.
Даем данной роли все разрешения в рамках БЗ otus
Создаем user
Присваиваем user роль otus_developer
```sql
CREATE ROLE 'otus_developer';
GRANT ALL ON otus.* TO 'otus_developer';
CREATE USER niko@localhost IDENTIFIED WITH caching_sha2_password BY '12345';
GRANT 'otus_developer' TO niko@localhost;
```

```sql
create table if not exists suppliers(
id int unsigned primary key auto_increment,
name varchar(50) not null
);
```

```sql
create table if not exists manufactures(
id int unsigned primary key auto_increment,
name varchar (50) not null
);
```

```sql
create table if not exists category_products(
name varchar(50) primary key
);
```

```sql
create table if not exists products(
id int unsigned primary key auto_increment,
name varchar(50) not null,
fk_manufacturer int unsigned not null,
fk_category varchar(50) not null,
description json,    
foreign key(fk_manufacturer) references manufactures(id),
foreign key(fk_category) references category_products(name)
);
```

```sql
insert into products (name, fk_manufacturer, fk_category, description) 
    VALUES ('TV', 1, 1, JSON_OBJECT('TV', 'Samsung',
                                    'Functions', JSON_ARRAY('WI-Fi', 'Smart-TV', 'Sim'),
                                    'body', '100 x 150 x 30 cm',
                                    'screen', '55')
    );
```

```sql
create table if not exists prices(
id int unsigned primary key auto_increment,
price decimal,
fk_product_id int unsigned not null,
foreign key(fk_product_id) references products(id)
);
```

```sql
create table if not exists pricelist(
id int unsigned primary key auto_increment,
price decimal, 
date timestamp not null
);
```

```sql
create table if not exists pricelist_products(
id int unsigned primary key auto_increment,
fk_product_id int unsigned not null,
fk_price_id int unsigned not null,
fk_pricelist_id int unsigned not null
);
```

```sql
create table if not exists address(
id int unsigned primary key auto_increment,
home varchar(50) not null,
street varchar(50) not null,
city varchar(50) not null
);
```

```sql
create table if not exists clients(
id int unsigned primary key auto_increment,
name varchar(25) not null,
phone varchar(15) not null unique,
email varchar(100) not null unique
);
```

```sql
create table if not exists order_status(
id int unsigned primary key auto_increment,
status enum('READY','NOT_READY', 'PENDING', 'IN_TRANSITION'));
```

```sql
create table if not exists order_(
id int unsigned primary key auto_increment,
fk_product_id int unsigned not null,
fk_status_id int unsigned not null,
fk_client_id int unsigned not null,
foreign key(fk_product_id) references products(id),
foreign key(fk_status_id) references order_status(id),
foreign key(fk_client_id) references clients(id),
start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP not null,
end_date timestamp
);
```

```sql
create table if not exists sales(
id int unsigned primary key auto_increment,
fk_product_id int unsigned not null,
fk_client_id int unsigned not null,
foreign key(fk_product_id) references products(id),
foreign key(fk_client_id) references clients(id),
date TIMESTAMP DEFAULT CURRENT_TIMESTAMP not null
);
```
