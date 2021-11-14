build {
  sources = [
    "source.amazon-ebs.amazonlinux"
  ]
  provisioner "shell" {
    environment_vars = [
      "FOO=HelloWorld",
    ]
    # Run commands as root during the install
    execute_command = "echo 'ec2-user' | sudo -S env {{ .Vars }} {{ .Path }}"
    inline = [
      "echo Updating the $FOO System...",
      "sleep 3",
      "yum update -y",
      "yum install -y tree lsof dnsutils",
    ]
  }
  # Run Ansible job to build accounts
  provisioner "ansible" {
    user          = "ec2-user"
    playbook_file = "automation/admins-add.yaml"
  }
}

# This image is governed by the AMI Builder (EBS backed)
# Everything below this point will rarely change - if ever.
# https://www.packer.io/docs/builders/amazon/ebs
source "amazon-ebs" "amazonlinux" {
  ami_name      = "golden-amazonlinux"
  region        = "us-west-2"
  instance_type = "t2.micro"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2*"
      architecture        = "x86_64"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username          = "ec2-user"
  force_deregister      = true
  force_delete_snapshot = true
  skip_create_ami       = false # toggle this for testing: true=dry-run, false=build
  tags = {
    Name          = "golden-amazonlinux"
    Base_AMI_ID   = "{{ .SourceAMI }}"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    image_type    = "golden"
  }
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}