#!/bin/bash
set -e

USERID=$(id -u)
if [ $USERID -ne 0 ] ; then
    echo -e "\e[31m you must run this script as a root user \e[0m"
    exit 1
    fi
echo "installing nginx"
yum install nginx -y &>> /tmp/frontend.log
echo "downloading"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
echo "cleaning junks"
rm -rf /usr/share/nginx/html/* &>> /tmp/frontend.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
 
systemctl enable nginx
systemctl start nginx
