
resource "aws_instance" "myjenkins_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  user_data              = file("script.sh")
  subnet_id              = aws_subnet.public[0].id
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]

  tags = {
    Name = "new_jenkins-server"
  }
}
