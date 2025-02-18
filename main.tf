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
provider "google" {
  project = var.project_id
  region  = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "proxy_only_subnet" {
  name          = "proxy-only-subnet"
  network       = google_compute_network.vpc_network.id
  region        = "us-central1"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  ip_cidr_range = "10.129.0.0/23"

  depends_on = [google_compute_network.vpc_network]
}


