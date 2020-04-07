#!/bin/bash
#Dependencies: VPC, Internet Gateway
cd "$(dirname "$0")"

mkdir build
cat routeTableConfigBase.json | jq ".GatewayId= \"$INTERNETGATEWAY_ID\"" | jq ".RouteTableId = \"$ROUTETABLE_ID\"" > build/routeTableConfig.json

route=$(aws ec2 create-route --cli-input-json file://build/routeTableConfig.json)

echo $route > build/routeTableState.json