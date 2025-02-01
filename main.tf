resource "google_project_service" "iam" {
  project           = var.project_id
  service           = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "secretmanager" {
  project           = var.project_id
  service           = "secretmanager.googleapis.com"
  disable_on_destroy = true
}

resource "google_storage_bucket" "terraform-state-bucket" {
  project       = var.project_id
  name          = "bharghav-bucket-1234"
  location      = "us-central1"
  force_destroy = true

  uniform_bucket_level_access = true

  cors {
    max_age_seconds = 3600
  }
}
