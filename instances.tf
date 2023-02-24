resource "google_compute_instance" "vpn_server" {
    name         = "${var.prefix}-vpn-server"
    machine_type = "f1-micro"
    zone         = "europe-west4-a"
    can_ip_forward = true
    
    tags = [
        "vpn-server"
    ]
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
            size = 20
            }
        }

    network_interface {
        network = google_compute_network.vpn-network-classic.id
        subnetwork = google_compute_subnetwork.vpn-network-subnet-classic.id
    }
}