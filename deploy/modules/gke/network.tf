
resource "google_compute_global_address" "external_ip" {
  project      = var.project # TODO: Template this to be passed by variables
  name         = "ipv6-address"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}
