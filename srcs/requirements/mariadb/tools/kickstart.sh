#!/bin/bash
set -e
set -x

echo "mariadb-server mysql-server/root_password password root123" | debconf-set-selections
echo "mariadb-server mysql-server/root_password_again password root123" | debconf-set-selections

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi
chown -R mysql:mysql /var/lib/mysql

# start mariadb
mysqld_safe --datadir=/var/lib/mysql --user=mysql --bind-address=0.0.0.0 &

# wait for mariadb to start
until mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} ping >/dev/null 2>&1; do
	sleep 1
done

mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;"
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# create, user and grant priv
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "SET @@GLOBAL.sql_mode='';"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
# mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "SELECT COUNT(*) FROM mysql.user WHERE user='${MYSQL_USER}';" | grep -q 1 || mysql -uroot -p${MYSQL_ROOT_PASSWORD} -vvv -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;";

# kill process
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

# start MariaDB again, in the background
mysqld_safe --datadir=/usr --user=mysql &

# restart (so that root pswd is integrated)
# exec /usr/bin/mysqld_safe
# wait
wait
