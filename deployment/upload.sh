#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if aws s3 ls "${TF_VAR_s3_bucket}" 2>&1 | grep -q 'NoSuchBucket'; then
    echo "Oooo!  Sorry, this bucket doesn't exist yet.  Let me try to create it for you."
    aws s3 mb "s3://${TF_VAR_s3_bucket}" --region "${TF_VAR_aws_region}"
else
    echo "GOOD!!!  Bucket exists already."
fi


cd ${DIR}/../app

rm -rf ../package
mkdir ../package
cp -r * ../package
cd ../package

ls -lah

#pip install -r requirements.txt -t ./

zip -r ${DIR}/../package.zip *

cd ..
rm -rf package

cd ${DIR}/..

# Establish version number for this deploy

if [ -z "${1}" ]; then
    this_version="${TF_VAR_function_version}"
else
    this_version="${1}"
fi

aws s3 cp --region "${TF_VAR_aws_region}" package.zip s3://${TF_VAR_s3_bucket}/${this_version}/package.zip && \
rm -rf package.zip
