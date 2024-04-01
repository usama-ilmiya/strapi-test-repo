variable "project_id" {
  description = "The ID of the GCP project"
  default     = "env-ilmiya-dev"
}

variable "region" {
  description = "The region in which the resources will be created"
  default     = "us-central1"
}

variable "shared_vpc_name" {
  description = "The name of the shared VPC host project"
  default     = "shared_vpc_ilmiya_1"
}

variable "shared_network_name" {
  description = "The name of the shared VPC network"
  default     = "shared_network_ilmiya_1"
}

variable "subnet_name" {
  description = "The name of the subnet"
  default     = "shared_subnet_ilmiya_1"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.10.0.0/24"
}

# Add other variables as needed
