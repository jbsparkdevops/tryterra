resource "google_project_service" "iam" {
  project           = var.project_id
  service           = "iam.googleapis.com"
  disable_on_destroy = true
}

resource "google_project_service" "secretmanager" {
  project           = var.project_id
  service           = "secretmanager.googleapis.com"
  disable_on_destroy = true
}

resource "google_compute_network" "vpc_network" {
  project = var.project_id
  name    = "bharghav-network"
  mtu     = 1460
}

resource "google_compute_subnetwork" "custom_test" {
  project       = var.project_id
  name          = "bharghav-sub"
  ip_cidr_range = "10.2.0.0/28"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name
}


