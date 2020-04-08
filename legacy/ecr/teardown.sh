#!/bin/bash
# Dependencies: None
cd "$(dirname "$0")"

aws ecr delete-repository --repository-name superawesome-repository

rm -r build