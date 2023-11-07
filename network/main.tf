# VPC Network
resource "google_compute_network" "vpc_network" {
  project                 = "exp-prj-dev-001"
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

# SubNetwork
resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  project       = "exp-prj-dev-001"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
  depends_on = [ google_compute_network.vpc_network ]
}