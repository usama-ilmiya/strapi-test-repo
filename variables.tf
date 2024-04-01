variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  default = "env-ilmiya-dev"
}

variable "region" {
  description = "The region in which the resources will be created"
  type        = string
  default = "us-central1"

}

variable "shared_vpc_name" {
  description = "The name of the shared VPC host project"
  type        = string
  default = "ilmiya-shared-vpc-dev"
}

variable "shared_network_name" {
  description = "The name of the shared VPC network"
  type        = string
  default = "amer"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default = "ilmiya-subnet-dev"

}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default = "10.10.0.0/24"
}
