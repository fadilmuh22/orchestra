# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MIT

output "ip_address" {
  value = digitalocean_droplet.ecoviary-drop[*].ipv4_address
  description = "The public IP address of your droplet application."
}
