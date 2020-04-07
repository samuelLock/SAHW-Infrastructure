#!/bin/bash
#Dependencies: Bastion Inbound Security Group, Subnet
cd "$(dirname "$0")"

mkdir build

aws ec2 create-key-pair --key-name 'SuperAwesomeKey'
cat ec2ConfigBase.json | jq ".SecurityGroupIds[.SecurityGroupIds| length] |= . + \"$IN_SG_GROUP_ID\"" | jq ".SubnetId = \"$SUBNET1_ID\"" > build/ec2Config.json
ec2=$(aws ec2 run-instances --cli-input-json file://build/ec2Config.json)
bastionEc2InstanceId=$(echo $ec2 | jq -r '.Instances[0].InstanceId')

aws ec2 wait instance-running --instance-ids $bastionEc2InstanceId
#aws ec2 associate-address --instance-id $bastionEc2InstanceId

echo $ec2 > build/ec2State.json