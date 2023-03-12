#!/bin/bash
set -e

USERID=$(id -u)
COMPONENTS=frontend
LOGFILE=/tmp/$COMPONENTS.log

if [ $USERID -ne 0 ] ; then
echo -e "\e[31m you must run this script as a root user \e[0m"
exit 1
fi
stat() {
    if [ $1 -eq 0 ]  ; then
echo -e "\e[32m succefull \e[0"
else 
echo -e "\e[31m failure \e[0"
fi
}

echo -n "installing nginx:"
stat $?

yum install nginx -y &>> $LOGFILE
echo -n "downloading:"
 stat $?
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/$COMPONENTS/archive/main.zip"
echo -n "cleaning junks:"
stat $?

rm -rf /usr/share/nginx/html/* &>> $LOGFILE
cd /usr/share/nginx/html
unzip /tmp/$COMPONENTS.zip &>> $LOGFILE
mv frontend-main/* .
mv static/* .
rm -rf $COMPONENTS-main README.md
echo "configuring reverse proxyfile"
stat $?
mv localhost.conf /etc/nginx/default.d/roboshop.conf
 echo "service start"
systemctl enable nginx
systemctl start nginx
