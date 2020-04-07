#!/bin/bash 
cd "$(dirname "$0")"

export VPC_ID=$(cat $(dirname "$0")/vpc/build/vpcState.json | jq -r '.Vpc.VpcId')
export BASTION_EC2_INSTANCE_ID=$(cat $(dirname "$0")/ec2/build/ec2State.json| jq -r '.Instances[0].InstanceId')
export OUT_SG_GROUP_ID=$(cat $(dirname "$0")/ec2/bastionOutboundSecurityGroup/build/sgState.json| jq -r '.GroupId')
export IN_SG_GROUP_ID=$(cat $(dirname "$0")/ec2/bastionInboundSecurityGroup/build/sgState.json| jq -r '.GroupId')
export ROUTETABLE_ID=$(aws ec2 describe-route-tables | jq -c ".RouteTables[] | select (.VpcId | contains(\"$VPC_ID\"))" | jq -r '.RouteTableId')
export INTERNETGATEWAY_ID=$(cat $(dirname "$0")/vpc/internetGateway/build/internetGatewayState.json | jq -r '.InternetGateway.InternetGatewayId')
export SUBNET1_ID=$(cat $(dirname "$0")/vpc/subnet/build/subnet1State.json)| jq -r '.Subnet.SubnetId'
export SUBNET2_ID=$(cat $(dirname "$0")/vpc/subnet/build/subnet2State.json)| jq -r '.Subnet.SubnetId'
export SUBNET3_ID=$(cat $(dirname "$0")/vpc/subnet/build/subnet3State.json)| jq -r '.Subnet.SubnetId'

# Bastion Teardown
bash ec2/teardown.sh
bash ec2/bastionInboundSecurityGroup/teardown.sh
bash ec2/bastionOutboundSecurityGroup/teardown.sh

# Internet Gateway Teardown
bash vpc/internetGateway/teardown.sh
bash vpc/routeTable/teardown.sh

# Subnet Teardown
bash vpc/subnetGroup/teardown.sh
bash vpc/subnet/teardown.sh

# VPC Teardown
bash vpc/teardown.sh
