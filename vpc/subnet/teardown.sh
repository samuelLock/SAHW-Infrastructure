#!/bin/bash
cd "$(dirname "$0")"

aws ec2 delete-subnet --subnet-id $SUBNET1_ID
aws ec2 delete-subnet --subnet-id $SUBNET2_ID
aws ec2 delete-subnet --subnet-id $SUBNET3_ID

rm -r build