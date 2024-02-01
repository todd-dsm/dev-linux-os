# Required Plugins
# REF: https://www.packer.io/docs/plugins
# https://github.com/hashicorp/packer-plugin-amazon/releases
# https://github.com/hashicorp/packer-plugin-ansible/releases
packer {
  required_plugins {
    amazon = {
      version = "~> 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = "~> 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }

  }
}