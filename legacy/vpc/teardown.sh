#!/bin/bash
cd "$(dirname "$0")"

aws ec2 delete-vpc --vpc-id $VPC_ID

rm -r build