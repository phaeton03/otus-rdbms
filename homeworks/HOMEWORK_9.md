## Индексы PostgreSQL

Создание b-tree иднекса на таблицу products поле FK manufacturer
```sql
create index products_dx on online_shop.products(manufacturer);

explain(costs, verbose,format json)
select * from online_shop.products p
left join online_shop.manufactures m on p.manufacturer = m.id;
```
#### Запросы по продуктам без индекса
![Выполнение запроса по продуктам без индекса](/resources/products.png)
![Explain запроса по продуктам без индекса](/resources/explain_products.png)
#### Запросы по продуктам с индексом 
![Выполнение запроса по продуктам с индексом](/resources/products_dx.png)
![Explain запроса по продуктам с индексом](/resources/explain_products_dx.png)

Создание индекса для полнотекстового поиска
```sql
create index street_text_dx on online_shop.address
USING GIN (to_tsvector('russian',street));

explain(costs, verbose, format json)
select home, street, city from online_shop.address 
where to_tsvector('russian',street) @@ to_tsquery('пр-кт')  
```

#### Поиск по тексту в таблице address без индекса 
![Выполнение поиска по тексту в таблице address без индекса](/resources/fulltext_search.png)
#### Поиск по тексту в таблице address с индексом
![Выполнение поиска по тексту в таблице address с индексом](/resources/fulltext_search_dx.png)


Создание индекса по выражению (home || ' ' || street || ' ' || city)
```sql
create index address_dx on online_shop.address ((home || ' ' || street || ' ' || city));

explain(costs, verbose, format json)
select *
from online_shop.address
where (home || ' ' || street || ' ' || city) = '30 Зеленый пр-кт Москва';
```

#### Поиск по тексту в таблице address по выражению без индекса
![Выполнение поиска по тексту в таблице address по выражению](/resources/search_by_func.png)
![Explain запроса по тексту в таблице address без индекса](/resources/explain_search_by_func.png)
#### Поиск по тексту в таблице address по выражению c индексом
![Выполнение поиска по тексту в таблице address с индексом](/resources/address_dx.png)
![Explain запроса по тексту в таблице address с индексом](/resources/explain_address_dx.png)

Создание составного индекса на таблицу address
```sql
create index full_address_dx on online_shop.address(city, street, home);

explain(costs, verbose, format json)
select *
from online_shop.address
where city = 'Moscow' and home = '30' 
```

#### Поиск по тексту в таблице address по нескольким полям без индекса
![Explain запроса по тексту в таблице address без индекса](/resources/address_composite.png)
#### Поиск по тексту в таблице address по нескольким полям c индексом
![Выполнение поиска по тексту в таблице address с индексом](/resources/address_dx.png)
![Explain запроса по тексту в таблице address с индексом](/resources/explain_address_dx.png)