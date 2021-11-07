
[[_TOC_]]

# Introduction

_**Ansible**_ can work against multiple systems at the same time, regardless of the level of depth and detail at the infrastructure level. It does this by selecting portions of systems listed in Ansible’s inventory file, which defaults to being saved in the location `/etc/ansible/hosts`. We can specify a different inventory file using the `-i <path>` option on the command line.

This inventory is configurable, but we can also use multiple inventory files at the same time and also pull inventory from dynamic or cloud sources, as described in Dynamic Inventory.

# Static inventories

## Hosts and Groups

The format for `/etc/ansible/hosts` is an _INI_-like format and looks like this:

```bash
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
```

The headings in brackets are group names, which are used in classifying systems and deciding what systems you are controlling at what times and for what purpose.

It is possible to put systems in more than one group, for instance a server could be both a webserver and a dbserver. If you do so, note that variables will come from all of the groups they are a member of. Please note that variable precedence is something we should be aware of when using [variables with Ansible](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable)

For hosts that run on non-standard SSH or aliases the following can be used:

```bash
jumper ansible_port=5555 ansible_host=192.0.2.50
```
Thus, trying to ansible against the host alias “jumper” (which may not even be a real hostname) will contact 192.0.2.50 on port 5555.

## Host Variables

To assign variables to hosts that will be used later in playbooks:

```bash
[atlanta]
host1 http_port=80 maxRequestsPerChild=808
host2 http_port=303 maxRequestsPerChild=909
```

## Group Variables

Variables can also be applied to an entire group at once:

```bash
[atlanta]
host1
host2

[atlanta:vars]
ntp_server=ntp.atlanta.example.com
proxy=proxy.atlanta.example.com
```

## Default groups

There are two default groups: _**all**_ and _**ungrouped**_. _**all**_ contains every host. _**ungrouped**_ contains all hosts that don’t have another group aside from _**all**_.
Therefore, variables declared in `inventory/group_vars/all` will apply to every host.


## List of Behavioral Inventory Parameters

As alluded to above, setting the following variables controls how ansible interacts with remote hosts.

_**ansible_host**_  
&emsp;&emsp;The name of the host to connect to, if different from the alias you wish to give to it.  
_**ansible_port**_  
&emsp;&emsp;The ssh port number, if not 22  
_**ansible_user**_  
&emsp;&emsp;The default ssh user name to use.  

_**ansible_become**_  
&emsp;&emsp;Equivalent to ansible_sudo or ansible_su, allows to force privilege escalation  

_**ansible_python_interpreter**_  
&emsp;&emsp;The target host python path. This is useful for systems with more than one Python or not located at `/usr/bin/python` such as _*BSD_, or where `/usr/bin/python` is not a 2.X series Python. We do not use the /usr/bin/env mechanism as that requires the remote user’s path to be set right and also assumes the python executable is named python, where the executable might be named something like python2.6.


# Dynamic Inventory

If the _**Ansible**_ inventory fluctuates over time, with hosts spinning up and shutting down in response to business demands, the static inventory solutions described above will not actually serve our needs. Using _dynamic inventories_, we can track hosts from multiple sources: cloud providers, LDAP, Cobbler, and/or enterprise CMDB systems.

## Ansible dynamic inventory plugin for the Hetzner Cloud

### Synopsis
* Reads inventories from the Hetzner Cloud API.
* Uses a YAML configuration file that ends with hcloud.(yml|yaml).

### Requirements
The below requirements are needed on the local controller node that executes this inventory.

* python >= 2.7
* hcloud-python >= 1.0.0

### Installation

This plugin is part of the hetzner.hcloud collection (version 1.6.0). To install it use:
```bash
$ pip3 install hcloud --user
$ ansible-galaxy collection install hetzner.hcloud
```

#### Environment

The inventory file is missing some sensitive parameters, thus in _**Ansible's**_ working directory you need to export _**HCLOUD_TOKEN**_ environment variable.

```bash
$ export HCLOUD_TOKEN=******
```

### Configuration

#### HCloud

`HCLOUD_TOKEN` should be exposed in environment.

```bash
$ cat inventory/hcloud.yml
plugin: hcloud

keyed_groups:
  # Group by a location with prefix e.g. "hcloud_location_nbg1" or "hcloud_location_hel1"
  - key: location
    prefix: hcloud_location
  # and image_os_flavor without prefix and separator e.g. "centos"
  - key: image_os_flavor
    separator: ""
  # and status with prefix e.g. "server_status_running"
  - key: status
    prefix: server_status
```

### Usage

#### HCloud

```bash
$ ansible-inventory -i inventory/hcloud.yml --list|jq '.hcloud_location_nbg1[]'
[
  "samedin.ro",
  "bck.samedin.ro.",
]
```

```bash
$ ansible all -i inventory/hcloud.yml -l samedin.ro -m ping
samedin.ro | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```
