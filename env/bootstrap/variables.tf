variable "aws_region" {
  description = "AWS region for Terraform backend resources"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile for Terraform backend resources"
  type        = string
}

variable "tf_state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "tf_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}

variable "tags" {
  description = "Common tags for backend resources"
  type        = map(string)
  default     = {}
}