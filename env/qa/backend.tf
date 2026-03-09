terraform {
  backend "s3" {
    bucket         = "siddharth-terraform-state-shared-2026-use2"
    key            = "env/qa/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks-shared"
    encrypt        = true
  }
}
