# Terraform Project

Terraform-based AWS infrastructure project using reusable modules and environment-specific root configurations.

## Diagram

```mermaid
flowchart TB
    U[Developer]

    subgraph BACKEND[Bootstrap Backend env/bootstrap]
      BTF[Terraform]
      S3[(S3 State Bucket)]
      DDB[(DynamoDB Lock Table)]
      BTF --> S3
      BTF --> DDB
    end

    subgraph QA[QA Infrastructure env/qa]
      QTF[Terraform]

      subgraph MOD[Module Layer]
        VPCM[VPC Module]
        SGM[SG Module]
        ECPUBM[EC2 Public Module\ncount = 2]
        ECPVTM[EC2 Private Module\ncount = 2]
      end

      subgraph NET[VPC Network]
        PUBS[Public Subnet 1]
        PVTS[Private Subnet 1]
        SGRES[(qa-web-sg)]

        subgraph PUBT[Public EC2 Tier]
          PUB1[EC2 Public #1]
          PUB2[EC2 Public #2]
        end

        subgraph PVTT[Private EC2 Tier]
          PVT1[EC2 Private #1]
          PVT2[EC2 Private #2]
        end
      end

      QTF --> VPCM
      QTF --> SGM
      QTF --> ECPUBM
      QTF --> ECPVTM

      VPCM --> PUBS
      VPCM --> PVTS
      SGM --> SGRES

      ECPUBM --> PUB1
      ECPUBM --> PUB2
      ECPVTM --> PVT1
      ECPVTM --> PVT2

      PUBS --> PUB1
      PUBS --> PUB2
      PVTS --> PVT1
      PVTS --> PVT2
    end

    U --> BTF
    U --> QTF
    QTF -. remote state .-> S3
    QTF -. state lock .-> DDB
```

Current QA EC2 distribution: 2 instances in public subnet(s) and 2 instances in private subnet(s).

## Project Overview

This repository provisions:

- Virtual Private Cloud (VPC) networking
- HTTP-enabled Security Group
- EC2 compute instance(s)
- Remote Terraform backend foundation (S3 state bucket + DynamoDB lock table)

## Repository Structure

```text
Terraform_Project/
├── env/
│   ├── bootstrap/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   ├── versions.tf
│   │   └── terraform.tfvars
│   └── qa/
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── variable.tf
│       ├── versions.tf
│       └── terraform.tfvars
├── modules/
│   ├── ec2/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── sg/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── vpc/
│       ├── main.tf
│       └── outputs.tf
└── README.md
```

## Module Summary

- `modules/vpc`: Provisions VPC, public/private subnets, and networking options.
- `modules/sg`: Provisions an HTTP-enabled security group in a target VPC.
- `modules/ec2`: Provisions one or more EC2 instances in a specified subnet.

## Environment Model

Each environment under `env/` is a Terraform root module and typically includes:

- `versions.tf` for Terraform/provider version constraints
- `provider.tf` for cloud provider configuration
- `variable.tf` for input variable declarations
- `main.tf` for module composition
- `outputs.tf` for environment outputs
- `terraform.tfvars` for environment values

The current repository includes:

- `env/bootstrap`: Creates shared backend resources (S3 state bucket with versioning and DynamoDB lock table).
- `env/qa`: Provisions workload infrastructure (VPC, SG, EC2) and consumes the remote backend.

To scale EC2 in QA, update `ec2_public_instance_count` and `ec2_private_instance_count` in `env/qa/terraform.tfvars`.

Additional environments (for example `env/prod`) can follow the same root-module pattern as `env/qa`.

## Prerequisites

- Terraform `>= 1.5.0`
- AWS CLI (v2 recommended)
- Valid AWS credentials/profile configured locally

## Terraform Workflow

Run from the selected environment folder:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

For first-time backend setup:

1. Run `terraform init && terraform apply` in `env/bootstrap`.
2. Configure backend in `env/qa` with `backend.tf` and pass backend values at init time.
3. Run in `env/qa`:

```bash
terraform init -migrate-state \
  -backend-config="bucket=<state-bucket-name>" \
  -backend-config="region=<aws-region>" \
  -backend-config="dynamodb_table=<lock-table-name>" \
  -backend-config="profile=<aws-profile>"
```

## Security and Version Control

- Do not commit secrets or credential material.
- Keep state and local Terraform artifacts out of source control.
- `*.tfvars`, `*.tfstate*`, `.terraform/`, and `.terraform.lock.hcl` are ignored by `.gitignore` in this repository.

## Troubleshooting

- **No Terraform configuration files**
  - Run Terraform from an environment root folder (for example, `env/qa`) or use `-chdir`.

- **InvalidClientTokenId / ExpiredToken**
  - Refresh AWS credentials for the active profile, then rerun `terraform plan`.
