#!/bin/sh

set -euo pipefail

WP_PATH="/var/www/localhost/htdocs"
MYSQL_CONNECT_TIMEOUT=100

# Wait for MySQL
timeout=$MYSQL_CONNECT_TIMEOUT
while ! mariadb -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &>/dev/null; do
    echo "Wait for MySQL..."
    timeout=$((timeout - 1))
    test "$timeout" = 0 && echo "MariaDB timeout." && exit 1
    sleep 3
done

if [ ! -f $WP_PATH/wp-config.php ];
then
    wp config create \
        --allow-root \
        --dbhost=$MYSQL_HOST:3306 \
        --dbname=$MYSQL_DATABASE \
        --dbpass=$MYSQL_PASSWORD \
        --dbuser=$MYSQL_USER \
        --path=$WP_PATH

    wp core install \
        --admin_email=$WP_ADMIN_MAIL \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_user=$WP_ADMIN_NAME \
        --allow-root \
        --path=$WP_PATH \
        --skip-email \
        --title=$WP_TITLE \
        --url=$DOMAIN_NAME

    wp user create \
        --allow-root \
        --path=$WP_PATH \
        --role=author $WP_USER_NAME $WP_USER_MAIL \
        --user_pass=$WP_USER_PASSWORD

    wp theme install twentytwenty \
        --activate \
        --allow-root \
        --path=$WP_PATH
fi

# TODO
if [ ! -d /run/php ];
then
    mkdir /run/php;
fi
