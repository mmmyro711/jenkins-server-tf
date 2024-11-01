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
  key_name               = "new-key-pair-east1"
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]

  tags = {
    Name = "jenkins-server"
  }
}

