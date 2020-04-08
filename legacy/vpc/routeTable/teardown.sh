#!/bin/bash
cd "$(dirname "$0")"

routeTableId=$(aws ec2 describe-route-tables | jq -c ".RouteTables[] | select (.VpcId | contains(\"$VPC_ID\"))" | jq -r '.RouteTableId')
aws ec2 delete-route-table --route-table-id $routeTableId
rm -r build