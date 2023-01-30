terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.49.0"
    }
  }
}


resource "aws_s3_bucket" "my-s3-bucket" {
  bucket_prefix = var.bucket_prefix
  acl = var.acl
  
   versioning {
    enabled = var.versioning
  }
  tags = var.tags
}

resource "aws_s3_bucket_object" "s3MultipleObject"{
  bucket = aws_s3_bucket.my-s3-bucket.id
  for_each = fileset("/home/kalyan/Desktop/static_website/vaseem1.github.io-main","*")
  key = each.value
  source = "/home/kalyan/Desktop/static_website/vaseem1.github.io-main/${each.value}"
  etag = filemd5("/home/kalyan/Desktop/static_website/vaseem1.github.io-main/${each.value}")
}

