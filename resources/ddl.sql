create database otus;

create role nikoniko SUPERUSER;

create schema if not exists online_shop;

create table if not exists online_shop.suppliers(
    id bigint primary key generated always as identity,
    name varchar(50) not null
);

create table if not exists online_shop.manufactures(
    id bigserial primary key,
    name varchar (50) not null
);

create table if not exists online_shop.category_products(
    name varchar(50) primary key;
)

create table if not exists online_shop.products(
    id bigserial primary key
    name varchar(50) not null,
    manufacturer bigint not null,
    category varchar(50) not null,
    foreign key(manufacturer) references online_shop.manufactures(id),
    foreign key(category) references online_shop.category_products(name)
)

create table if not exists online_shop.prices(
    id bigint primary key generated always as identity,
    product_id bigint not null,
    price numeric,
    foreign key(product_id) references online_shop.products(id)
)

create table if not exists online_shop.address(
    id bigint primary key generated always as identity,
    home varchar(50) not null,
    street varchar(50) not null,
    city varchar(50) not null
)

create table if not exists online_shop.clients(
    id bigint primary key generated always as identity,
    name varchar(25) not null,
    phone varchar(15) not null unique,
    email varchar(100) not null unique,
    address_id bigint not null,
    foreign key(address_id) references online_shop.address(id)
)

create table if not exists online_shop.order_status(
    id bigint primary key generated always as identity,
    status varchar(50) not null
)

create table if not exists online_shop.order(
    id bigint primary key generated always as identity,
    product_id bigint not null,
    status_id bigint not null,
    client_id bigint not null,
    foreign key(product_id) references online_shop.products(id),
    foreign key(status_id) references online_shop.order_status(id),
    foreign key(client_id) references online_shop.clients(id),
    start_date timestamp not null,
    end_date timestamp
)