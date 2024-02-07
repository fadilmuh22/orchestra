# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MIT

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

resource "digitalocean_droplet" "ecoviary-drop" {
  count     = 2
  image     = "ubuntu-22-04-x64"
  name      = "ecoviary-drop-${count.index}"
  region    = "sgp1"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [data.digitalocean_ssh_key.keys.id]
}

resource "digitalocean_project_resources" "project" {
  project = data.digitalocean_project.ecoviary.id
  resources = flatten([
    digitalocean_droplet.ecoviary-drop[*].urn
  ])
}


data "digitalocean_ssh_key" "keys" {
  name = "fadil-wsl-ubuntu"
}

data "digitalocean_project" "ecoviary" {
  name = "ecoviary"
}
