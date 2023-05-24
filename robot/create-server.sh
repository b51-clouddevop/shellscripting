#!/bin/bash

AMI_ID="$(aws ec2 describe-images --region us-east-1 --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')"
SGID="$(aws ec2 describe-security-groups  --filters Name=group-name,Values=0a6535664857652e9 | jq '.SecurityGroup[].GroupId' | sed -e 's/"//g')"
echo "AMI ID used to lunch instance is: $AMI_ID"
echo "SGID ID used to lunch instance is: $SGID

aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro | jq .