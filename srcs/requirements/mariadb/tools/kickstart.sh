#!/bin/bash
set -e
# set -x

echo "mariadb-server mysql-server/root_password password root123" | debconf-set-selections
echo "mariadb-server mysql-server/root_password_again password root123" | debconf-set-selections

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi
chown -R mysql:mysql /var/lib/mysql

# START MYSQL
# /usr/bin/mysqld_safe &
mysqld_safe --datadir=/var/lib/mysql --user=mysql --bind-address=0.0.0.0 &
# mysqld --user=mysql

# wait for mariadb to start
until mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} ping >/dev/null 2>&1; do
	sleep 1
done

#until mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
#    sleep 1
#done

# set root pswd
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"

#mysqladmin ping;
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root -e "FLUSH PRIVILEGES;"

# kill process
# mysqladmin shutdown
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

# start MariaDB again, in the background
mysqld_safe --datadir=/var/lib/mysql --user=mysql &
#mysqld_safe --datadir=/var/lib/mysql --user=mysql

# restart (so that root pswd is integrated)
# exec /usr/bin/mysqld_safe
# wait
wait