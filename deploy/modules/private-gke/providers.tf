terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.43.0"
    }
    google-beta = {
        source = "hashicorp/google-beta"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

data "google_client_config" "default" {}

provider "google" {
  # Configuration options
  credentials = "${file("/key.json")}". #Injected into env
  project = var.project
  region  = var.location
}

provider "kubernetes" {
    host = "https://${google_container_cluster.primary.endpoint}"
    token = data.google_client_config.default.access_token
    config_path    = "~/.kube/config"
    config_context = "gke_mimetic-plate-368221_us-central1_farm-gke-cluster"

}
