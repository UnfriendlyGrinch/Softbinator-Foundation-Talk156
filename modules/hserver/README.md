# Terraform module for Hetzner Cloud Server resource

# Overview

This Terraform module creates a server on the Hetzner Cloud Infrastructure.

## What is a Terraform module?

Modules are containers for multiple resources that are used together. A module consists of a collection of `.tf` and/or `.tf.json` files kept together in a directory.

### Root Module

Every Terraform configuration has at least one module, known as its *root* module, which consists of the resources defined in the `.tf` files in the main working directory.

### Child Modules

A Terraform module (usually the root module of a configuration) can *call* other modules to include their resources into the configuration. A module that has been called by another module is often referred to as a *child* module.

# Inputs

Input variables serve as parameters for a Terraform module, allowing aspects of the module to be customized without altering the module's own source code, and allowing modules to be shared between different configurations.

## Required Inputs

**name** (string)

Description: "Server Name"

**server_type** (string)

Description: "Server Type"

**image** (string)

Description: "Server Image"

**location** (string)

Description: "Server Location"

## Optional Inputs

These variables have default values and therefore they are considered to be *optional* and the default value will be used if no value is set when calling the module or running Terraform.

**ansible_enabled** (bool)

Description: "Enable the execution of the Ansible Playbook"

Default: `false`

**playbook** (string)

Description: "Playbook to be executed upon resource creation"

Default: `playbook.yml`

**backups** (bool)

Description: "Disable backups"

Default: `false`

**ssh_keys** (list(string))

Description: "SSH Keys to be added"

Default: `[]`

**delete_protection** (bool)

Description: "Enable delete protection"

Default: `true`

**rebuild_protection** (bool)

Description: "Enable rebuild protection (Needs to be the same as delete_protection)."

Default: `true`

**user** (string)

Description: "User to be used for the connection"

Default: `root`

# Outputs

Output values, the return values of a Terraform module, provide a convenient manner to export structured data about the managed resources.

**id**

Description: "The ID of the Server"

**ipv4_address**

Description: "The IP Address of the Server"

# Resources

The module will create up to two resources depending on the `ansible_enabled` variable.

The modules defines two resource types:
- [hcloud_server.base-server](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server)
- [null_resource.ansible-playbook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)

# Usage

## Prerequisites

- Ensure [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) is installed.

> **NOTE** You will need Terraform v0.15 or newer in order to use this module.

## Examples

```bash
module "khutulun" {
  source = "../../../modules/hetzner" # The relative path to the desired child module

  name        = "khutulun"
  server_type = "cx11"
  image       = "centos-7"
  location    = "nbg1"
  ssh_keys    = ["darkelf.pub", "grassharper.pub"]
}
```

# References

- [Hetzner Cloud Provider](https://registry.terraform.io/providers/hetznercloud/hcloud/latest)
- [Null Provider](https://registry.terraform.io/providers/hashicorp/null/latest/docs)

# Author Information

- [Elif Samedin](elif.samedin@gmail.com)
