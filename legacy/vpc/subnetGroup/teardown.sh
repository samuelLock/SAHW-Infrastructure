#!/bin/bash
cd "$(dirname "$0")"

aws rds delete-db-subnet-group --db-subnet-group-name 'superAwesomeSubnetGroup'

rm -r build