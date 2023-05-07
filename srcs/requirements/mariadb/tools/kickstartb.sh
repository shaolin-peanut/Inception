#!/bin/bash
set -e
set -x

# Initialize the MariaDB data directory if doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

#start mariadb in the background
mysqld_safe --datadir=/var/lib/mysql --user=mysql &
# sleep 5
# & mysql_pid=$!

# Wait for MariaDB to become available
# mysqladmin --wait=30 ping >/dev/null 2>&1
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

# Run SQL commands
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Stop the background MariaDB process
# kill "$mysql_pid"

# Wait for the MariaDB process to stop completely
# wait "$mysql_pid"

# Start MariaDB in the foreground
exec mysqld --user=mysql