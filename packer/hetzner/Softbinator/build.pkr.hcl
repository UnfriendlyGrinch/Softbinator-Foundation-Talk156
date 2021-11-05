build {
  name    = "Softbinator"
  sources = ["source.hcloud.centos-7"]

  provisioner "ansible" {
    inventory_directory = "./../../ansible/inventory"
    playbook_file       = "./../../ansible/plays/softbinator.yml"
    extra_arguments     = ["--extra-vars", "upgrade_all_packages=yes"]
    ansible_env_vars    = ["ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_ROLES_PATH=./../../ansible/roles", "ANSIBLE_SSH_ARGS=-o IdentitiesOnly=yes -o PubkeyAcceptedKeyTypes=+rsa-sha2-512"]
  }

  post-processor "manifest" {
    output = "Softbinator/packer-manifest.json"
  }
}
