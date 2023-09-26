FROM alpine:3.17

# Install packages
RUN apk update && apk upgrade && apk add --no-cache \
    nginx \
    openssl \
    curl

# Import config
COPY conf/default.conf /etc/nginx/http.d/default.conf

# Import init scripts
COPY entrypoint.sh /tmp
RUN chmod +x /tmp/entrypoint.sh

# Start
ENTRYPOINT [ "/tmp/entrypoint.sh" ]
