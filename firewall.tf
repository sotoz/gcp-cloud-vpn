
resource "google_compute_firewall" "allow_outbound_tcp" {
  name    = "allow-outbound-tcp"
  network = google_compute_network.vpn-network-classic.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  direction = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_inbound_tcp" {
  name    = "allow-inbound-tcp"
  network = google_compute_network.vpn-network-classic.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["vpn-server"]
}

resource "google_compute_firewall" "allow_outbound_udp" {
  name    = "allow-outbound-udp"
  network = google_compute_network.vpn-network-classic.name

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  direction = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_inbound_udp" {
  name    = "allow-inbound-udp"
  network = google_compute_network.vpn-network-classic.name

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["vpn-server"]
}