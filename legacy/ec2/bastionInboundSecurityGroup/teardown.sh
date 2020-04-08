#!/bin/bash 
cd "$(dirname "$0")"

aws ec2 delete-security-group --group-id $IN_SG_GROUP_ID

rm -r build