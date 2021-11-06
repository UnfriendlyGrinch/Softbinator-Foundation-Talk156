variable "hcloud_servers" {
  description = "Servers and their attributes"
  type = list(object({
    name               = string
    server_type        = string
    image              = optional(string)
    os                 = optional(string)
    major_version      = optional(string)
    location           = string
    ssh_keys           = list(string)
    ansible_enabled    = optional(bool)
    playbook           = optional(string)
    delete_protection  = bool
    rebuild_protection = bool
    user               = optional(string)
  }))
}

variable "hcloud_floating_ips" {
  description = "IPs to be assigned"
  type = list(object({
    description       = string
    server_name       = string
    dns_ptr           = string
    delete_protection = optional(bool)
  }))
}
