resource "google_project_service" "iam" {
  project           = var.project_id
  service           = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "secretmanager" {
  project           = var.project_id
  service           = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "vivekkey"
  project   = var.project_id

  labels = {
    label = "serviceaccount"
  }

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "us-east1"
      }
    }
  }
}

resource "google_secret_manager_secret_version" "basic" {
  depends_on = [google_secret_manager_secret.secret-basic]
  secret      = google_secret_manager_secret.secret-basic.id
  secret_data = google_service_account.service_account.display_name
}

resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.name
  project      = var.project_id
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
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
