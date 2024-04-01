output "shared_vpc_project_id" {
  value = google_compute_shared_vpc_host_project.host_project.project
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

# Add other outputs as needed
