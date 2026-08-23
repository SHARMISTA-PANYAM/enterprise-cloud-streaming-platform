# AWS Network Foundation

## Overview

The DEV platform network is deployed in AWS `us-east-2` using a reusable Terraform module.

The network provides isolated public and private subnets across two Availability Zones and forms the foundation for future EKS, streaming, and platform workloads.

## Architecture

```text
                         Internet
                            |
                     Internet Gateway
                            |
                  Public Route Table
                   0.0.0.0/0 -> IGW
                     /             \
                    /               \
            us-east-2a           us-east-2b
            Public Subnet        Public Subnet
            10.20.1.0/24         10.20.2.0/24


                    VPC: 10.20.0.0/16


            us-east-2a           us-east-2b
            Private Subnet       Private Subnet
            10.20.11.0/24        10.20.12.0/24
                    \               /
                     \             /
                  Private Route Table
                   local routing only
```

## Components

- VPC: `10.20.0.0/16`
- Region: `us-east-2`
- Availability Zones: `us-east-2a`, `us-east-2b`
- Public Subnets: `10.20.1.0/24`, `10.20.2.0/24`
- Private Subnets: `10.20.11.0/24`, `10.20.12.0/24`
- Internet Gateway for public connectivity
- Separate public and private route tables
- Public default route: `0.0.0.0/0 -> Internet Gateway`
- Private subnets have no direct internet route

## Engineering Decisions

### Multi-AZ Design

Resources are distributed across two Availability Zones to provide a foundation for highly available workloads.

### Public and Private Segmentation

Internet-facing resources can use public subnets, while internal application and platform workloads can use private subnets.

### Cost-Aware DEV Environment

A NAT Gateway is intentionally not deployed in DEV because it introduces ongoing hourly and data-processing costs.

The architecture can be extended with NAT connectivity when private workloads require outbound internet access.

## Infrastructure as Code

The network is implemented as a reusable Terraform module:

`infrastructure/terraform/modules/network`

The DEV environment consumes the module from:

`infrastructure/terraform/environments/dev`

## Validation

The infrastructure was verified using:

- `terraform validate`
- GitHub Actions Terraform CI
- `terraform plan`
- Terraform state inspection
- AWS CLI
- AWS Console
- Post-deployment drift check

Final drift check:

`No changes. Your infrastructure matches the configuration.`
