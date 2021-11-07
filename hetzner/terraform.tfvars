hcloud_servers = [
  {
    name          = "samedin.ro"
    server_type   = "cx11"
    os            = "centos",
    major_version = "7",
    location      = "nbg1"
    # ansible_enabled    = true,
    playbook           = "restic.yml"
    ssh_keys           = []
    delete_protection  = false
    rebuild_protection = false
    user               = "darkelf"
  },
  {
    name          = "bck.samedin.ro"
    server_type   = "cx11"
    os            = "centos",
    major_version = "7",
    location      = "nbg1"
    ssh_keys      = []
  },
]

hcloud_floating_ips = [
  {
    description = "samedin.ro"
    server_name = "samedin.ro"
    dns_ptr     = "samedin.ro"
  },
]
