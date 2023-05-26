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

PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-ids $SGID --instance-market-options "MarketType=spot,SpotOptions=
{SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/$COMPONENT/" route53.json > /tmp/dns.json

echo -n "creating DNS record ********"
aws route53 change-resource-record-sets --hosted-zone-id Z0661428284PH7J9I27TJ --change-batch file:///tmp/dns.json | jq