variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  type = string # optionnel
  default = "us-east-2"
  description = "Région de notre variable ec2" # optionnel
}


variable "AWS_AMIS" {
    type = map(string)
    default = {
        "us-east-1" = "ami-085925f297f89fce1"
        "us-east-2" = "ami-0bb220fc4bffd88dd"
    }
}