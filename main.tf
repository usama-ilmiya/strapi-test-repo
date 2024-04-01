# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create the shared VPC network
resource "google_compute_network" "shared_network" {
  name                    = var.shared_network_name
  auto_create_subnetworks = false
}

# Create the subnet within the shared VPC network
resource "google_compute_subnetwork" "shared_subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.shared_network.self_link
  ip_cidr_range = var.subnet_cidr
}

# Set up IAM roles for shared VPC
resource "google_project_iam_member" "shared_vpc_admin" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:service-${var.project_id}@gcp-sa-terraform.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "shared_subnet_user" {
  project = var.project_id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:service-${var.project_id}@gcp-sa-terraform.iam.gserviceaccount.com"
}

# Create required firewall rules
resource "google_compute_firewall" "allow_ingress" {
  name    = "allow-ingress"
  network = google_compute_network.shared_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Add other resources as needed
