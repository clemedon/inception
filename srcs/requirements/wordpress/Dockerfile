FROM alpine:3.17

# Install packages
RUN apk update && apk upgrade && apk add --no-cache \
    mariadb-client \
    php-fpm \
    php-mysqli \
    php81 \
    wget \
    curl

# Import config
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Import init scripts
COPY entrypoint.sh tools/wp-config.sh /tmp
RUN chmod +x /tmp/entrypoint.sh /tmp/wp-config.sh

# Import sources TODO add from the host?
RUN mkdir /tmp/sources
COPY sources /tmp/sources

# Start
ENTRYPOINT ["/tmp/entrypoint.sh"]
