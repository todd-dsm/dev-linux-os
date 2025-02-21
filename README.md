# ami-amazonlinux

Automated AMI builds driven by Packer

## Purpose

This is *one* way to customize Kubernetes nodes; it's typically only necessary for extreme edge cases. The ideal state for a Kubernetes worker is to be as dumb (as little configuration) as possible; it's a worker bee after all.

However, when the need arises, this process gives back a lot of time.

If you would like to use this code, it's probably best to fork it into the *project* repo/dev-space and make modifications there.

```shell
        ***** This build is currently FAILING; will solve as time permits: *****
        > ansible-core requires a minimum of Python version 3.8. Current version: 3.7.16
```

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
* ~2 minutes: `true`.

So there could be a longer time penalty for making a small mistake. After the testing phase, set `skip_create_ami` to `false` and run the build again:

```shell
packer build ami-definition.pkr.hcl
```

At present there is only 1 `ami-definition` file: `aws-eks-node.pkr.hcl`

It is Red Hat-based, so the automation you generate can be reused on almost any RH distro.

Once the definitions are stable, the builds can be scheduled to run periodically: nightly, monthly, quarterly, whatever.

---

Next, the AMI [Getting Started] tutorial has a few good first steps. The code herein is from this page.

[one-time-setup]:https://github.com/todd-dsm/dev-linux-os/blob/main/docs/one-time-setup.md
[Ansible]:https://www.packer.io/docs/provisioners/ansible/ansible
[Provisioners]:https://www.packer.io/docs/provisioners
[Getting Started]:https://learn.hashicorp.com/tutorials/packer/aws-get-started-build-image?in=packer/aws-get-started
