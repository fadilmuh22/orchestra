terraform {
  required_version = ">= 1.0.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "orchestra-drop" {
  count     = 2
  image     = "ubuntu-22-04-x64"
  name      = "orchestra-drop-${count.index}"
  region    = "sgp1"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [data.digitalocean_ssh_key.keys.id]
}

resource "digitalocean_project_resources" "project" {
  project = data.digitalocean_project.orchestra.id
  resources = flatten([
    digitalocean_droplet.orchestra-drop[*].urn
  ])
}


data "digitalocean_ssh_key" "keys" {
  name = "fadillads-ubuntu"
}

data "digitalocean_project" "orchestra" {
  name = "orchestra"
}
