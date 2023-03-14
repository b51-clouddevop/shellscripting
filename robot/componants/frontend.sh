#!/bin/bash
set -e
COMPONENTS=frontend
source componants/common.sh

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
