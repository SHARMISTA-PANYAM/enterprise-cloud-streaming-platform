provider "aws" {
  region = "us-east-2"
}

module "network" {
  source = "../../modules/network"

  project_name = "enterprise-cloud-streaming-platform"
  environment  = "dev"

  vpc_cidr = "10.20.0.0/16"

  availability_zones = [
    "us-east-2a",
    "us-east-2b"
  ]

  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.20.11.0/24",
    "10.20.12.0/24"
  ]

  tags = {
    Owner      = "platform-engineering"
    CostCenter = "portfolio"
  }
}