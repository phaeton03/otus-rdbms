## Скрипты DML

Поиск всех имейлов заканчивающихся на mail.ru
```sql
select id, name, phone, email, address_id from online_shop.clients where email like '%mail.ru'
```

Поиск всех номеров телефонов заканчивающихся на 111
```sql
select id, name, phone, email, address_id from online_shop.clients where phone like '%111'
```

Запрос с внешним джойном 
```sql
select p.id,
p.name,
m.name as manufacturer_name,
cp.name
from online_shop.products p
right join online_shop.manufactures m on p.manufacturer = m.id
left join online_shop.category_products cp on p.category = cp.name
```

Запрос с внутренним джоином
```sql
select p.id,
p.name,
m.name as manufacturer_name,
cp.name
from online_shop.products p
join online_shop.manufactures m on p.manufacturer = m.id
join online_shop.category_products cp on p.category = cp.name
```
Вывод: при внутреннем джоине мы делаем соединение только по тем полям которые есть в обоих таблицах. 
Внешний джоин соединяет всю таблицу и для тех полей для которых не нашлось соединение проставляет null

```sql
update online_shop.clients set name = upper(name)
```

```sql
update c set c.name = c.name || ' Н.' from online_shop.clients where c.name = 'НИКОЛАЙ'
```

```sql
update online_shop.suppliers s set s.name = m.name from select online_shop.manufactures m
```

```sql
update online_shop.suppliers s
set name = m.name
from online_shop.manufactures m where m.id = s.id
```

```sql
delete from online_shop.suppliers s
using online_shop.manufactures m where m.name = s.name
```

удаление дубликатов по имени
```sql
DELETE FROM
online_shop.products p1
USING online_shop.products p2
WHERE
p1.id < p2.id
AND p1.name = p2.name;
```

Операции по добавлению элементов в таблицу

```sql
insert into online_shop.suppliers values('zvedochka') returning name;
insert into online_shop.suppliers values('eldorado');
insert into online_shop.suppliers values('mvideo') returning id, name;
```