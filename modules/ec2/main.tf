resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.web_sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              sudo sed -i 's/<h1>Welcome to nginx!<\/h1>/<h1>Welcome to Terraform<\/h1>/' /var/www/html/index.nginx-debian.html
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "web_instance"
  }
}

