provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
    ami = "ami-085925f297f89fce1"
    instance_type = "t2.micro"

    tags = {
        Name = "${terraform.workspace == "prod" ? "prod-ec2" : "default-ec2"}"
    }
}

terraform {
  backend "s3" {
    bucket = "terraform-sas792"
    key    = "states/terraform.state"
    region = "us-east-1"
  }
}