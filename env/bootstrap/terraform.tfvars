aws_region           = "ap-south-1"
aws_profile          = "default"
tf_state_bucket_name = "khajursi-terraform-state-shared-2026"
tf_lock_table_name   = "terraform-locks-shared"

tags = {
	Environment = "bootstrap"
	Project     = "terraform-project"
	ManagedBy   = "terraform"
}
