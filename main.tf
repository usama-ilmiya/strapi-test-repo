provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "strapi-allow-ssh"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "strapi-allow-http"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "strapi-allow-https"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.vpc_network
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_instance" "strapi" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<EOF
#!/bin/bash

# Update and install dependencies
sudo apt-get update
sudo apt-get install -y docker.io docker-compose wget

# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Pull Strapi Docker image
sudo docker pull strapi/strapi

# Run Strapi Docker container
sudo docker run -d --name=strapi -p 80:1337 strapi/strapi
EOF
}

output "instance_ip" {
  value = google_compute_instance.strapi.network_interface[0].access_config[0].nat_ip
}
