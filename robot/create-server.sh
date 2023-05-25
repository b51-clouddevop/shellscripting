#!/bin/bash

if [ -z "$1" ];then
 echo "component name is requered"
 exit 1
fi
COMPONENT=$1
AMI_ID="$(aws ec2 describe-images --region us-east-1 --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')"
SGID="sg-0a6535664857652e9"
echo "AMI ID used to lunch instance is: $AMI_ID"
echo "SGID ID used to lunch instance is: $SGID"
echo $COMPONENT

aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-ids $SGID ---tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq | jq
