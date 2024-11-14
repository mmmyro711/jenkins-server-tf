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
  owners = ["099720109477"]
}
# # route53 - hosted zone
# data "aws_route53_zone" "kloudgate_hosted_zone" {
#   name = var.hosted_zone_name
# }
# data "aws_route53_zone" "hosted_zone" {
#   name = var.hosted_zone_name
# }
