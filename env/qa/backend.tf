terraform {
  backend "s3" {
    key            = "env/qa/terraform.tfstate"
    encrypt        = true
  }
}
