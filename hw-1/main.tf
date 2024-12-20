data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "myjenkins_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  user_data              = file("script.sh")
  #subnet_id                   = data.aws_subnet.pub_subnet_1.id
  key_name               = "new-key-pair-east1"
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.s3_full_access_instance_profile.name

  tags = {
    Name = "jenkins-server-hw"
  }
}
# Create an IAM Role for EC2 with S3 full access
resource "aws_iam_role" "s3_full_access_role" {
  name = "s3_full_access_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}
# Attach the S3 full access policy to the role
resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  role       = aws_iam_role.s3_full_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
# Create an instance profile for the IAM role
resource "aws_iam_instance_profile" "s3_full_access_instance_profile" {
  name = "s3_full_access_instance_profile"
  role = aws_iam_role.s3_full_access_role.name
}
# # route53 - hosted zone
# data "aws_route53_zone" "kloudgate_hosted_zone" {
#   name = var.hosted_zone_name
# }


