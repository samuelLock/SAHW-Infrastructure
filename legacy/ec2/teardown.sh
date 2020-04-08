#!/bin/bash
cd "$(dirname "$0")"

aws ec2 release-address --allocation-id $BASTION_ADDRESS_ID

aws ec2 delete-key-pair --key-name 'SuperAwesomeKey'
ec2InstanceId=$(cat build/ec2State.json | jq -r '.Instances[0].InstanceId')

aws ec2 terminate-instances --instance-ids $ec2InstanceId
aws ec2 wait instance-terminated --instance-ids $ec2InstanceId
rm -r build