#!/bin/bash
set -e

USERID=$(id -u)
if [ $USERID -ne 0 ] ; then
    echo -e "\e[31m you must run this script as a root user \e[0m"
    exit 1
    fi
yum install nginx -y &>> /temp/frontend.log
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

rm -rf /usr/share/nginx/html/* &>> /temp/frontend.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> /temp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
 
systemctl enable nginx
systemctl start nginx
