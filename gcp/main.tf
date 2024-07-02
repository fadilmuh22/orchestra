terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

variable "project" {
  default = "orchestra-0"
}
variable "region" {
  default = "asia-southeast1"
}
variable "zone" {
  default = "asia-southeast1-a"
}
variable "credentials_file" {}
variable "ssh_public_key" {}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = file(var.credentials_file)
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "orchestra-instance" {
  count        = 1
  name         = "orchestra-instance-${count.index}"
  machine_type = "e2-standard-2"
  zone         = var.zone
  tags = [ "http-server", "https-server", "orchestra-instance" ]

  boot_disk {
    initialize_params {
      image = "ubuntu-2404-noble-amd64-v20240701a"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "root:${file(var.ssh_public_key)}"
  }
}

resource "google_compute_firewall" "orchestra_ssh" {
  name    = "orchestra-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["orchestra-instance"]
  source_ranges = ["0.0.0.0/0"]
}