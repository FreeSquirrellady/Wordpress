#!/bin/bash
 
 echo -e  "\n  Preparing the system...\n"
 sudo apt update && sudo apt upgrade -y
 sudo apt-get install wget unzip curl -y
#
 echo -e "\n Installing nginx...\n"
 sudo apt-get install nginx -y
#
 echo -e "\n Installing and configiring php...\n"
 sudo apt-get install php php-curl php-fpm php-bcmath php-gd php-soap php-zip php-curl php-mbstring php-mysqlnd php-gd php-xml php-intl php-zip -y
 php -v      #verify php version

 echo -e "\n Installing and configuring MariaDB....\n"
 sudo apt-get install mariadb-server -y
 sudo systemctl enable --now mariadb
 root_password=mypass
  
  Make sure that NOBODY can access the server without a password
  sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('$root_password') WHERE User = 'root'"
   
   # Kill the anonymous users
   sudo mysql -e "DROP USER IF EXISTS ''@'localhost'"
   # Because our hostname varies we'll use some Bash magic here.
   sudo mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"
   # Kill off the demo database
   sudo mysql -e "DROP DATABASE IF EXISTS test"
 
   echo "Creating wordpress user..."
   sudo mysql -e "CREATE USER IF NOT EXISTS 'wordpress_user'@'localhost' IDENTIFIED BY 'password1'"
 
   echo "Creating wordpress database..."
    
    sudo mysql -e "CREATE DATABASE IF NOT EXISTS wordpress_db"
 
    sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password'"   # Grantpermissions on db to user
    sudo mysql -e "FLUSH PRIVILEGES"    # Make our changes take effect
#
# echo "\n\033[34m Installing and configiring mariadb...\n"
#  
      #Wordpress installation
      echo "\n\033[34m Installing wordpress...\n"
      wget https://wordpress.org/latest.zip
      unzip latest.zip -d /var/www/html/
      cp wp-config-sample.php wp-config.php #времянка, потомзаменить на выгрузку из гитхаба с готовым подключением к базе данных
      chown -R www-data:www-data /var/www/html/wordpress/
#
      echo "\n\033[34m Configuration nginx...\n"
      #Добавить выгрузку конфига из гитхаба
      /sbin/nginx -t
      /sbin/nginx -s reload
#
