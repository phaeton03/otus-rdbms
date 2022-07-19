create index products_dx on online_shop.products(manufacturer);

explain(costs, verbose,format json)
select * from online_shop.products p
left join online_shop.manufactures m on p.manufacturer = m.id;

create index category_dx on online_shop.products(category);

create index street_dx on online_shop.address(street);

set enable_seqscan=false;

explain(costs, verbose, format json)
select id, home, street, city from online_shop.address where street like '400%'

create index address_dx on online_shop.address ((home || ' ' || street || ' ' || city));

explain(costs, verbose, format json)
select *
from online_shop.address
where (home || ' ' || street || ' ' || city) = '30 Зеленый пр-кт Москва';




