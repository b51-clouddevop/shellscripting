#!/bin/bash
set -e
     COMPONENT=mongodb
     source componants/common.sh
echo -n "confinguring repo:"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo &>> $LOGFILE
stat $?

echo -n "installing ${COMPONENT}:"
yum install mongodb-org -y &>> $LOGFILE
stat $?
echo -n "updating mongodb config:"
     sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf  &>> $LOGFILE
stat $?

echo -n "starting mongodb serive: "
    systemctl enable mongod  &>> $LOGFILE
    systemctl start mongod   &>> $LOGFILE
stat $?

echo -n "downloding schema: "
     curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" &>> $LOGFILE
     stat $?

echo -n "injecting the schema: "
     cd /tmp
     unzip -o mongodb.zip  &>> $LOGFILE
     cd mongodb-main
     mongo < catalogue.js &>> $LOGFILE
     mongo < users.js     &>> $LOGFILE
 stat $?        