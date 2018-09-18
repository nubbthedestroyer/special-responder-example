module "responder-prod" {
  source = "../lambda-infra/"

  function_name = "responder"

  environment = "prod"

  s3_bucket = ""
  s3_key = ""
}

module "responder-stage" {
  source = "../lambda-infra/"

  function_name = "responder"

  environment = "stage"

  s3_bucket = ""
  s3_key = ""
}

output "production_base_url" {
  value = "${module.responder-prod.base_url}"
}

output "stage_base_url" {
  value = "${module.responder-stage.base_url}"
}