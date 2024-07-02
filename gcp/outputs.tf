output "ip_address" {
  value       = google_compute_instance.orchestra-instance[*].network_interface[0].access_config[0].nat_ip
  description = "The public IP address of your Compute Engine instances."
}