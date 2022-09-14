## Скрипты для создания схемы, роли и таблиц в базе

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
id int primary key auto_increment,
name varchar(50) not null
);
```

```sql
create table if not exists manufactures(
id int primary key auto_increment,
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
id int primary key auto_increment,
name varchar(50) not null,
fk_manufacturer int not null,
fk_category varchar(50) not null,
desc json,    
foreign key(manufacturer) references online_shop.manufactures(id),
foreign key(category) references online_shop.category_products(name)
);
```

```sql
create table if not exists prices(
id int primary key auto_increment,
fk_product_id int not null,
foreign key(product_id) references online_shop.products(id)
);
```

```sql
create table if not exists pricelist(
id int primary key auto_increment,
date timestamp not null
);
```

```sql
create table if not exists pricelist_products(
id int primary key auto_increment,
fk_product_id int not null,
fk_price_id int not null,
fk_pricelist_id int not null,
);
```

```sql
create table if not exists address(
id int primary key auto_increment,
home varchar(50) not null,
street varchar(50) not null,
city varchar(50) not null
);
```

```sql
create table if not exists clients(
id int primary key auto_increment,
name varchar(25) not null,
phone varchar(15) not null unique,
email varchar(100) not null unique
);
```

```sql
create table if not exists order_status(
id int primary key auto_increment,
status enum not null
);
```

```sql
create table if not exists order(
id int primary key auto_increment,
fk_product_id int not null,
fk_status_id int not null,
fk_client_id int not null,
foreign key(product_id) references online_shop.products(id),
foreign key(status_id) references online_shop.order_status(id),
foreign key(client_id) references online_shop.clients(id),
start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP not null,
end_date timestamp
);
```
