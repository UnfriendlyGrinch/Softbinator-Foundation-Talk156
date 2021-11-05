terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }

  required_version = ">= 0.15"
}

resource "hcloud_server" "base-server" {
  name               = var.name
  server_type        = var.server_type
  image              = var.image
  location           = var.location
  backups            = var.backups
  ssh_keys           = var.ssh_keys
  delete_protection  = var.delete_protection
  rebuild_protection = var.rebuild_protection
}

resource "null_resource" "ansible-playbook" {
  count = var.ansible_enabled ? 1 : 0

  provisioner "remote-exec" {
    connection {
      host = hcloud_server.base-server.ipv4_address
      user = "root"
    }

    inline = ["echo 'READY'"]
  }

  provisioner "local-exec" {
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hcloud.yml -l ${hcloud_server.base-server.name} plays/${var.playbook} -u root"
    working_dir = "${path.cwd}/ansible"
  }
}
