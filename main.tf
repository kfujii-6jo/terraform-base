resource "aws_instance" "this" {
  ami           = "ami-01bef798938b7644d"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.this.id]
  
  user_data = <<EOT
#!/bin/bash
sudo apt update
sudo apt install -y nginx
EOT
  
  user_data_replace_on_change = true

  tags = {
    Name = "terraform-ec2"
  }
}

resource "aws_security_group" "this" {
  name = "terraform-ec2-sg" 
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22 
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id 
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80 
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id 
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0 
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id 
}