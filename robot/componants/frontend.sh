#!/bin/bash
set -e

USERID=$(id -u)

if [ $USERID -ne 0 ] ; then
echo -e "\e[31m you must run this script as a root user \e[0m"
exit 1
fi
stat() {
    if [ $? -eq 0 ]  ; then
echo -e "\e[32m succefull \e[0"
else 
echo -e "\e[31m failure \e[0"
fi
}

echo -n "installing nginx:"
stat $?

yum install nginx -y &>> /tmp/frontend.log
echo -n "downloading:"
 stat $?
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
echo -n "cleaning junks:"
stat $?

rm -rf /usr/share/nginx/html/* &>> /tmp/frontend.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
 
systemctl enable nginx
systemctl start nginx
