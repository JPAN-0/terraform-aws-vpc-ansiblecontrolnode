output "bucket" {
  description = "Name of the S3 bucket holding the terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "region" {
  description = "Region of the S3 bucket holding the terraform state"
  value       = aws_s3_bucket.terraform_state.region
}
output "dynamodb_table" {
  description = "Name of the S3 bucket holding the terraform state"
  value       = aws_dynamodb_table.terraform_state_lock.name
}
