terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  # This is an experimental feature.
  # https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes
  experiments      = [module_variable_optional_attrs]
  required_version = ">= 0.15"
}
