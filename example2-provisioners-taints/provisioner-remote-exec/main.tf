provider "aws" {
    region  = "us-east-2"
}

resource "aws_key_pair" "my_ec2" {
    key_name   = "terraform-key"
    public_key = file("~/terraform/terraform.pub")
}

resource "aws_security_group" "instance_sg" {
    name = "terraform-test-sg"
  
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "my_ec2" {
    key_name      = aws_key_pair.my_ec2.key_name
    ami = "ami-0bb220fc4bffd88dd"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance_sg.id]
    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("~/terraform/terraform")
        host        = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
          "sudo apt-get -y update",
          "sudo apt-get install -y apache2",
          "sudo systemctl start apache2",
          "sudo systemctl enable apache2",
          "sudo sh -c 'echo \"<h1>Hello Ass NIANG / DI2 / GIT /EPT</h1>\" > /var/www/html/index.html'",
        ]
    }
}

output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}