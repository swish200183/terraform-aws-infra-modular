output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.compute.instance_public_ip
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.storage.bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = module.storage.table_name
}