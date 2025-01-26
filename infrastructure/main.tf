# Generate key pair for SSH access
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "webserver-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

##Create and bootstrap webserver
resource "aws_instance" "webserver" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id
  key_name                    = aws_key_pair.generated_key.key_name
  user_data                   = "${file("setup_astro.sh")}"

  tags = {
    Name        = "webserver"
    Environment = var.environment
    Terraform   = "true"
  }
}

# Output the private key and public IP
output "private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}

output "public_ip" {
  value = aws_instance.webserver.public_ip
}
