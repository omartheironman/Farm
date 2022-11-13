# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "farm-gke-cluster"
  location = "us-central1"
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  
    master_auth {
    client_certificate_config {
        issue_client_certificate = false
    }
}
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = "dev"
    }

    # preemptible  = true
    machine_type = "n1-standard-2"
    tags         = ["gke-node"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# resource "google_compute_global_forwarding_rule" "default" {
#   name                  = "l7-xlb-forwarding-rule"
#   ip_protocol           = "TCP"
#   load_balancing_scheme = "EXTERNAL"
#   port_range            = "80"
#   target                = google_compute_target_http_proxy.default.id
#   ip_address            = "34.120.245.36"
# }

# # http proxy
# resource "google_compute_target_http_proxy" "default" {
#   name     = "l7-xlb-target-http-proxy"
#   url_map  = google_compute_url_map.default.id
# }

# # url map
# resource "google_compute_url_map" "default" {
#   name            = "l7-xlb-url-map"
#   default_service = google_compute_backend_service.default.id
# }

# backend service with custom request and response headers
# resource "google_compute_backend_service" "default" {
#   name                    = "l7-xlb-backend-service"
#   protocol                = "HTTP"
#   port_name               = "service"
#   load_balancing_scheme   = "EXTERNAL"
#   timeout_sec             = 10
#   enable_cdn              = true
# }

resource "kubernetes_service_v1" "grafanasvc" {
  metadata {
    name = "grafanasvc"
    namespace = "farm-monitoring"
  }
  spec {
    selector = {
        "app.kubernetes.io/instance" = "grafana"
    }
    type = "LoadBalancer"
    port {
      name        = "http"
      port        = 3000
      target_port = 3000
    }

  }
}


resource "kubernetes_ingress_v1" "grafana_ingress" {
    metadata {
        name = "grafana-ingress"
        namespace = "farm-monitoring"
    }

    spec {
        default_backend {
            service {
                name = "grafanasvc"
                port {
                    number = 3000
                }
            }
        }

        rule {
            http {
                path {
                backend {
                    service {
                        name = "grafanasvc"
                    port {
                        number = 3000
                    }
                    }
                }

                path = "/grafana/*"
                }
            }
        }
    }
}
