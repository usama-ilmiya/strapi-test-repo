variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "env-ilmiya-dev"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-east1-c"
}

variable "vpc_network" {
  description = "Name of the VPC network"
  type        = string
  default     = "strapi-network"
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "strapi-vm"
}

variable "machine_type" {
  description = "Type of machine for the VM instance"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "Operating system image for the VM instance"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}
