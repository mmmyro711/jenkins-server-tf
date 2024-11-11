terraform {
  backend "s3" {
    bucket = "terraform-session-jan-backend-myroslav"                         # backend s3 bucket name
    key    = "class/may24/jenkins/classwork/ec2/new-terraform/server.tfstate" # backend path and file name
    region = "us-east-1"
  }
}