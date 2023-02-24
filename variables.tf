variable "gcp_region" {
  type = string
  description = "GCP Region to use for deploying"
}
variable "prefix" {
  type = string
  description = "A prefix to use for resources created"
}

variable "classic_vpn_subnet_cidr" {
  type        = string
  description = "VPN Network Subnet 1"
  default     = "10.0.0.0/24"
}

variable "remote_vpn_subnet_cidr" {
  type        = string
  description = "VPN Network Subnet remote"
  default     = "192.168.0.0/16"
}

variable "host_peer_ip" {
  type = string
  description = "The host machine peer ip to pass in the vpn"
}

variable "gcp_project" {
  type = string
  description = "Google Project to deploy the VPN"
}

variable "shared_secret" {
  type = string
  description = "Shared secret for the IPSec tunnel"
}