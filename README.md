# Terraform Project

Reusable Terraform modules for provisioning AWS VPC, Security Group, and EC2 resources across multiple environments.

## Repository Structure

```text
Terraform_Project/
├── modules/
│   ├── ec2/
│   │   └── main.tf
│   ├── sg/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── vpc/
│       ├── main.tf
│       └── outputs.tf
└── README.md
```

## Design Principles

- Modules are environment-agnostic and reusable for dev, qa, and prod.
- Environment-specific values are passed from environment root configurations.
- AWS-generated IDs are shared between modules through outputs.
- No static infrastructure IDs are hardcoded in module logic.

## Module Contracts

### VPC Module

- Purpose: Creates VPC networking resources.
- Key inputs: name, cidr, azs, public_subnets, private_subnets, enable_nat_gateway, enable_vpn_gateway, tags.
- Key outputs: vpc_id, vpc_cidr_block, public_subnets, private_subnets.

### Security Group Module

- Purpose: Creates an HTTP-enabled security group in a target VPC.
- Key inputs: name, description, vpc_id, ingress_cidr_blocks.
- Key outputs: security_group_id.

### EC2 Module

- Purpose: Creates an EC2 instance.
- Key inputs: name, instance_type, subnet_id, tags.
- Key outputs: Managed by upstream Terraform AWS EC2 module outputs as needed.

## Dependency Flow

1. VPC module provisions network resources.
2. VPC outputs provide subnet and VPC IDs.
3. Security Group module consumes VPC ID.
4. EC2 module consumes subnet ID.

## Security and Configuration Standards

- Keep variable definitions in code and environment values in tfvars or environment variables.
- Do not commit credentials, secrets, or local state files.
- Use consistent tagging standards across environments.

Suggested gitignore entries:

```gitignore
*.tfvars
*.tfvars.json
*.auto.tfvars
*.tfstate
*.tfstate.*
.terraform/
```

## Terraform Workflow

Run from the selected environment folder:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
