# terraform-aws-infra-modular

A modular refactor of [`terraform-aws-infra`](https://github.com/swish200183/terraform-aws-infra), demonstrating reusable, maintainable Terraform structure using modules.

This is Portfolio Project 2 in a series showcasing Terraform and AWS fundamentals, built as part of a transition into cloud infrastructure and DevOps engineering.

## Why modules

The original project defined every resource directly in a single `main.tf`. This version splits the same infrastructure into three self-contained modules — `network`, `compute`, and `storage` — each with its own inputs and outputs. This mirrors how real-world Terraform codebases are organized: components can be developed, tested, and reused independently.

## Architecture

Same infrastructure as Project 1, reorganized into modules:

- **`modules/network`** — VPC, public subnet, internet gateway, route table, security group
- **`modules/compute`** — EC2 instance (latest Amazon Linux 2023 AMI via data source)
- **`modules/storage`** — S3 bucket (globally unique via random suffix) and DynamoDB table

The root configuration calls each module and wires outputs from one module into the inputs of another — for example, the VPC's subnet and security group IDs from `network` are passed into `compute`.

## Project structure

```
terraform-aws-infra-modular/
├── main.tf              # Calls the three modules
├── variables.tf          # Root-level input variables
├── outputs.tf            # Outputs sourced from module outputs
├── providers.tf          # Terraform + AWS + random provider config
├── backend.tf             # Remote state (shared S3 bucket, separate state key)
└── modules/
    ├── network/
    ├── compute/
    └── storage/
```

## Prerequisites

- Terraform >= 1.5.0
- An AWS account with credentials configured (`aws configure`)
- The remote state backend already provisioned — see [`terraform-backend-bootstrap`](https://github.com/swish200183/terraform-backend-bootstrap)

## Usage

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

To tear down:

```bash
terraform destroy
```

## Notes

- This project shares the same S3 bucket and DynamoDB lock table as `terraform-aws-infra` for remote state, but uses a distinct state key (`terraform-aws-infra-modular/terraform.tfstate`) so the two projects' states never collide.
- No `provider` blocks exist inside any module — providers are configured once at the root and inherited by all modules.
- Module inputs and outputs are explicit and typed, keeping each module independently understandable and reusable.

## What this project demonstrates

- Terraform module design: inputs, outputs, and composition
- Passing data between modules without tight coupling
- Reusing a shared remote state backend across multiple projects
- Refactoring monolithic configuration into maintainable, modular code
