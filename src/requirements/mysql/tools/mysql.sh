#!/bin/sh

if [ -z ${MYSQL_ROOT_PASSWORD} ] || [ -z ${MYSQL_PASSWORD} ] || [ -z ${MYSQL_USER} ]; then
	echo "MySQL basic data is not defined"
else
	# Run mysql in the background
	/usr/bin/mysqld_safe &
	ps -ef | grep mysql

fi

exec "$@"