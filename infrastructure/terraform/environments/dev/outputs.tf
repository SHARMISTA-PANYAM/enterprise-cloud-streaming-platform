output "vpc_id" {
  description = "ID of the DEV VPC."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the DEV public subnets."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the DEV private subnets."
  value       = module.network.private_subnet_ids
}

output "availability_zones" {
  description = "Availability Zones used by the DEV network."
  value       = module.network.availability_zones
}