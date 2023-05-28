# FROM debian:buster

# RUN apt-get update && apt-get install -y software-properties-common wget gnupg

# RUN wget https://mariadb.org/mariadb_release_signing_key.asc && \
#     apt-key add mariadb_release_signing_key.asc && \
# 	echo "deb http://mirror.mva-n.net/mariadb/repo/10.5/debian $(lsb_release -sc) main" > /etc/apt/sources.list.d/mariadb.list

# RUN apt-get update && apt-get install -y mariadb-server

# # make sure mariadb listens to all interfaces by setting bind-address to ip range
# # RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# COPY conf/conf.cnf /etc/my.cnf.d/mariadb-server.cnf
# COPY tools/kickstart.sh /kickstart.sh
# RUN chmod a+x /kickstart.sh
# ENTRYPOINT ["/kickstart.sh"]

# ./requirements/mariadb/Dockerfile
FROM debian:10

# Install MariaDB and dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the custom configuration file
RUN rm -f /var/lib/my.cnf.d/mariadb-server.cnf
COPY /conf/my.cnf /usr/my.cnf

# Expose the MariaDB port
# EXPOSE 3306

RUN chown -R mysql:mysql /var/lib/mysql

# Set up the entrypoint script
COPY tools/kickstart.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
