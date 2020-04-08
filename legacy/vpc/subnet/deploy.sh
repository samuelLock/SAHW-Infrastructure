#!/bin/bash
#Dependencies: VPC
cd "$(dirname "$0")"

mkdir build

cat subnetConfigBase.json | jq ".AvailabilityZoneId = \"euw1-az1\"" | jq ".CidrBlock = \"10.0.1.0/24\"" | jq ".VpcId = \"$VPC_ID\"" > build/subnet1Config.json
cat subnetConfigBase.json | jq ".AvailabilityZoneId = \"euw1-az2\"" | jq ".CidrBlock = \"10.0.2.0/24\"" | jq ".VpcId = \"$VPC_ID\"" > build/subnet2Config.json
cat subnetConfigBase.json | jq ".AvailabilityZoneId = \"euw1-az3\"" | jq ".CidrBlock = \"10.0.3.0/24\"" | jq ".VpcId = \"$VPC_ID\"" > build/subnet3Config.json

subnet1=$(aws ec2 create-subnet --cli-input-json file://build/subnet1Config.json)
export SUBNET1_ID=$( echo $subnet1 | jq -r '.Subnet.SubnetId')
subnet2=$(aws ec2 create-subnet --cli-input-json file://build/subnet2Config.json)
export SUBNET2_ID=$( echo $subnet2 | jq -r '.Subnet.SubnetId')
subnet3=$(aws ec2 create-subnet --cli-input-json file://build/subnet3Config.json)
export SUBNET3_ID=$( echo $subnet3 | jq -r '.Subnet.SubnetId')

echo $subnet1>build/subnet1State.json
echo $subnet2>build/subnet2State.json
echo $subnet3>build/subnet3State.json