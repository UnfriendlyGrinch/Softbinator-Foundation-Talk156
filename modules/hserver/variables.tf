### REQUIRED VARIABLES ###

variable "name" {
  description = "Server Name"
  type        = string
}

variable "server_type" {
  description = "Server Type"
  type        = string
}

variable "image" {
  description = "Server Image"
  type        = string
}

variable "location" {
  description = "Server Location"
  type        = string
}

### OPTIONAL VARIABLES ###

variable "ansible_enabled" {
  description = "Enable the execution of the Ansible Playbook"
  type        = bool
  default     = false
}

variable "playbook" {
  description = "Playbook to be executed upon resource creation"
  type        = string
  default     = "playbook.yml"
}

variable "backups" {
  description = "Disable backups"
  type        = bool
  default     = false
}

variable "ssh_keys" {
  description = "SSH Keys to be added"
  type        = list(string)
  default     = []
}

variable "delete_protection" {
  description = "Enable delete protection"
  type        = bool
  default     = true
}

variable "rebuild_protection" {
  description = "Enable rebuild protection (Needs to be the same as delete_protection)."
  type        = bool
  default     = true
}
