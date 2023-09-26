FROM alpine:3.17

# Install packages
RUN apk update && apk upgrade && apk add --no-cache \
    mariadb \
    mariadb-client \
    openrc

# Import config
COPY conf/mariadb-server.cnf /etc/my.cnf.d

# Import init scripts
COPY entrypoint.sh tools/init-db.sh /tmp
RUN chmod +x /tmp/entrypoint.sh /tmp/init-db.sh

# Start
ENTRYPOINT ["/tmp/entrypoint.sh"]
