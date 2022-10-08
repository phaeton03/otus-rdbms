## Хранимые процедуры и триггеры

Создаем пользователей 
```sql
CREATE ROLE 'execute_filter_products';
CREATE ROLE 'execute_get_orders';
GRANT EXECUTE ON PROCEDURE otus.filter_products TO 'execute_filter_products';
GRANT EXECUTE ON PROCEDURE otus.get_orders TO 'execute_get_orders';
CREATE USER client@localhost IDENTIFIED WITH caching_sha2_password BY '12345';
CREATE USER manager@localhost IDENTIFIED WITH caching_sha2_password BY '12345';
GRANT 'execute_filter_products' TO client@localhost;
GRANT 'execute_get_orders' TO manager@localhost;
```

Создать процедуру выборки товаров с использованием различных фильтров: категория, цена, производитель, различные дополнительные параметры
Также в качестве параметров передавать по какому полю сортировать выборку, и параметры постраничной выдачи
```sql
DELIMITER $$
    
CREATE procedure filter_products(category int unsigned, 
                                 manufacturer int unsigned, 
                                 price int unsigned, 
                                 sort_column varchar(20),
                                 lim int unsigned, 
                                 offs int unsigned)
BEGIN
    select p.id, p.name as product, m.name as manufacturer, cp.name as category, pr.price as price
    from products p
         left join manufactures m
              on p.fk_manufacturer = m.id
         left join category_products cp 
              on p.fk_category = cp.name
         left join prices pr 
              on pr.fk_product_id = p.id
         where (pr.price < price OR price is null) 
           AND (m.name = manufacturer OR manufacturer is null) 
           AND (cp.name = category OR category is null) 
         order by sort_column 
         limit lim 
         offset offs; 
END
$$
```

Создать процедуру get_orders - которая позволяет просматривать отчет по продажам за определенный период (час, день, неделя)
с различными уровнями группировки (по товару, по категории, по производителю)
```sql
DELIMITER $$
    
CREATE procedure get_orders(date_from TIMESTAMP, date_to TIMESTAMP, group_col varchar(20))

BEGIN
    select s.id, s.date 
    from sales s 
        left join products p 
            on s.fk_product_id = p.id
        left join category_products cp
                  on p.fk_category = cp.name
    where s.date between date_from AND COALESCE(date_to, now()) 
    group by group_col;
END
$$
```