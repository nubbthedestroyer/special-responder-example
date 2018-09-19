#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if aws s3 ls "${TF_VAR_s3_bucket}" 2>&1 | grep -q 'NoSuchBucket'; then
    echo "Oooo!  Sorry, this bucket doesn't exist yet.  Let me try to create it for you."
    aws s3api create-bucket --bucket "${TF_VAR_s3_bucket}"
else
    echo "GOOD!!!  Bucket exists already."
fi

cd ${DIR}/../app
zip -r ../package.zip *
cd ${DIR}

# Establish version number for this deploy

if [ -z "${1}" ]; then
    this_version="${TF_VAR_function_version}"
else
    this_version="${1}"
fi

aws s3 cp ../package.zip s3://${TF_VAR_s3_bucket}/${this_version}/package.zip && \
rm -rf ../package.zip
