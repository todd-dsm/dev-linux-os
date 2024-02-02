# ami-amazonlinux

Automated AMI builds driven by Packer

## Purpose

Using Kubernetes means you don't need to worry about nodes. But, sometimes, when dealing with newer/problematic software it becomes helpful for troubleshooting.

Herein are Packer configurations to build Amazon Linux AMIs for diagnostic purposes.

If you would like to use this code, it's probably best to fork it into your own *personal* repo/dev-space and make modifications there.

## System Setup

Follow the [one-time-setup] instructions then resume here.

---

## Amazon Linux

At present this is the simplest representation of a Packer build. It satisfies some basic requirements:

1. automatically finds the latest ami id for the specified distro
2. leaves a hook to tie in some automation ([Ansible] but there are other [Provisioners])
3. stores the resulting build in your private AMIs (over-writes any previous AMIs of the same name)

## Builds

First, initialize Packer configuration

```shell
% packer init .

Installed plugin github.com/hashicorp/amazon v1.0.4...
```

Before running a build, open the target file and toggle the boolean for `skip_create_ami` during testing; this speeds things up.

If you make a mistake a build could take around:
* ~5 minutes: `false`
* ~2 minutes: `true`.

So there could be a longer time penalty for making a small mistake. After the testing phase, set `skip_create_ami` to `false` and run the build again:

```shell
packer build os-definition.pkr.hcl
```

At present there are only 2:

* `aws-amazonlinux.pkr.hcl` (general purposes)
* `aws-eks-node.pkr.hcl` (Kubernetes worker node)

Both are Red Hat-based, so the automation you generate can be reused on almost any RH distro.

Once the definitions are stable, the builds can be scheduled to run periodically: nightly, monthly, quarterly, whatever.

---

Next, the AMI [Getting Started] tutorial has a few good first steps. The code herein is from this page.

[one-time-setup]:https://github.com/todd-dsm/dev-linux-os/blob/main/docs/one-time-setup.md
[Ansible]:https://www.packer.io/docs/provisioners/ansible/ansible
[Provisioners]:https://www.packer.io/docs/provisioners
[Getting Started]:https://learn.hashicorp.com/tutorials/packer/aws-get-started-build-image?in=packer/aws-get-started
