# build > sources L2-3: refers to the 'source "amazon-ebs"' block below
build {
  sources = [
    "source.amazon-ebs.amazonlinux"
  ]
  # Run shell script to install some packages
  # REF: https://www.packer.io/docs/provisioners/shell
  provisioner "shell" {
    environment_vars = [
      "FOO=HelloWorld",
    ]
    # Run commands as root during the install
    execute_command = "echo var.default_ami_user | sudo -S env {{ .Vars }} {{ .Path }}"
    inline = [
      "echo Updating the $HOSTNAME System...",
      "sleep 3",
      "yum update -y",
      "yum install -y tree lsof dnsutils",
    ]
  }
  # Run Ansible job to build accounts
  # REF: https://www.packer.io/docs/provisioners/ansible/ansible
  provisioner "ansible" {
    user          = var.default_ami_user
    playbook_file = "automation/admins-add.yaml"
    extra_arguments = [
      "--scp-extra-args",
      "'-O'"
    ]
  }
}

# This image is governed by the AMI Builder (EBS backed)
# Everything below this point will rarely change - if ever.
# https://www.packer.io/docs/builders/amazon/ebs
source "amazon-ebs" "amazonlinux" {
  ami_name              = var.image_name
  region                = var.aws_region
  instance_type         = var.instance_type
  ssh_username          = var.default_ami_user
  force_deregister      = true
  force_delete_snapshot = true
  skip_create_ami       = var.skip_create_ami # defaults to true

  # Using a filter to find the latest image-id instead of a Data Source
  # REF: https://www.packer.io/docs/builders/amazon/ebs#source_ami_filter
  # REF: https://www.packer.io/docs/datasources/amazon/ami
  source_ami_filter {
    filters = {
      name                = "al2023-ami*"
      architecture        = "x86_64"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    most_recent = true
    owners      = ["amazon"]
  }

  # Uses the Template Engine to tag the image
  # REF: https://www.packer.io/docs/templates/legacy_json_templates/engine#template-engine
  tags = {
    Name          = var.image_name
    Base_AMI_ID   = "{{ .SourceAMI }}"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    image_type    = "golden"
  }
}
