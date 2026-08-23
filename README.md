# Enterprise Cloud & Streaming Platform

An organization-level platform engineering project focused on building a secure,
scalable, self-service cloud platform for application and event-streaming workloads.

## Project Goal

The platform is designed to reduce infrastructure provisioning toil by providing
standardized, reusable capabilities for engineering teams.

Application teams should be able to consume platform services without manually
building networking, Kubernetes, streaming, CI/CD, security, and observability
infrastructure for every workload.

## Core Platform Capabilities

- AWS cloud infrastructure
- Terraform Infrastructure as Code
- Kubernetes and Amazon EKS
- Docker containerization
- Helm application packaging
- GitOps with Argo CD
- CI/CD with GitHub Actions
- Apache Kafka / Confluent streaming services
- Apache Flink streaming workloads
- Platform observability
- SRE practices and runbooks
- IAM and least-privilege security
- Secrets management
- Multi-environment architecture
- Self-service developer onboarding

## Target Architecture

The project will evolve toward a platform where engineering teams can request
standardized application and streaming infrastructure through configuration
stored in Git.

```text
Developer
    |
    v
GitHub Pull Request
    |
    v
CI / Validation
    |
    v
Platform Automation
    |
    +---- Terraform ----> AWS Infrastructure
    |
    +---- Kubernetes ---> EKS Workloads
    |
    +---- Kafka --------> Streaming Services
    |
    +---- Argo CD ------> GitOps Deployment
    |
    +---- Observability -> Metrics / Logs / Alerts

```
## Engineering Principles

- Infrastructure as Code
- Automation over manual provisioning
- Reusable platform abstractions
- Least-privilege security
- Git-based change management
- Observable systems
- Reproducible environments
- Failure-aware design
- Documented architecture decisions
- Cost-conscious cloud engineering

## Status

🚧 Active development

## Completed Capabilities

### 1. Self-Service Platform Onboarding

Built a Git-driven onboarding workflow that allows application teams to declare platform requirements through a standardized `ServiceRequest` YAML.

- Defined a reusable ServiceRequest contract for runtime, networking, Kafka, observability, and security requirements.
- Enforced platform standards using JSON Schema validation.
- Built a Python validation engine using PyYAML and jsonschema.
- Tested both valid and invalid onboarding requests.
- Integrated validation into GitHub Actions.
- Implemented feature branch → Pull Request → CI validation → squash merge workflow.

**Technologies:** YAML, JSON Schema, Python, GitHub Actions, Git

---

### 2. AWS Network Foundation

Designed, deployed, and verified a reusable multi-AZ AWS network foundation using Terraform.

- Created a reusable Terraform network module.
- Provisioned a `10.20.0.0/16` VPC in `us-east-2`.
- Distributed infrastructure across `us-east-2a` and `us-east-2b`.
- Created 2 public and 2 private subnets.
- Configured an Internet Gateway for public connectivity.
- Created separate public and private route tables.
- Routed public traffic through `0.0.0.0/0 → Internet Gateway`.
- Kept private subnets isolated from direct internet access.
- Standardized tagging, module inputs, and outputs.
- Added Terraform formatting and validation checks through GitHub Actions.
- Used short-lived non-root AWS authentication for infrastructure operations.
- Verified deployed resources using Terraform state, AWS CLI, and Terraform drift detection.
- Confirmed `terraform plan` reports no infrastructure drift.
- Kept NAT Gateway disabled in DEV to avoid unnecessary portfolio infrastructure cost.

**Technologies:** AWS VPC, Terraform, AWS CLI, IAM, GitHub Actions, Git