#!/bin/bash
set -e
COMPONENTS=mongodb
source componants/common.sh
echo"confinguring repo:"
curl -s -o /etc/yum.repos.d/$COMPONENTS.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENTS/main/mongo.repo
stat $?

echo "installing mangodb:"
yum install -y mongodb-org
stat $?

