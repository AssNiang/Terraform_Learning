provider "aws" {
    region = "us-east-1"
}

module "website_s3_bucket" {
    source = "./modules/aws-s3-static-website-bucket"
    bucket_name = "terraform-sas-wbsite"
}