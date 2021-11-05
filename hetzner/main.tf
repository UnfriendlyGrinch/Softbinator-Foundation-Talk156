# Providers
provider "hcloud" {

}

# Data Sources
data "hcloud_images" "custom" {
  with_selector = "env=softbinator"
  most_recent   = true
}

# Resources
module "servers" {
  for_each = { for hcloud_server in local.hcloud_servers : hcloud_server.name => hcloud_server }

  source          = "../modules/hserver"
  name            = each.key
  server_type     = each.value.server_type
  image           = length(each.value.image) == 0 ? element(data.hcloud_images.custom.images.*.id, index(data.hcloud_images.custom.images.*.description, "softbinator-${format("%s-%s", each.value.os, each.value.major_version)}")) : each.value.image
  location        = each.value.location
  ssh_keys        = each.value.ssh_keys
  ansible_enabled = each.value.ansible_enabled
  playbook        = each.value.playbook
}

resource "hcloud_floating_ip" "servers_floating_ips" {
  for_each = { for hcloud_floating_ip in local.hcloud_floating_ips : hcloud_floating_ip.description => hcloud_floating_ip }

  type              = "ipv4"
  description       = each.key
  server_id         = lookup(lookup(module.servers, "${each.value.server_name}"), "id")
  delete_protection = each.value.delete_protection
}
