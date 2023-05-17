# Inception
An introduction to Docker, a versatile tool for CI, testing and deployment, and more

# Practical tips
I use the script in [Theo's repo](https://github.com/t-h2o/inception) to set up the vm in which the docker is deployed, tested, etc.
## to connect to the vm through ssh
- `passwd` to set password for root
- `ip addr` find ip address of enp something device
- from machine you want to connect from, write `ssh username@ipyoufound`
- if you want to map some ports, do it like this `ssh usernameifyoufound -L 8080:localhost:80` to map port 8080 on the vm to localhost 80 on the host machine.

## .env template
```
DOMAIN_NAME=login.42.fr

# MARIADB
MYSQL_ROOT_PASSWORD=root123
# database name (database used in the wordpress instance)
MYSQL_DATABASE=wp_db
# user created when container first started
MYSQL_USER=login
MYSQL_PASSWORD=login123

# WORDPRESS

WP_TITLE=Inception

# wp database (maria db)
WP_DB_HOST=mariadb
WP_DB_USER=${MYSQL_USER}
WP_DB_PASSWORD=${MYSQL_PASSWORD}
WP_DB_NAME=${MYSQL_DATABASE}

# wp admin
WP_ADMIN_USER=login
WP_ADMIN_PWD=login123
WP_ADMIN_EMAIL=inception@login.42.fr

# wp user
WP_USER=test
WP_USER_PWD=test
WP_USER_EMAIL=login@login.42.fr

# nginx
```
