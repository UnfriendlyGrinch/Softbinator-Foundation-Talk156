# Packer

Build Automated Machine Images.

### built-in blocks

The `Packer` - `HCL2` language includes a number of built-in blocks that you can use. A block is a container for configuration.
Blocks can be defined in multiple files and `packer build folder` will build using solely the files from a directory named `folder`.

### builders

Builders are responsible for creating machines and generating images from them for various platforms. For example, there are separate builders for EC2, VMware, Hetzner Cloud, etc.
For example, the `hcloud` Packer builder is able to create new images for use with Hetzner Cloud.
The builder takes a source image, runs any provisioning necessary on the image after launching it, then snapshots it into a reusable image. This reusable image can then be used as the foundation of new servers that are launched within the Hetzner Cloud.

## environment

On the current Packer working directory you need to export several env variables.

For Hetzner Cloud:
```bash
packer $ cd hetzner
```

Always write the log to the directory you're currently running packer from.
```bash
$ export PACKER_LOG=1
$ export PACKER_LOG_PATH="packer.log"
```

Set the Ansible roles path relative to the Ansible's working directory.
```bash
export ANSIBLE_ROLES_PATH=./../ansible/roles
```

Set HCloud token for Hetzner Cloud.
```bash
export HCLOUD_TOKEN=<your token goes here>
```

## usage

The following code snippet will create a new hcloud snapshot named ``softbinator-centos-7-{{ timestamp }}`` by using Ansible as a provisioner.
This reusable image can then be used as the foundation of new servers that are launched within the Hetzner Cloud.

```bash
packer (master) $ packer build hetzner
Softbinator.hcloud.centos-7: output will be in this color.

==> Softbinator.hcloud.centos-7: Creating temporary ssh key for server...
==> Softbinator.hcloud.centos-7: Creating server...
==> Softbinator.hcloud.centos-7: Using ssh communicator to connect: 78.47.216.74
==> Softbinator.hcloud.centos-7: Waiting for SSH to become available...
==> Softbinator.hcloud.centos-7: Connected to SSH!
==> Softbinator.hcloud.centos-7: Provisioning with Ansible...
    Softbinator.hcloud.centos-7: Setting up proxy adapter for Ansible....
==> Softbinator.hcloud.centos-7: Executing Ansible: ansible-playbook -e packer_build_name="centos-7" -e packer_builder_type=hcloud --ssh-extra-args '-o IdentitiesOnly=yes' -e ansible_ssh_private_key_file=/tmp/ansible-key305367748 -i ../ansible/inventory/packer-provisioner-ansible273566035 repos/unfriendlygrinch/Softbinator-Foundation-Talk156/ansible/plays/playbook.yml
    Softbinator.hcloud.centos-7:
    Softbinator.hcloud.centos-7: PLAY [all] *********************************************************************
    ...
    Softbinator.hcloud.centos-7: PLAY RECAP *********************************************************************
    Softbinator.hcloud.centos-7: default                    : ok=68   changed=55   unreachable=0    failed=0    skipped=31   rescued=0    ignored=0
    Softbinator.hcloud.centos-7:
==> Softbinator.hcloud.centos-7: Shutting down server...
==> Softbinator.hcloud.centos-7: Creating snapshot ...
==> Softbinator.hcloud.centos-7: This can take some time
==> Softbinator.hcloud.centos-7: Destroying server...
==> Softbinator.hcloud.centos-7: Deleting temporary ssh key...
==> Softbinator.hcloud.centos-7: Running post-processor:  (type manifest)
Build 'Softbinator.hcloud.centos-7' finished after 3 minutes 34 seconds.

==> Wait completed after 3 minutes 34 seconds

==> Builds finished. The artifacts of successful builds are:
--> Softbinator.hcloud.centos-7: A snapshot was created: 'softbinator-centos-7-20210128095448' (ID: 30760100)
--> Softbinator.hcloud.centos-7: A snapshot was created: 'softbinator-centos-7-20210128095448' (ID: 30760100)
```
