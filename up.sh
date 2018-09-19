#!/usr/bin/env bash

if [ -z "${1}" ]; then
    echo "ERROR: It looks like you didn't specify a bucket name.  Please specify when running this script like this:"
    echo "./up.sh my_s3_bucket v0.0.3"
else
    echo "Launching using s3 bucket = ${1}"
fi

if [ -z "${2}" ]; then
    echo "ERROR: It looks like you didn't specify a version.  This just needs to be an arbitrary tag, as its used for the s3 key path.  Like this:"
    echo "./up.sh my_s3_bucket v0.0.3"
else
    echo "Launching using version = ${2}"
fi

set +e
bash -e <<TRY
  aws ec2 describe-regions > /dev/null 2>&1
TRY
if [ $? -ne 0 ]; then
  echo "ERROR: It looks like your AWS credentials are not setup, or the aws cli is not installed."
  echo "See here for details on how to get this going: https://docs.aws.amazon.com/cli/latest/userguide/installing.html"
  exit 1
fi

bash -e <<TRY
  docker -v > /dev/null 2>&1
TRY
if [ $? -ne 0 ]; then
  echo "ERROR: It looks like you don't have docker installed.  See below for details on how to get this going:"
  echo "for Mac = https://docs.docker.com/docker-for-mac/"
  echo "for Windows = https://docs.docker.com/docker-for-windows/"
  exit 1
fi

set -e

cat env.sh.template | sed \
    -e "s/<s3_bucket_placeholder>/${1}/g" \
    -e "s/<version_placeholder>/${2}/g" \
    > env.sh
source env.sh
docker-compose build
docker-compose run test && \
docker-compose run upload && \
docker-compose run deploy
