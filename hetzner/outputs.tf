output "hcloud_servers_ips" {
  value = [for server, attributes in module.servers : "${server} ${attributes.ipv4_address}"]
}
