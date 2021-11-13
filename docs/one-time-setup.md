# One-time Setup for HashiCorp Packer

These instructions are specific to POSIX-compliant workstations; E.G.: Linux and macOS; you'll have to do your own research for Windows equivalents.

1. Go to the HashiCorp [Install Packer] page. Simply select the OS in question and follow the instructions.

2. Find a suiteable location to store your VMs

I keep mine here:

`mkdir -p ~/vms/packer/{builds,iso-cache,vms}`

Put yours wherever you like. When done, the directory structure looks like:

```shell
% tree -d -L 2 ~/vms
/Users/userName/vms
├── isos
│   └── osx_mojave
├── packer             <- The Packer directory; ignore everything else
│   ├── builds
│   ├── iso-cache
│   └── vms
├── vagrant
│   ├── boxes
│   ├── data
│   ├── gems
│   ├── rgloader
│   └── tmp
├── vbox
│   ├── base_ami_default_1497816473838_44645
│   ├── client_linux
│   ├── server_tests
│   ├── ubuntu16_default_1539557565589_10272
│   └── vagrantests
└── vmware
    ├── big_sur
    └── catalina
```

3. Inform your system where to find these locations

Drop this into your `~/.bashrc` and source it in
```shell
###############################################################################
###                                  Packer                                 ###
###############################################################################
# complete -C /usr/bin/packer packer                        # Bash
# complete -o nospace -C /usr/local/bin/packer packer       # ZSH
export PACKER_HOME="$HOME/vms/packer"
#export PACKER_CONFIG="$PACKER_HOME/some-config-file"
export PACKER_CACHE_DIR="$PACKER_HOME/iso-cache"
export PACKER_BUILD_DIR="$PACKER_HOME/builds"
export PACKER_LOG='yes'
export PACKER_LOG_PATH='/tmp/packer.log'
export PACKER_NO_COLOR='yes'
```

*NOTE1*: the `PACKER_CONFIG` variable should remain commented; it's only there in the unlikely event that you might need it someday.

*NOTE2*: I use the latest [zshell] with [Oh My Zsh]; in this case the above configuration will go in the file:

`~/.oh-my-zsh/custom/environment.zsh`

*NOTE3* For the completions lines, uncomment the one for your preferred shell and delete the one you don't need.

4. [Configure your AWS Credentials] if you haven't already.

---

Packer is ready to use; continue from the main [README].

[Install Packer]:https://learn.hashicorp.com/tutorials/packer/get-started-install-cli
[zshell]:https://zsh.sourceforge.io/
[Oh My Zsh]:https://ohmyz.sh/
[README]:https://github.com/todd-dsm/dev-linux-os/blob/main/README.md
[Configure your AWS Credentials]:https://github.com/todd-dsm/mac-ops/wiki/Install-awscli