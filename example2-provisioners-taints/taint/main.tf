provider "aws" {
  profile    = "default"
  region     = "us-west-2"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-06ffade19910cbfc0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    on_failure = continue # fail is the default one
    command = "echo ${aws_instance.my_ec2.public_ip} > ip_address.txt"
  }

}
