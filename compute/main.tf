# enable compute engine API
resource "google_project_service" "compute_api" {
  project = "exo-prj-dev-001"
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

# Create compute instance
resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  # scratch_disk {
  #   interface = "NVME"
  # }

  network_interface {
    network    = "vpc-network"
    subnetwork = "test-subnetwork"

    # access_config {
    #   // Ephemeral public IP
    # }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    #email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

# Create a Disk
resource "google_compute_disk" "datadisk" {
  name  = "test-disk"
  type  = "pd-standard"
  zone  = "us-central1-a"

  # async_primary_disk {
  #   disk = google_compute_disk.primary.id
  # }

  # physical_block_size_bytes = 4096
}

# Attche disk to the instance
resource "google_compute_attached_disk" "datadisk-attach" {
  disk     = google_compute_disk.datadisk.id
  instance = google_compute_instance.default.id
}
