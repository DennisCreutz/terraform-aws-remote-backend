output "bucket_name" {
  value = module.s3_bucket.s3_bucket_id
}

output "dynamo_db_name" {
  value = module.dynamodb_table.dynamodb_table_id
}

output "kms_key_arn" {
  value = aws_kms_key.this.arn
}
