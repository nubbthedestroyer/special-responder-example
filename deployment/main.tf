# Terraform HCL referencing a sub-module to duplicate environments.
# each of the "module" stanzas represents an independent API Gateway / Lambda stack.
# As you can see in the examples below, this can be used to create separate stages.
# copy or remove the "module" stanzas to you liking to add / remove environments.

module "responder-prod" {
  source = "lambda-stack/"

  aws_region = "${var.aws_region}"

  # Arbitrary environment tag
  environment = "prod"

  # Arbitrary function name
  function_name = "responder"

  # Arbitrary function version (must have already deployed a package to the appropriate
  function_version = "${var.function_version}"

  s3_bucket = "${var.s3_bucket}"
}

module "responder-stage" {
  source = "lambda-stack/"

  aws_region = "${var.aws_region}"

  environment = "stage"

  function_name = "responder"
  function_version = "${var.function_version}"

  s3_bucket = "${var.s3_bucket}"
}

output "production_base_url" {
  value = "${module.responder-prod.base_url}"
}

output "stage_base_url" {
  value = "${module.responder-stage.base_url}"
}

variable "s3_bucket" {}

variable "function_version" {
  default = "v0.0.1"
}

variable "aws_region" {
  default = "us-east-1"
}