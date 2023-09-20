provider "aws" {
  region = var.AWS_REGION # ou "${var.AWS_REGION}"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

# SECURITY GROUP est le firewall interne de notre serveur.
resource "aws_security_group" "instance_sg" {
  name = "terraform-test-sg"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

	# autoriser le traffic vers le port 80 (HTTP) >> serveur apache
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # toutes les @IP sont autorisées
  }
}

resource "aws_instance" "assniang_ec2_instance" {
  # Amazon Machine Image (executed image in the EC2 instance)
  ami = var.AWS_AMIS[var.AWS_REGION] 
  # EC2 instance type (CPU, memory, disk, network capacity)
  instance_type = "t2.micro" # 1 vCPU, 1 Go memory
  # Dire à l'instance d'utiliser le SCURITY GROUP créé
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "<h1>Hello Ass NIANG / DI2 / GIT /EPT<h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "terraform-test"
  }
}

output "public_ip" {
  value = aws_instance.assniang_ec2_instance.public_ip
}