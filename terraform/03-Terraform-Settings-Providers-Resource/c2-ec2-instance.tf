# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = "ami-051f7e7f6c2f40dc1"
  instance_type = "t3.small"
  key_name      = "venkat-pem"

  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}