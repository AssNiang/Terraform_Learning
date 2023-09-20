provider "aws" {
  profile    = "default"
  region     = "us-west-2"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-06ffade19910cbfc0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    when    = destroy
    command = "echo \"destruction de l'instance ${self.public_ip}\" > ip_address.txt"
  }

}
