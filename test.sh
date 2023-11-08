#!/bin/bash
TOKEN="token"   #insert your token here
CHAT_ID="chatID"  #insert your Chat ID here
MESSAGE_SUCCESS="Success"
MESSAGE_FAILURE="Failure"
SYSTEM_STATUS="Preparing the system..."
NGINX_INSTALLATION="Nginx installation..."
PHP_INSTALLATION="PHP installation..."
MARIADB_INSTALLATION="Maria DB installation..."
WORDPRESS_INSTALLATION="Wordpress installation..."

  function sendtheresult(){         #send to Telegram chat
    curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$(cat $HOME/temp.txt)" > /dev/null
  }

 echo -e  "\n  Preparing the system...\n"
 sudo apt update && sudo apt upgrade -y 
 sudo apt-get install wget unzip curl -y
 if [ "$?" -eq "0" ]
   then
 echo -e "$SYSTEM_STATUS  $MESSAGE_SUCCESS">$HOME/temp.txt
   else
 echo -e "$SYSTEM_STATUS  $MESSAGE_FAILURE">$HOME/temp.txt
 fi

 echo -e "\n Installing nginx...\n"
 sudo apt-get install nginx -y
 wget https://github.com/FreeSquirrellady/Wordpress/blob/main/myexample.com.conf -P /etc/nginx/sites-enabled/myexample.com.conf  #downloading wp-config from github
 /sbin/nginx -t
 /sbin/nginx -s reload
 if [ "$?" -eq "0" ]
   then
 echo -e "$NGINX_STATUS  $MESSAGE_SUCCESS">>$HOME/temp.txt
   else
 echo -e "$NGINX_STATUS  $MESSAGE_FAILURE">>$HOME/temp.txt
 fi

 echo -e "\n Installing php...\n"
 sudo apt-get install php php-curl php-fpm php-bcmath php-gd php-soap php-zip php-curl php-mbstring php-mysqlnd php-gd php-xml php-intl php-zip -y
 if [ "$?" -eq "0" ]
   then
 echo -e "$PHP_STATUS  $MESSAGE_SUCCESS">>$HOME/temp.txt
   else
 echo -e "$PHP_STATUS  $MESSAGE_FAILURE">>$HOME/temp.txt
 fi
 echo -e "\n Installing and configuring MariaDB....\n"
 sudo apt-get install mariadb-server -y
 sudo systemctl enable --now mariadb
 root_password=mypass
  
 # Make sure that NOBODY can access the server without a password
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

 if [ "$?" -eq "0" ]
   then
 echo -e "$MARIADB_STATUS  $MESSAGE_SUCCESS">>$HOME/temp.txt
   else
 echo -e "$MARIADB_STATUS  $MESSAGE_FAILURE">>$HOME/temp.txt
 fi

   echo "\n\033[34m Installing wordpress...\n"
    wget https://wordpress.org/latest.zip   #Download Wordpress
    unzip latest.zip -d /var/www/html/      #Unpack the archive 
    wget https://github.com/FreeSquirrellady/Wordpress/blob/main/wp-config.php -P /var/www/html/wordpress/wp-config.php #downloading wp-config from github
    chown -R www-data:www-data /var/www/html/wordpress/ #change the owner
    sudo /usr/sbin/a2ensite wordpress.conf #making site enable
    sudo systemctl reload apache2   #Apache2 reloading
 if [ "$?" -eq "0" ]
   then
  echo -e "$WORDPRESS_STATUS  $MESSAGE_SUCCESS">>$HOME/temp.txt
    else
  echo -e "$WORDPRESS_STATUS  $MESSAGE_FAILURE">>$HOME/temp.txt
 fi	  

sendtheresult    #sending statuses to a telegram chat

rm -rf $HOME/temp.txt #removing temp.txt
