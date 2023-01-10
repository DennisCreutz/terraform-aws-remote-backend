## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 remote backend bucket. | `string` | n/a | yes |
| <a name="input_dynamo_db_name"></a> [dynamo\_db\_name](#input\_dynamo\_db\_name) | The name of the DynamoDB table used for state locking. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The name of the project. | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The stage name. | `string` | n/a | yes |

## Outputs

| Name | Description                            |
|------|----------------------------------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the created S3 bucket      |
| <a name="output_dynamo_db_name"></a> [dynamo\_db\_name](#output\_dynamo\_db\_name) | The name of the created DynamoDB table |
