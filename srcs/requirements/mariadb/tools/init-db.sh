#!/bin/sh

set -euo pipefail

# Initialize MariaDB
if [ $(ls /var/lib/mysql | wc -l)  -eq 0 ]
then
    /etc/init.d/mariadb setup
    rc-service mariadb start
    mysql -u root -e " \
        CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
        CREATE DATABASE $MYSQL_DATABASE;                               \
        GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';              \
        FLUSH PRIVILEGES"
    mysql -u root -e "ALTER USER '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'"
    mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
fi
