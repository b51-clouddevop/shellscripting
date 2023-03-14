#!/bin/bash
set -e
COMPONENT=mongodb
source componants/common.sh
echo -n " confinguring repo: "
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo &>> $LOGFILE
stat $?

echo -n " installing mangodb: "
yum install -y mongodb-org &>> $LOGFILE
stat $?

