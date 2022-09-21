time=`date +%Y_%m_%d`

/usr/bin/mysqldump -u root -p${MYSQL_ROOT_PASSWORD} mojukcommunity > /sql/mojukcommunity_$(date +%Y_%m_%d_%H:%M:%S).sql