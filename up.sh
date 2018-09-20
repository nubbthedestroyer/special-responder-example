#!/usr/bin/env bash

red() { tput setaf 1; cat; tput sgr0; }
green() { tput setaf 2; cat; tput sgr0; }
yellow() { tput setaf 3; cat; tput sgr0; }
blue() { tput setaf 4; cat; tput sgr0; }
black() { tput setaf 7; cat; tput sgr0; }

if [ -z "${1}" ]; then
    echo "ERROR: It looks like you didn't specify a bucket name.  Please specify when running this script like this:" | red
    echo "./up.sh my_s3_bucket v0.0.3" | red
else
    echo "Launching using s3 bucket = ${1}" | green
fi

if [ -z "${2}" ]; then
    echo "ERROR: It looks like you didn't specify a version.  This just needs to be an arbitrary tag, as its used for the s3 key path.  Like this:" | red
    echo "./up.sh my_s3_bucket v0.0.3" | red
else
    echo "Launching using version = ${2}" | green
fi

echo "Launching in region =  $(aws configure get region)" | green

set +e
bash -e <<TRY
  aws ec2 describe-regions > /dev/null 2>&1
TRY
if [ $? -ne 0 ]; then
  echo "ERROR: It looks like your AWS credentials are not setup, or the aws cli is not installed." | red
  echo "See here for details on how to get this going: https://docs.aws.amazon.com/cli/latest/userguide/installing.html" | red
  exit 1
fi

bash -e <<TRY
  docker -v > /dev/null 2>&1
TRY
if [ $? -ne 0 ]; then
  echo "ERROR: It looks like you don't have docker installed.  See below for details on how to get this going:" | red
  echo "for Mac = https://docs.docker.com/docker-for-mac/" | red
  echo "for Windows = https://docs.docker.com/docker-for-windows/" | red
  exit 1
fi

set -e

cat env.sh.template | sed \
    -e "s/<s3_bucket_placeholder>/${1}/g" \
    -e "s/<version_placeholder>/${2}/g" \
    > env.sh
source env.sh
docker-compose build | black && \
docker-compose run test | green && \
docker-compose run upload | blue && \
docker-compose run deploy | blue
