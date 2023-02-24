resource "google_compute_address" "vpn-ext-ip" {
  name = "${var.prefix}-vpn-ext-ip"
  description = "A tf managed ip for the peer ip in the vpn"
}

# Create the Network for VPN Project
resource "google_compute_network" "vpn-network-classic" {
  name    = "${var.prefix}-vpn-network-classic"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = "false"
}

# Create a Subnet 
resource "google_compute_subnetwork" "vpn-network-subnet-classic" {
  depends_on = [google_compute_network.vpn-network-classic]
 
  name          = "${var.prefix}-vpn-subnet-classic"
  ip_cidr_range = var.classic_vpn_subnet_cidr
  region        = var.gcp_region
  network       = google_compute_network.vpn-network-classic.name
}


resource "google_compute_vpn_gateway" "vpn_gateway" {
  name    = "${var.prefix}-vpn-gateway"
  network = google_compute_network.vpn-network-classic.id
  description = "A tf managed VPN gateway"
  depends_on = [
    google_compute_network.vpn-network-classic
    ]
}

resource "google_compute_vpn_tunnel" "vpn_tunnel" {
  name          = "${var.prefix}-private-vpn-tunnel"
  peer_ip       = var.host_peer_ip
  region = var.gcp_region
  ike_version = 1
  shared_secret = var.shared_secret
  target_vpn_gateway = google_compute_vpn_gateway.vpn_gateway.self_link
  description = "A tf managed VPN tunnel"
 
  local_traffic_selector = [var.classic_vpn_subnet_cidr]
  remote_traffic_selector = [var.remote_vpn_subnet_cidr]

  depends_on = [
    google_compute_forwarding_rule.vpn-fr-esp-classic,
    google_compute_forwarding_rule.vpn-fr-udp500-classic,
    google_compute_forwarding_rule.vpn-fr-udp4500-classic,
    google_compute_vpn_gateway.vpn_gateway
  ]
}

# VPN Forwarding Rule ESP
resource "google_compute_forwarding_rule" "vpn-fr-esp-classic" {
  name        = "${var.prefix}-vpn-gateway-fr-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn-ext-ip.address
  target      = google_compute_vpn_gateway.vpn_gateway.id
}

# VPN Forwarding Rule UDP 500
resource "google_compute_forwarding_rule" "vpn-fr-udp500-classic" {
  name        = "${var.prefix}-vpn-gateway-fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn-ext-ip.address
  target      = google_compute_vpn_gateway.vpn_gateway.id
}

# VPN Forwarding Rule UDP 4500
resource "google_compute_forwarding_rule" "vpn-fr-udp4500-classic" {
  name        = "${var.prefix}-vpn-gateway-fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn-ext-ip.address
  target      = google_compute_vpn_gateway.vpn_gateway.id
}
