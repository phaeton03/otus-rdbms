## Функции Lag и CTE

Создаем таблицу statistic
```sql
CREATE TABLE if not exists statistic(
player_name VARCHAR(100) NOT NULL,
player_id INT NOT NULL,
year_game SMALLINT NOT NULL CHECK (year_game > 0),
points DECIMAL(12,2) CHECK (points >= 0),
PRIMARY KEY (player_name,year_game)
);
```

Наполняем данными таблицу statistic
```sql
INSERT INTO
statistic(player_name, player_id, year_game, points)
VALUES
('Mike',1,2018,18),
('Jack',2,2018,14),
('Jackie',3,2018,30),
('Jet',4,2018,30),
('Luke',1,2019,16),
('Mike',2,2019,14),
('Jack',3,2019,15),
('Jackie',4,2019,28),
('Jet',5,2019,25),
('Luke',1,2020,19),
('Mike',2,2020,17),
('Jack',3,2020,18),
('Jackie',4,2020,29),
('Jet',5,2020,27);
```

Запрос суммы очков с группировкой и сортировкой по годам
```sql
SELECT sum(points), year_game FROM public.statistic group by year_game order by year_game;
```

Запрос суммы очков с группировкой и сортировкой по годам используя CTE
```sql
with cte as (SELECT sum(points), year_game FROM public.statistic group by year_game order by year_game)

select sum, year_game from cte;
```

Используя функцию LAG вывести кол-во очков по всем игрокам за текущий код и за предыдущий.
```sql
SELECT player_name, lag(points) over(partition by player_name order by year_game) as points_prev_year,
points, year_game FROM public.statistic
```