resource "aws_security_group" "simplelab_sg" {
  name      = "simplelab_sg"
  tags      = {
    Name    = "demo"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_tcp_80" {
  security_group_id = aws_security_group.simplelab_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ssh_22" {
  security_group_id = aws_security_group.simplelab_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

data "aws_ami" "ami_lookup" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["packer-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "simplelab_server" {
  ami                       = data.aws_ami.ami_lookup.id
  instance_type             = "t2.micro"
  vpc_security_group_ids    = [aws_security_group.simplelab_sg.id]

  tags = {
    Name = "demo"
  }
}