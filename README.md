# ami-amazonlinux

Automated AMI builds driven by Packer

## Purpose

Using Kubernetes means you don't need to worry about nodes. But not all software is Kubernetes-ready. Occasionally, deploying to Linux is still the answer.

Herein are Packer configurations to support automated Amazon Linux AMI builds.

If you would like to use this code, it's probably best to fork it into the *project* repo/dev-space and make modifications there.

## System Setup

Follow the [one-time-setup] instructions then resume here.

---

## Amazon Linux

At present this is the simplest representation of a Packer build. It satisfies some basic requirements:

1. Automatically finds the latest ami id for the specified distro
2. Leaves a hook to tie in some automation ([Ansible] but there are other [Provisioners]), then
3. Stores the resulting build in your private AMIs (over-writes any previous AMIs of the same name)

## Builds

First, initialize Packer configuration

```shell
% packer init .

Installed plugin github.com/hashicorp/amazon v1.0.4...
```

Before running a build, open the `variables.auto.pkrvars.hcl` file and toggle the boolean for `skip_create_ami` during testing; this speeds things up.

If you make a mistake a build could take around:

* ~6 minutes: `false`
* ~3 minutes: `true`.

So there could be a longer time penalty for making a small mistake. After the testing phase, set `skip_create_ami` to `false` and run the build again:


## Variables

It's very important to understand that the variable file names are specific - do NOT change the names of the files.

Also, as the `variables.auto.pkrvars.hcl` name implies, these variables don't need to be called out during the build. They are automatically loaded by Packer. So, the build is kicked off by:

```shell
packer build ami-definition.pkr.hcl
```

At present, there are only 2 `ami-definition` files:

* `aws-amazonlinux.pkr.hcl` (general purposes)
* `aws-eks-node.pkr.hcl` (Kubernetes worker node; in its own branch)

Both are Red Hat-based, so the automation generated in Ansible has a strong chance of being reusable on any RH-based Linux distro.

Once the definitions are stable, the builds can be scheduled to run periodically: nightly, monthly, quarterly, whatever.

---

Next, the AMI [Getting Started] tutorial has a few good first steps. The code herein is from this page.

[one-time-setup]:https://github.com/todd-dsm/dev-linux-os/blob/main/docs/one-time-setup.md
[Ansible]:https://www.packer.io/docs/provisioners/ansible/ansible
[Provisioners]:https://www.packer.io/docs/provisioners
[Getting Started]:https://learn.hashicorp.com/tutorials/packer/aws-get-started-build-image?in=packer/aws-get-started
