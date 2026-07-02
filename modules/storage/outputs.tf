output "bucket_name" {
  value = aws_s3_bucket.data.bucket
}

output "table_name" {
  value = aws_dynamodb_table.app_table.name
}