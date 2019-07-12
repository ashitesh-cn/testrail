FROM ubuntu:16.04
RUN echo deb http://archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list.d/precise.list
RUN apt-get update && \
  apt-get install -y software-properties-common vim

RUN apt-get update -y

RUN apt-get install -y git

RUN apt-get install curl


# LAMP Requirements
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server mysql-client
#RUN service mysqld start 
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get -y install php7.2  libapache2-mod-php7.2
RUN apt-get -y install apache2 
#RUN systemctl restart apache2
EXPOSE 80
CMD apachectl -D FOREGROUND
RUN apt-get -y install php7.2-mysql php7.2-zip php7.2-json php7.2-curl php7.2-gd php7.2-intl php-pear php7.2-imagick php7.2-imap php-mcrypt php7.2-memcache  php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-mbstring php7.2-gettext php7.2-json php7.2-xml
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server mysql-client
#RUN systemctl restart apache2.service
CMD apachectl -D FOREGROUND


RUN apt-get -y install unzip
RUN apt-get update 
RUN apt-get install -y \
    software-properties-common \
    wget 

#installing ioncube
WORKDIR /var/opt
RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
RUN tar xvfz ioncube_loaders_lin_x86-64.tar.gz
#RUN systemctl restart apache2.service
CMD apachectl -D FOREGROUND

#need to move to /opt directory

#need to write the extensions in /var/php/7.1/php.ini file
#RUN sed -i '/extension=mysql.dll/a extension=mysqli.so' /etc/php/7.2/apache2/php.ini 
RUN sed -i '/extension=mysqli/a extension=curl.so' /etc/php/7.2/apache2/php.ini
RUN sed -i '/extension=curl.so/a extension=json.so' /etc/php/7.2/apache2/php.ini
RUN sed -i '/zend.assertions = -1/a zend_extension=/var/opt/ioncube/ioncube_loader_lin_7.2.so' /etc/php/7.2/apache2/php.ini
RUN sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/7.2/apache2/php.ini



CMD apachectl -D FOREGROUND

#RUN sed -i '/extension=msql.dll/a extension=mysqli.so' /etc/php/7.2/cli/php.ini 
RUN sed -i '/extension=mysqli/a extension=curl.so' /etc/php/7.2/cli/php.ini
RUN sed -i '/extension=curl.so/a extension=json.so' /etc/php/7.2/cli/php.ini
RUN sed -i '/zend.assertions = -1/a zend_extension=/var/opt/ioncube/ioncube_loader_lin_7.2.so' /etc/php/7.2/cli/php.ini



#need to create an empty database
WORKDIR /


#need to download testrail.zip and unzip and put it in /var/www/html
COPY testrail.zip /var/www/html/testrail.zip
WORKDIR /var/www/html
RUN unzip -q testrail.zip
WORKDIR /
COPY config.php /var/www/html/testrail/config.php
COPY testrail.sql /
COPY run.sh /
RUN chmod +x /run.sh
CMD /run.sh






