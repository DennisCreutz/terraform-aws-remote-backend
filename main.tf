terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6"
    }
  }
}

resource "aws_kms_key" "this" {
  description             = "KMS key to encrypt ${local.prefix}-${var.bucket_name} state bucket."
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "this" {
  name          = "alias/${local.prefix}-${var.bucket_name}"
  target_key_id = aws_kms_key.this.key_id
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  bucket = "${local.prefix}-${var.bucket_name}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  versioning = {
    enabled = true
  }

  attach_deny_incorrect_kms_key_sse      = true
  attach_deny_insecure_transport_policy  = true
  attach_deny_unencrypted_object_uploads = true

  allowed_kms_key_arn = aws_kms_key.this.arn
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.this.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0"

  name     = "${local.prefix}-${var.dynamo_db_name}"
  hash_key = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  server_side_encryption_enabled     = true
  server_side_encryption_kms_key_arn = aws_kms_key.this.arn

  point_in_time_recovery_enabled = true
}
