#!/bin/bash
#
# [Quick LEMP install Server Script]
#
# GitHub:   https://github.com/kirubha7/lemp-stack-installer
# Author:   Kirubhakaran

#updating packages
echo -e "\nUpdating package lists..\n"
sudo apt-get -y update

#install Ngnix
echo -e "\nInstalling Ngnix server...\n"
sudo apt-get -y install nginx


#install Mysql server
echo -e "\nInstalling Mysql server...\n"
#default password is root
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

#install Mysql server
echo -e "\nInstalling PHP-FPM and Mysql extension for PHP...\n"
sudo apt-get -y install php7.2-fpm php-mysql
sudo apt-get install php7.2-mbstring 
sudo apt-get install php7.2-xml
sudo apt install unzip
sudo apt install zip
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

#Set SSl 
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get install python-certbot-nginx



#Move nginx conf file to enable php support on ngnix
echo -e "\nMoving Nginx configuration file...\n"
sudo mv default /etc/nginx/sites-available

#Move php testing file
echo -e "\nMoving php testing file...\n"
sudo mv info.php /var/www/html/

sudo systemctl restart nginx.service

echo -e "\n\nLemp stack installed successfully :)\n"

echo -e "\n Open following link to check installed PHP configuration your_ip/info.php"
