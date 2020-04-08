#!/bin/bash
#Dependencies: VPC
cd "$(dirname "$0")"

mkdir build

internetGateway=$(aws ec2 create-internet-gateway)
internetGatewayId=$(echo $internetGateway | jq -r '.InternetGateway.InternetGatewayId')
echo $internetGateway>build/internetGatewayState.json

aws ec2 attach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $VPC_ID