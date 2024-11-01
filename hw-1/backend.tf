resource "aws_s3_bucket" "my_bucket" {
  bucket = "myroslav-s3-bucket-jenkins" # Ensure this name is globally unique
  tags = {
    Name        = "MyBucket"
    Environment = "homework"
  }
}

 