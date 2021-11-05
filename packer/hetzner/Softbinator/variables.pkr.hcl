variable "hcloud-servertype" {
  type    = string
  default = "cx11"
}

variable "hcloud-token" {
  type    = string
  default = env("HCLOUD_TOKEN")
}
