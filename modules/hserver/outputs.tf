output "id" {
  description = "The ID of the Server"
  value       = hcloud_server.base-server.id
}

output "ipv4_address" {
  description = "The IP Address of the Server"
  value       = hcloud_server.base-server.ipv4_address
}
