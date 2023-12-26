provider "aws" {
region = "us-east-1"
}


resource "aws_instance" "web" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  key_name      = "Batch5-keypair"
  user_data     = "${file("httpd.sh")}"
  vpc_security_group_ids = ["${aws_security_group.webSG.id}"]
  tags = {
    Name = "AIT-Test-file-provisioner"
  }
}


resource "aws_security_group" "webSG" {
  name        = "webSG"
  description = "Allow ssh  inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}
