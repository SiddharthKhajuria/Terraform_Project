terraform {
  backend "s3" {
    bucket         = "siddharth-terraform-state-shared-2026"
    key            = "env/qa/terraform.tfstate"
    region         = "ap-south-1"
    profile        = "default"
    dynamodb_table = "terraform-locks-shared"
    encrypt        = true
  }
}
