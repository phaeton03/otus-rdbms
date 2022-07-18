select id, name, phone, email, address_id from online_shop.clients where email like '%mail.ru'

select id, name, phone, email, address_id from online_shop.clients where phone like '%111'

select p.id,
       p.name,
       m.name as manufacturer_name,
       cp.name
from online_shop.products p
right join online_shop.manufactures m on p.manufacturer = m.id
left join online_shop.category_products cp on p.category = cp.name

select p.id,
       p.name,
       m.name as manufacturer_name,
       cp.name
from online_shop.products p
join online_shop.manufactures m on p.manufacturer = m.id
join online_shop.category_products cp on p.category = cp.name

update online_shop.clients set name = upper(name)

update c set c.name = c.name || ' Н.' from online_shop.clients where c.name = 'НИКОЛАЙ'

update online_shop.suppliers s set s.name = m.name from select online_shop.manufactures m

update online_shop.suppliers s
set name = m.name
from online_shop.manufactures m where m.id = s.id

delete from online_shop.suppliers s
using online_shop.manufactures m where m.name = s.name

--удаление дубликатов
DELETE FROM
    online_shop.products p1
    USING online_shop.products p2
WHERE
    p1.id < p2.id
  AND p1.name = p2.name;
