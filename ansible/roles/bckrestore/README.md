# Overview

This Ansible Role [restores](https://restic.readthedocs.io/en/latest/050_restore.html#restoring-from-a-snapshot) the contents of a given snapshot to a target directory on the managed node.

This documentation intends to provide a compendious overview to determine how restoring a backup works.

# How It Works

The `bckrestore` Role will restore an existing snapshot either locally (the `control node` in Ansible terms) or on any other server which is managed with Ansible (`managed nodes`).
A managed node could be the server whose snapshot we aim to restore, a designated backup (storage) server or a new server which is not part of the current setup. The later is particularly helpful in case of Migration or Disaster Recovery Operations, when we need to bring a node back to a certain state (as saved using `restic`).

# Prerequisites

- Python 3.8 and newer.
- Latest Ansible version. It is recommended to either install or upgrade Ansible using [`pip`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip)

## modules

Install modules required to manage Hashicorp Vault:
```bash
$ pip install ansible-modules-hashivault hvac requests
```

## Environment

Prior to using this Role, we need to export a few environment variables related to HashiCorp Vault.

Address of the Vault server expressed as a URL and port.
```bash
export VAULT_ADDR=http://127.0.0.1:8200
```

Token used for authentication within Vault.
```bash
export VAULT_TOKEN=*.************************
```

# Using the `bckrestore` Ansible Role

## Restore a backup (snapshot) locally

Certain tasks require `sudo` privileges, and this is why one needs to provide the `sudo` password as well.

```bash
$ ansible-playbook -i ./inventory/hcloud.yml -l "samedin.ro" plays/bckrestore.yml -K
BECOME password:

PLAY [all] ***********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************************************
ok: [samedin.ro]

TASK [Gather facts about localhost] **********************************************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Create "/tmp/samedin.ro" directory, if it does not exist] *****************************************************************************************************************************************************************
changed: [samedin.ro -> localhost]

TASK [bckrestore : Install restic (if this is missing) on localhost] *************************************************************************************************************************************************************************
included: /home/elif/Documents/Softbinator-Foundation-Talk156/ansible/roles/bckrestore/tasks/install_to_localhost.yml for samedin.ro

TASK [bckrestore : Install dnf plugin to add copr command] ***********************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Install restic on CentOS 8/RHEL 8/Rocky 8/Fedora] *************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Set new variables] ********************************************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost] => (item=/home/elif/Documents/Softbinator-Foundation-Talk156/ansible/roles/bckrestore/files/../files/id_ecdsa)

TASK [bckrestore : Gather facts about the backup server] *************************************************************************************************************************************************************************************
ok: [samedin.ro -> 116.203.51.87]

TASK [bckrestore : Set new variables] ********************************************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Get password from HashiCorp Vault] ****************************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Set snapshot ID] **********************************************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Set the absolute path to be restored] *************************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Get the required space to restore the snapshot] ***************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Get the available space on target directory] ******************************************************************************************************************************************************************************
ok: [samedin.ro -> localhost]

TASK [bckrestore : Restore from a snapshot] **************************************************************************************************************************************************************************************************
changed: [samedin.ro -> localhost]

PLAY RECAP ***********************************************************************************************************************************************************************************************************************************
samedin.ro                 : ok=15   changed=2    unreachable=0    failed=0    skipped=19   rescued=0    ignored=0   
```

```bash
$ ll /tmp/samedin.ro/var/www/html/
total 692
-rw-r--r--. 1 root root 701040 Nov  6 15:30 156.jpg
-rw-r--r--. 1 root root    153 Nov  6 15:30 index.html
```

# License

**BSD**

# Author Information

- [Elif Samedin](elif.samedin@eaudeweb.ro)
- [Andrei Buzoianu](andrei@buzoianu.info)
