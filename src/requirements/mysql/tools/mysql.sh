#!/bin/sh

if [ -z ${MYSQL_ROOT_PASSWORD} ] || [ -z ${MYSQL_PASSWORD} ] || [ -z ${MYSQL_USER} ]; then
	echo "MySQL basic data is not defined"
else

	# Install basic system database table
	# chown -R root:root /var/lib/mysql
	/usr/bin/mysql_install_db

	# Run mysql in the background
	/usr/bin/mysqld_safe &

	# Set delay until mysql server run successfully
	sleep 1
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
		fi
		sleep 1
	done

	


	# Run mysql demon
	# /usr/bin/mysqld


	
	# ls -la /var/lib/
	# chown -R mysql:mysql /var/lib/mysql
	# ls -la /etc
	# cat /etc/my.cnf
	# find . -name mysql
	# ls -la /var/lib/mysql
	# ls -la /etc/my.cnf.d
	# cat /etc/my.cnf.d/mariadb-server.cnf
	

fi

exec "$@"