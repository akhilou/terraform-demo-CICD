provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "this" {
  bucket = "my-terraform-state-bucket"
  acl    = "private"

  tags = {
    Name = "my-terraform-state-bucket"
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
