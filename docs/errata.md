# ERRATA

This repo evolves slowly - but gracefully.

## 2020-02-01

Added an Ansible arguments while updating/creating these builds. The ansible command is now:

```hcl
}
  ...
  # Run Ansible job to build accounts
  # REF: https://www.packer.io/docs/provisioners/ansible/ansible
  provisioner "ansible" {
    user          = "ec2-user"
    playbook_file = "automation/admins-add.yaml"
    extra_arguments = [
      "--scp-extra-args",
      "'-O'"
    ]
  }
}
```

The `shell` provisioner worked properly with ssh but the `ansible` one couldn't. After adding these additional [sshd parameters], Ansible was able to exectute properly.

[sshd parameters]:https://github.com/hashicorp/packer/issues/11783#issuecomment-1137052770
