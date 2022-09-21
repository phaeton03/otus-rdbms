## Агрегация и сортировка в MySQL

```sql
select
    if(grouping(p.fk_category),'Total items from all categories', p.fk_category) as category,
    max(price) max_price,
    min(price) min_price,
    count(1) as qty
from prices
         left join products p on prices.fk_product_id = p.id
group by fk_category with rollup
having min_price > 99;
```

```sql
select
    max(price) max_price,
    min(price) min_price,
    count(1) as qty,
    case
        when price <= 500 then 'low-end-price'
        when price > 500 AND price <= 1000 then 'middle-end-price'
        when price > 1000 then 'high-end-price'
        end price_category
from prices
         left join products p on prices.fk_product_id = p.id
group by price_category with rollup;
```