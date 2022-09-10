# Stack in alpine linux version 3.14
FROM alpine:3.14

# Exit shell-script immediately if exist with a non-zero status
RUN set -e
# Update package manager
RUN apk update
# Install mysql and delete apk cache
RUN apk add mysql && rm -f /var/cache/apk/*
RUN apk add openrc && rm -f /var/cache/apk/*

# Copy script file to container
COPY ./tools/mysql.sh /tmp/mysql.sh
# Set script auth
RUN chmod +x /tmp/mysql.sh

# Entrypoint
ENTRYPOINT ["/tmp/mysql.sh"]