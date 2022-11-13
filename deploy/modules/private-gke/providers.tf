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
  credentials = "${file("/Users/omar/Downloads/key.json")}"
  project = "mimetic-plate-368221"
  region  = "us-central1"
}

provider "kubernetes" {
    host = "https://${google_container_cluster.primary.endpoint}"
    token = data.google_client_config.default.access_token
    config_path    = "~/.kube/config"
    config_context = "gke_mimetic-plate-368221_us-central1_farm-gke-cluster"

}