resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "data" {
  bucket = "${var.project_name}-data-${random_id.suffix.hex}"

  tags = {
    Name = "${var.project_name}-bucket"
  }
}

resource "aws_dynamodb_table" "app_table" {
  name         = "${var.project_name}-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "${var.project_name}-table"
  }
}