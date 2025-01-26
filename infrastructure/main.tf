##Create and bootstrap webserver
resource "aws_instance" "webserver" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id
  user_data                   = "${file("setup_apache.sh")}"

  tags = {
    Name        = "webserver"
    Environment = var.environment
    Terraform   = "true"
  }
}

# Output the public IP
output "public_ip" {
  value = aws_instance.webserver.public_ip
}
