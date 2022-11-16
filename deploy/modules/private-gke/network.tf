
resource "google_compute_global_address" "external_ip" {
  project      = "mimetic-plate-368221" # TODO: Template this to be passed by variables
  name         = "ipv6-address"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}
