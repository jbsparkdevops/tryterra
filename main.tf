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


