variable "stage" {
  description = "The stage name."
  type        = string
}

variable "project" {
  description = "The name of the project."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 remote backend bucket."
  type        = string
}

variable "dynamo_db_name" {
  description = "The name of the DynamoDB table used for state locking."
  type        = string
}

locals {
  prefix_env = terraform.workspace == "default" ? var.stage : terraform.workspace
  prefix     = "${var.project}-${local.prefix_env}"
  default_tags = {
    stage        = var.stage
    project      = var.project
    tf_workspace = terraform.workspace
  }
}
