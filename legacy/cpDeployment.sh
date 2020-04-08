#!/bin/bash 
cd "$(dirname "$0")"

# Base VPC Deployment
bash vpc/deploy.sh
export VPC_ID=$(cat $(dirname "$0")/vpc/build/vpcState.json | jq -r '.Vpc.VpcId')

# Subnet Deployment
bash vpc/subnet/deploy.sh
export SUBNET1_ID=$(cat $(dirname "$0")/vpc/subnet/build/subnet1State.json| jq -r '.Subnet.SubnetId')
export SUBNET2_ID=$(cat $(dirname "$0")/vpc/subnet/build/subnet2State.json| jq -r '.Subnet.SubnetId')
export SUBNET3_ID=$(cat $(dirname "$0")/vpc/subnet/build/subnet3State.json| jq -r '.Subnet.SubnetId')

bash vpc/subnetGroup/deploy.sh

# Internet Gateway Deployment
bash vpc/internetGateway/deploy.sh
export INTERNETGATEWAY_ID=$(cat $(dirname "$0")/vpc/internetGateway/build/internetGatewayState.json | jq -r '.InternetGateway.InternetGatewayId')

export ROUTETABLE_ID=$(aws ec2 describe-route-tables | jq -c ".RouteTables[] | select (.VpcId | contains(\"$VPC_ID\"))" | jq -r '.RouteTableId')
bash vpc/routeTable/deploy.sh

# Bastion Deployment
bash ec2/bastionInboundSecurityGroup/deploy.sh
export IN_SG_GROUP_ID=$(cat $(dirname "$0")/ec2/bastionInboundSecurityGroup/build/sgState.json| jq -r '.GroupId')

bash ec2/bastionOutboundSecurityGroup/deploy.sh
export OUT_SG_GROUP_ID=$(cat $(dirname "$0")/ec2/bastionOutboundSecurityGroup/build/sgState.json| jq -r '.GroupId')

bash ec2/deploy.sh
export BASTION_EC2_INSTANCE_ID=$(cat $(dirname "$0")/ec2/build/ec2State.json| jq -r '.Instances[0].InstanceId')

# ECR Repository Deployment
bash ecr/deploy.sh