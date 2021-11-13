# ami-amazonlinux

Automated AMI builds driven by Packer

## Foreword

If you would like to use this code, it's probably best to fork it into your own *personal* repo and make modifications there.

## System Setup

Follow the [one-time-setup] instructuions then resume here.

---

## Amazon Linux

At present this is the simplest representation of a Packer build. It satisfies some basic reuqirements:

1. automatically finds the latest ami id for the specified distro
2. leaves a hook to tie in some automation ([Ansible] but there are other [Provisioners])
3. stores the resulting build in your private amis (over-writes any privious amis of the same name)

## Builds

First, initialize Packer configuration

```shell
% packer init .

Installed plugin github.com/hashicorp/amazon v1.0.4...
```


Before running a build toggle the boolean for `skip_create_ami` during testing:

* A build takes 9 minutes 2 seconds: `false`
* A test run takes 1 minute 54 seconds seconds: `true`.

Then just: `packer build aws-amazonlinux.pkr.hcl`

Builds can now be scheduled to run periodically: nightly, monthly, quarterly, whatever.

---

Next, the AMI [Getting Started] tutorial has a few good first steps. The code herein is from this page.

[one-time-setup]:https://github.com/todd-dsm/dev-linux-os/blob/main/docs/one-time-setup.md
[Ansible]:https://www.packer.io/docs/provisioners/ansible/ansible
[Provisioners]:https://www.packer.io/docs/provisioners
[Getting Started]:https://learn.hashicorp.com/tutorials/packer/aws-get-started-build-image?in=packer/aws-get-started
