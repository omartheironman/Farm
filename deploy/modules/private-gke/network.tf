
resource "google_compute_global_address" "external_ip" {
  project      = "mimetic-plate-368221" # Replace this with your service project ID in quotes
  name         = "ipv6-address"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}