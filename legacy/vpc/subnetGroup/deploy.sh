#!/bin/bash
#Dependencies: Subnets
cd "$(dirname "$0")"

mkdir build

cat subnetGroupConfigBase.json | jq ".SubnetIds[.SubnetIds| length] |= . + \"$SUBNET1_ID\"" | jq ".SubnetIds[.SubnetIds| length] |= . + \"$SUBNET2_ID\"" | jq ".SubnetIds[.SubnetIds| length] |= . + \"$SUBNET3_ID\"" > build/subnetGroupConfig.json
subnetGroup=$(aws rds create-db-subnet-group --cli-input-json file://build/subnetGroupConfig.json)

echo $subnetGroup>build/subnetGroupState.json