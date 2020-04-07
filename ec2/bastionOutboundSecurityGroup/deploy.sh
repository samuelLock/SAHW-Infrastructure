#!/bin/bash 
#Dependencies: VPC
cd "$(dirname "$0")"

# Update VpcId in SG config file
mkdir build
cat sgConfigBase.json | jq ".VpcId = \"$VPC_ID\"" > build/sgConfig.json

# Create and configure security group
sg=$(aws ec2 create-security-group --cli-input-json file://build/sgConfig.json)

echo $sg>build/sgState.json

outSgGroupId=$( echo $sg | jq -r '.GroupId')

# Update Security Group Id in sgIngress config
cat sgEgressConfigBase.json | jq ".GroupId = \"$outSgGroupId\"" > build/sgEgressConfig.json
# aws ec2 authorize-security-group-egress --cli-input-json file://build/SGEgressConfig.json