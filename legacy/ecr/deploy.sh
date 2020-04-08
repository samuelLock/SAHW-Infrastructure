#!/bin/bash
# Dependencies: None
cd "$(dirname "$0")"

mkdir build

repo=$(aws ecr create-repository --cli-input-json file://repositoryConfigBase.json)

echo $repo>build/repositoryState.json