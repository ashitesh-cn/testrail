mkdir /var/www/html/testrail/logs
chown www-data:www-data /var/www/html/testrail/logs/
mkdir -p /opt/testrail/attachments
chown www-data:www-data /opt/testrail/attachments/
mkdir -p /opt/testrail/reports/
chown www-data:www-data /opt/testrail/reports/

/etc/init.d/mysql start

echo "CREATE DATABASE testrail DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "CREATE USER 'testrail'@'localhost' IDENTIFIED BY 'newpassword';" | mysql -u root
echo "GRANT ALL ON testrail.* TO 'testrail'@'localhost';" | mysql -u root

mysql testrail < testrail.sql

/etc/init.d/apache2 start
sleep infinity