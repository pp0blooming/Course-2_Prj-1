terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# # Creation of VM in AWS 
#  - Security Group
resource "aws_security_group" "allow_SSH2" {
  name        = "allow_SSH2"
  description = "Allow SSH inbound traffic"

  #  - INBOUND 
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  #  - OUTBOUND RULES 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#  - key pair
resource "aws_key_pair" "deployer2" {
  key_name   = "deployer-key2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD8gTEP0wdqJnHkVDc7IMzFygpsibTemZylZvk4gcGiaa+YX8/VpUEyOrqYOg/8OrOAsdQCpPcc8J3AhUBSvgjeKc7sJZ0N8v+AOKnVQDni/y+9mWD6oGOszzH6DVfoHOy1HRZAbF6n+xFkk0DeisSJ3FsGVQK/J5rYgXVCBJii34mL0+DOBogxLva8tDcLgWLz+qxs8QcH4hgrHkdT8whBKfKcypICGS4U/WgXFW5M3pN4OynSzeqJ9gXn0Fbq50J/t6Cpnr6wqlzRzocAMXnlgrchYZWZJgTL3W8zrg1Fx7RBy3fAbEyWoyrkB9cFIPSkmiUZG9xUhirI4MbdgHVNlkp7xU0V6KfCRlTNE+xzWlbPSga7kjlqiizjDoR7xExKNLbNthB6nlNIEwX+FljtgrTqMV2w6k8H3xfrhdG0993EnMMwdPVmltEjJeZ+l3BETUcibKGFFc5iyR99W7NKhriH5d6OvbXev7JmbqsXrwn8rnu3auDGJs7YaIwzmk= varunmanikoutlo@ip-172-31-17-206"
}


# - Add VM AWS AMI     ami-090fa75af13c156b4 (this # was copied in the launch_instance->AMI) 
resource "aws_instance" "amz-linux" {
  ami                    = "ami-090fa75af13c156b4"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer2.key_name
  count                  = 1
  vpc_security_group_ids = ["${aws_security_group.allow_SSH2.id}"]
  # tags = {
  #   "Name" = "Linux-Node"
  #   "ENV"  = "Dev"
  # }
  # depends_on = [aws_key_pair.deployer1]
}

