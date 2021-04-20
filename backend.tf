terraform {
  backend "s3" {
    bucket = "Terraform"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}
