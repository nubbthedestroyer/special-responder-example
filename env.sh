# Do not use a shbang

export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
export AWS_SESSION_TOKEN=$(aws configure get aws_session_token)

export TF_VAR_s3_bucket="lambda-deploy-test-20180918"
export TF_VAR_function_version="v0.0.10"