source "hcloud" "centos-7" {
  image           = "centos-7"
  location        = "nbg1"
  server_name     = "localhost.localdomain"
  server_type     = "${var.hcloud-servertype}"
  snapshot_name   = "softbinator-centos-7"
  snapshot_labels = { env = "softbinator", centos = "7" }
  ssh_username    = "root"
  token           = "${var.hcloud-token}"
}
