hcloud_servers = [
  {
    name          = "nyx"
    server_type   = "cx11"
    os            = "centos",
    major_version = "7",
    location      = "nbg1"
    # ansible_enabled = true,
    # playbook        = "playbook.yml"
    ssh_keys = []
  },
]

# hcloud_floating_ips = [
#   {
#     description = "www.diplodocus.ro"
#     server_name = "diplodocus"
#     dns_ptr     = "www.diplodocus.ro"
#   },
# ]
