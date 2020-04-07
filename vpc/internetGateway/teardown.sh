#!/bin/bash
cd "$(dirname "$0")"

aws ec2 detach-internet-gateway --internet-gateway-id $INTERNETGATEWAY_ID --vpc-id $VPC_ID
aws ec2 delete-internet-gateway --internet-gateway-id $INTERNETGATEWAY_ID
rm -r build