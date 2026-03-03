# Terraform_Project

Simple Terraform project using local modules for VPC and Security Group.

## Current Structure

```text
Terraform_Project/
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── sg/
│       ├── main.tf
│       └── outputs.tf
└── README.md
```

## What This Does

- `modules/vpc` creates a VPC.
- `modules/sg` creates a Security Group.
- VPC output gives `vpc_id`.
- SG output gives `security_group_id`.

## Why Outputs Matter

AWS generates IDs when resources are created.
`outputs.tf` exposes those IDs so other modules can use them.

Flow:

1. VPC module creates VPC.
2. VPC module outputs `vpc_id`.
3. SG module or environment code uses that `vpc_id`.
4. SG module outputs `security_group_id`.
5. EC2/ALB can use that SG ID.

## Variables and Secrets Best Practice

- Keep variable names in code.
- Keep real values local (`terraform.tfvars.local`) or `TF_VAR_*` env vars.
- Never commit real secrets to GitHub.

Suggested `.gitignore` entries:

```gitignore
*.tfvars
*.tfvars.json
*.auto.tfvars
*.tfstate
*.tfstate.*
.terraform/
```

## Commands (from env folder)

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
