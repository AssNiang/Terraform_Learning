provider "aws" {
    region = "us-east-1"
}

data "external" "random" {
     program= ["python3", "scripts/random-name.py"]
}

resource "aws_instance" "my_ec2_instance" {
    ami = "ami-085925f297f89fce1"
    instance_type = "t2.micro"

     tags = {
        Name = "${data.external.random.result.random_name}-ec2"
    }
}