insert into online_shop.suppliers values('zvedochka') returning name;
insert into online_shop.suppliers values('eldorado');
insert into online_shop.suppliers values('mvideo') returning id, name;

insert into online_shop.manufactures (name) values ('samsung');
insert into online_shop.manufactures (name) values ('apple');
insert into online_shop.manufactures (name) values ('xiaomi');
insert into online_shop.manufactures (name) values ('sony');

insert into online_shop.category_products values ('laptop')
insert into online_shop.category_products values ('smartphone')
insert into online_shop.category_products values ('accessories')
insert into online_shop.category_products values ('games')

insert into online_shop.products (name, manufacturer, category) values ('macbook-16', 2,'laptop');
insert into online_shop.products (name, manufacturer, category) values ('macbook-14', 2,'laptop');
insert into online_shop.products (name, manufacturer, category) values ('iphoneX', 2, 'smartphone');
insert into online_shop.products (name, manufacturer, category) values ('iphone8', 2, 'smartphone');
insert into online_shop.products (name, manufacturer, category) values ('ultrabook', 1, 'laptop');
insert into online_shop.products (name, manufacturer, category) values ('minote', 3, 'smartphone');
insert into online_shop.products (name, manufacturer, category) values ('godOfWar', 4, 'games');
insert into online_shop.products (name, manufacturer, category) values ('mouse', 1, 'accessories');

insert into online_shop.prices (product_id, price) values (1, 250000.00)
insert into online_shop.prices (product_id, price) values (2, 150000.00)
insert into online_shop.prices (product_id, price) values (3, 100000.00)
insert into online_shop.prices (product_id, price) values (4, 60000.00)
insert into online_shop.prices (product_id, price) values (5, 120000.00)
insert into online_shop.prices (product_id, price) values (6, 40000.00)
insert into online_shop.prices (product_id, price) values (7, 4000.00)
insert into online_shop.prices (product_id, price) values (8, 2000.00)

insert into online_shop.address (home, street, city) values (30, 'Зеленый пр-кт', 'Москва');
insert into online_shop.address (home, street, city) values (18, 'Кутузовский пр-кт', 'Москва');
insert into online_shop.address (home, street, city) values (30, 'Андропова пр-кт', 'Москва');
insert into online_shop.address (home, street, city) values (5, 'ул Ленина', 'Санкт-Петербург');

insert into online_shop.clients (name, phone, email, address_id) values ('Павел', '+788899910011','pavel@mail.ru', 1);
insert into online_shop.clients (name, phone, email, address_id) values ('Николай', '+788899141111','niko@mail.ru', 2);
insert into online_shop.clients (name, phone, email, address_id) values ('Сергей', '+788899977111','serg@mail.ru', 3);
insert into online_shop.clients (name, phone, email, address_id) values ('Володя', '+788899988111','volodya@mail.ru', 4);