provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "ubuntu-ami" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20210928"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "my_ec2_instance" {
    ami = data.aws_ami.ubuntu-ami.id
    instance_type = "t2.micro"
}

output "deprecation_time" {
  value = data.aws_ami.ubuntu-ami.deprecation_time
}
