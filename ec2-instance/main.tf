provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "sample_app" {
  name        = "${var.name}-${count.index + 1}"
  description = "Allow HTTP traffic into ${var.name}"
  count       = var.instance_count
}


resource "aws_security_group_rule" "allow_http_inbound" {
  count = length(aws_security_group.sample_app)

  security_group_id = aws_security_group.sample_app[count.index].id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_instance" "sample_app" {
  ami                  = var.ami_id
  instance_type        = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sample_app[count.index].id]
  user_data            = file("${path.module}/user-data.sh")
  count                = var.instance_count
  tags = {
    Name = "${var.name}-${count.index + 1}"
  }

}