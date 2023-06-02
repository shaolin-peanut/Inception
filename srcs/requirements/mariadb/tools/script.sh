#!/bin/bash
set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then

# start mariadb
mysqld_safe --datadir=/var/lib/mysql --user=mysql --bind-address=0.0.0.0 &

# wait for mariadb to start
# until mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} ping >/dev/null 2>&1; do
#     sleep 1
# done
until mysqladmin -u root -p'' ping >/dev/null 2>&1; do
    sleep 1
done

# mysqladmin -u root password '${MYSQL_ROOT_PASSWORD}'


# mysql -u root -p${MYSQL_ROOT_PASSWORD} <<- EOF
mysql -u root -p'' <<- EOF
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
    DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER}@'%';
    FLUSH PRIVILEGES;
EOF

    # CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    # CREATE USER IF NOT EXISTS ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    # GRANT ALL PRIVILEGES ON ${MSYQL_DATABASE}.* TO ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    # ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    # FLUSH PRIVILEGES;

    # kill process
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

fi

# start MariaDB again, in the background
mysqld_safe --datadir=/var/lib/mysql --user=mysql &

# restart (so that root pswd is integrated)
# exec /usr/bin/mysqld_safe
# wait
wait