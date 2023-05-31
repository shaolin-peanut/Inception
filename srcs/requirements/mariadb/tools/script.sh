#!/bin/bash
set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# wait for mariadb to start
until mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} ping >/dev/null 2>&1; do
    sleep 1
done

chown -R mysql:mysql /var/lib/mysql
chmod 644 /var/lib/mysql

# start mariadb
mysqld_safe --datadir=/var/lib/mysql --user=mysql &

mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<- EOF
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
    DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER ${MYSQL_USER}@'%' IDENTIFIED BY 9999;
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER}@'%';
    FLUSH PRIVILEGES;
EOF

    # kill process
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

# start MariaDB again, in the background
mysqld_safe --datadir=/var/lib/mysql --user=mysql &

# restart (so that root pswd is integrated)
# exec /usr/bin/mysqld_safe
# wait
wait