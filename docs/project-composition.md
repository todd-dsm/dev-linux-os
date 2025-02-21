# Variables and Project Composition

These file names are specific. They are described (poorly) by the official Packer [Variables Documentation]:

```shell
% ls -al *.hcl
-rw-r--r-- 1 user staff 2154 Feb 20 17:25 amazonlinux.pkr.hcl
-rw-r--r-- 1 user staff  411 Feb 20 15:24 plugins.pkr.hcl
-rw-r--r-- 1 user staff  247 Feb 21 10:02 variables.auto.pkrvars.hcl
-rw-r--r-- 1 user staff  604 Feb 20 16:32 variables.pkr.hcl
```

> ***This is the recommended naming convention for Packer project files.***

## The Naming Breakdown

### `plugins.pkr.hcl`

This is akin to the Terraform `providers.tf` file. Treat it similarly.

### `variables.pkr.hcl`

This file holds variable defitions but makes no assignments.

```hcl
% head variables.pkr.hcl
variable "image_name" {
  description = "The final AMI name."
  type        = string
}
```

### `variables.auto.pkrvars.hcl`

This file holds variable assignments relative to the above definitions.

```hcl
% cat variables.auto.pkrvars.hcl
image_name = "golden-amazonlinux"
```

The [auto designation] auto-loads variables as a convenience.

> NOTE: The 2 variable files are named very specifically. If the file extensions are changed, Packer will not recognize them and builds will break.

### `amazonlinux.pkr.hcl`

The first part of this file is simply named for the distro being configured.

[Variables Documentation]:https://developer.hashicorp.com/packer/docs/templates/hcl_templates/variables
[auto designation]:https://developer.hashicorp.com/packer/docs/templates/hcl_templates/variables#assigning-values-to-input-variables
