output "hcloud_servers_ips" {
  value = [for server, attributes in module.servers : "${server} ${attributes.ipv4_address}"]
}

output "floating_ip" {
  value = [for server, attributes in hcloud_floating_ip.servers_floating_ips : "${server} ${attributes.ip_address}"]
}
