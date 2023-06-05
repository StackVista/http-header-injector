#!/bin/bash

set -e

docker build . -t 672574731473.dkr.ecr.eu-west-1.amazonaws.com/dev:proxy-latest
docker push 672574731473.dkr.ecr.eu-west-1.amazonaws.com/dev:proxy-latest