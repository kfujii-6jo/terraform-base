terraform {
  backend "s3" {
    bucket = "terraform-backend-kfujii"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}