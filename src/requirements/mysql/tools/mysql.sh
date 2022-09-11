#!/bin/sh

# set -x

if [ -z ${MYSQL_ROOT_PASSWORD} ] || [ -z ${MYSQL_PASSWORD} ] || [ -z ${MYSQL_USER} ]; then
	echo "MySQL basic data is not defined"
else
	# Create error log
	# touch /var/lib/mysql/mysql-error.log

	set +e
	# Install basic system database table
	# chown -R root:root /var/lib/mysql
	/usr/bin/mysql_install_db

	# Run mysql in the background
	/usr/bin/mysqld_safe &

	# Check MySQL server is now running
	for n in `seq 1 42`
	do
		mysqladmin ping > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			echo "MySQL server is now running!"
			break
		else
			echo "$n : MySQL server is not running..."
			if [ $n -eq 42 ]; then
				exit 1
			fi
			sleep 1
		fi
	done

	# Make sql script as file
	tmpf='test_file'
	if [ ! -f "$tmpf" ]; then
		cat << EOF > $tmpf
USE mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
	fi

	mysql < $tmpf

	# rm -rf /var/lib/mysql/aria_log_control
	mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
	# Run mysql demon
	/usr/bin/mysqld


fi

exec "$@"