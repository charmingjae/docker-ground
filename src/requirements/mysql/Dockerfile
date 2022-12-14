# Stack in alpine linux version 3.14
FROM alpine:3.14

# Exit shell-script immediately if exist with a non-zero status
RUN set -e
# Update package manager
RUN apk update
# Install mysql and delete apk cache
# 00. Add mysql and mysql-client.
#     If want to connect at database server or use mysqladmin
#     should add mysql-client.
RUN apk add mysql mysql-client && rm -f /var/cache/apk/*

# Copy script file to container
# 00. Copy mysql setting shell-script file.
COPY ./tools/mysql.sh /tmp/mysql.sh
# 01. Copy mysql configuration file.
COPY ./conf/config.cnf /etc/my.cnf.d/mariadb-server.cnf
# 02. Copy mysql backup script file.
COPY ./tools/dbBackup.sh /dbBackup.sh

# Set script auth
RUN chmod +x /tmp/mysql.sh

# Alert open port
EXPOSE 3306

STOPSIGNAL SIGQUIT

# Entrypoint
ENTRYPOINT ["/tmp/mysql.sh"]
CMD ["/usr/bin/mysqld"]