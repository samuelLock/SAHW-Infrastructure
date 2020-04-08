#!/bin/bash
#Dependencies: None
cd "$(dirname "$0")"

vpc=$(aws ec2 create-vpc --cli-input-json file://vpcConfigBase.json)
vpcId=$(echo $vpc | jq -r '.Vpc.VpcId')
aws ec2 wait vpc-available --vpc-ids $vpcId
aws ec2 modify-vpc-attribute --enable-dns-hostnames --vpc-id $vpcId

mkdir build
echo $vpc>build/vpcState.json