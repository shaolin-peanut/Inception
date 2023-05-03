#!/bin/bash
set -e
set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# chown -R mysql:mysql /usr/bin/mysqld
chown -R mysql:mysql /var/lib/mysql

/usr/bin/mysqld_safe &
# mysqld --user=mysql

# wait for mariadb to start
until mysqladmin ping >/dev/null 2>&1; do
	sleep 1
done

# set root pswd
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "SET PASSWORD FOR 'root'@'%' = PASSWORD('${MARIADB_ROOT_PASSWORD}');"
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "DROP USER 'root'@'localhost';"
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

echo "MYSQL_DATABASE: $MYSQL_DATABASE"
echo "MYSQL_USER: $MYSQL_USER"
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"

# set root pswd
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"

mysqladmin ping || { echo 'MySQL server is not running' ; exit 1; }
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -vvv -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" || { echo 'Failed to create database' ; exit 1; }
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" || { echo 'Failed to create user' ; exit 1; }
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" || { echo 'Failed to grant privileges' ; exit 1; }
# mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;"
# mysql  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" || { echo 'Failed to alter user' ; exit 1; }
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# kill process
# mysqladmin shutdown
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

# start MariaDB again, in the background
mysqld_safe --datadir=/var/lib/mysql --user=mysql &

# restart (so that root pswd is integrated)
# exec /usr/bin/mysqld_safe
# wait
wait