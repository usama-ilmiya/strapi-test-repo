provider "google-beta" {
  project = "env-ilmiya-dev"  # Replace with your actual project ID
  region  = var.region
}

# Create the shared VPC network in the host project
resource "google-beta_compute_shared_vpc_host_project" "host_project" {
  project = "env-ilmiya-net"  # Replace with your actual host project name
}

# Define the shared VPC network
resource "google-beta_compute_shared_vpc" "shared_vpc" {
  provider      = google-beta
  host_project  = google-beta_compute_shared_vpc_host_project.host_project.id
  name          = var.shared_network_name
}

# Create a subnet in the shared VPC network
resource "google-beta_compute_subnetwork" "subnet" {
  name              = var.subnet_name
  ip_cidr_range     = var.subnet_cidr
  region            = var.region
  network           = google-beta_compute_shared_vpc.shared_vpc.id
}

# Define other resources as needed (firewall rules, etc..)
