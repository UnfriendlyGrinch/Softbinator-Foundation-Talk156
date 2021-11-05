locals {
  hcloud_servers = defaults(var.hcloud_servers, {
    image           = "",
    os              = "",
    major_version   = "",
    ansible_enabled = false,
    playbook        = "playbook.yml"
  })
}

locals {
  hcloud_floating_ips = defaults(var.hcloud_floating_ips, {
    delete_protection = true
  })
}
