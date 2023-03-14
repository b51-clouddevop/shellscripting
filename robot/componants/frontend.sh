#!/bin/bash
set -e
COMPONENT=frontend
source componants/common.sh

echo -n "installing nginx:"

yum install nginx -y &>> $LOGFILE
stat $?
echo -n "downloading:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/$COMPONENTS/archive/main.zip"
 stat $?
echo -n "cleaning junks:"

rm -rf /usr/share/nginx/html/* &>> $LOGFILE
stat $?
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
