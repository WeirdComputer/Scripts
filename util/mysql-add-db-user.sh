#!/usr/bin/bash

MYSQL=/usr/bin/mysql

USER=$1
DATABASE=$2
DBUSRPASSWORD=$3


echo "Please provide the password for the root mysql user:\n"
read -sp PASSWORD

$MYSQL -u "root" -p "$PASSWORD" <<SQLSYN
CREATE DATABASE $DATABASE;
CREATE USER '$USER'@'192.168.1.%' IDENTIFIED BY '$DBUSRPASSWORD';
GRANT ALL PRIVILEGES ON $DATABASE.* TO '$USER'@'192.168.1.%';
FLUSH PRIVILEGES;
SQLSYN