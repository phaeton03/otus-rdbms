## Прогнозирование роста данных и анализ возможных проблем


   Предполагается, что интернет-магазин будет работать по всей России, с возможностью выхода на рынки СНГ
Соотвественно при благоприятном сценарии количество пользователей может насчитывать 10% от населения региона, 
с экспоненциальным ростом генерируемых пользователями данных.
    Таблицы products_category, manufactures, products, clients и address меняться будут реже 
всего. Эти данные можно закешировать используя инструменты inmemory хранилищ Tarantool, что снизит нагрузку на MySQL базу 
данных. С ростом количества пользователей возрастет количество запросов к базе на чтение по всем таблицам, для решения 
этой проблемы будем использовать механизм полусихронной репликации по типу Master-slave на основе GTID. Все 
изменения будут передаваться с помощью Row Based Replication.
    Бекап будем делать без остановки базы данных, физический через утилиту percona xtrabackup. Полную копию будем делать
раз в неделю, а инкрементальную копию каждый день.
    Чтобы каждый раз не читать таблицу price_list целиком за все время, можно использовать партицирование по дате, например 
за каждый месяц.
    Настройка мониторинга для диагностики состояния сервера. 
    При увеличение количества одновременных соединений в настройках MySQL max_connections можно поменять значение со 100
на скажем 500 или до нужного нам уровня.   