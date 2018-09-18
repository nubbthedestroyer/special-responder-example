variable "aws_region" {
  default = 'us-east-1'
}

variable "function_name" {
  description = "Name that you would like to use to tag resources for this lambda app."
}

variable "environment" {
  description = "Specific environment or stage for this module.  Example: PROD, Stage, Dev, etc."
}

variable "runtime" {
  default = 'python3.4'
}

variable "handler" {
  default = 'handler.handler'
}

variable "s3_bucket" {
  description = "Bucket where your lambda code is stored."
}

variable "s3_key" {
  description = "Key path at which your version of lambda code can be found."
}
