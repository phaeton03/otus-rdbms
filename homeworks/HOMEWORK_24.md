## DML в MySQL

inner join 
```sql
select p.id, p.name, p.description, m.name 
from products p
join manufactures m
on p.fk_manufacturer = m.id;
```

left join
```sql
select pl.price, pl.date, p.price 
from pricelist pl
left join price p
on p.id = pl.fk_price_id;
```

where price > 1000 - показываем список самых дорогих товаров 
```sql
select p.price 
from pricelist_products plp
left join price p
on p.id = plp.fk_price_id
left join products pr
on plp.fk_product_id = pr.id
where price > 1000;
```

where price > 1000 and price < 1000 - показываем список товаров среднего ценового сегмента
```sql
select p.price, pr.name 
from pricelist_products plp
left join price p
on p.id = plp.fk_price_id
left join products pr
on plp.fk_product_id = pr.id
where price > 100 and price < 1000;
```

where between 100 and 1000 - тоже самое что и предыдущий запрос но только с применением оператора between 
```sql
select p.price, pr.name 
from pricelist_products plp
left join price p
on p.id = plp.fk_price_id
left join products pr
on plp.fk_product_id = pr.id
where between 100 and 1000
```

where pr.name in('Samsung galaxy','LG g4', 'iphone x') - показываем список товаров соответсвующих одному из критерию
```sql
select p.price, pr.name 
from pricelist_products plp
left join price p
on p.id = plp.fk_price_id
left join products pr
on plp.fk_product_id = pr.id
where pr.name in('Samsung galaxy','LG g4', 'iphone x');
```

WHERE extract(YEAR FROM pl.date) > 2018 - показываем как менялась цена на товары после 2018 года
```sql
SELECT p.price, pl.price, extract(YEAR FROM pl.date), pr.name
FROM pricelist_products plp
left join price p
on p.id = plp.fk_price_id
left join pricelist pl
on plp.fk_pricelist_id = pl.id
left join products pr
on plp.fk_product_id = pr.id
WHERE extract(YEAR FROM pl.date) > 2018;
```

where pr.description is not null - покажем все товары у которых отсутсвует описание 
```sql
select pr.name 
from products pr
where pr.description is not null;
```

