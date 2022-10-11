## Резервное копирование и восстановление 

Создаем пользователя для backup и restore 
```sql
CREATE ROLE 'backup';
GRANT SELECT, BACKUP_ADMIN, RELOAD, PROCESS, SUPER, REPLICATION CLIENT ON otus_backup.* TO 'backup';

CREATE USER backup_user@localhost IDENTIFIED WITH caching_sha2_password BY '12345';
GRANT 'backup' TO backup_user@localhost;
```

Восстановим структуру таблицы из дампа базы
```sql
mysql -h localhost -P 3309 -u backup_user -p -e "create database world2; show databases;"
mysql -hlocalhost -P 3309 -u backup_user -p -e "use world2";
worldBackup="/mnt/c/Users/nnikolskiy/Downloads/world_db-195395-3b193e.sql"
mysql -hlocalhost -P 3309 -p -u backup_user world2 < $worldBackup    
```

Расшифровка и разахривация бекап файла
```sql
sudo cp /mnt/c/Users/nnikolskiy/Downloads/backup_des.xbstream.gz.des3 /tmp/backup
openssl des3 -salt -k "password" -d -in backup_des.xbstream.gz.des3 -out backup_des.xbstream.gz
gzip -d backup_des.xbstream.gz    
```

Извлечение файлов из бекапа утилитой xtrabackup
```sql
xbstream -x < backup_des.xbstream
```

Подготовка файлов бекапа
`xtrabackup --prepare --target-dir=/tmp/backup`

Заполняем содержимое бекапа директорию в mysql
`sudo xtrabackup --copy-back --target-dir=/tmp/backup --datadir=/var/lib/mysql`

Меняем владельца с root на mysql
`chown -R mysql:mysql /var/lib/mysql`
