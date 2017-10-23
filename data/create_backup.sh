# Backup
docker exec -i mysql-santrod bash -c 'mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"' > santrod.sql
