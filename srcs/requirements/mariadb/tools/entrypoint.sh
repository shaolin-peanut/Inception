#!/bin/bash
set -e

# wait

# Change ownership of the /var/lib/mysql directory
chown -R mysql:mysql /var/lib/mysql

# Initialize the MariaDB database if it's not already set up
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Start MariaDB in the foreground as the 'mysql' user
echo "Starting MariaDB in the foreground as the 'mysql' user..."
gosu mysql mysqld --skip-networking &
# MYSQL_PID=$!

# Wait for MariaDB to start
echo "Waiting for MariaDB to start..."
sleep 10

# Set up the root user and the WordPress user and database
echo "Setting up users and databases..."
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"
mysql -e "FLUSH PRIVILEGES;"

# Keep the MariaDB server running in the foreground
echo "Keeping MariaDB running..."
# wait $MYSQL_PID
