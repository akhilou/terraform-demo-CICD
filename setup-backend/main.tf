provider "aws" {
  region = "us-west-2"
}

resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "this" {
  bucket = "my-terraform-state-bucket-${random_string.unique.result}"
  acl    = "private"

  tags = {
    Name = "my-terraform-state-bucket-${random_string.unique.result}"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "folder" {
  bucket = aws_s3_bucket.this.bucket
  key    = "terraform-state-file/"
  content = ""
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}
