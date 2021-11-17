# Packer for Windows Server Vagrant Box

This repo contains Packer scripts to create a UEFI 2019 Windows Server OVA and then to convert to a Vagrant Box file.

## How to Use
1. [Install Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli)
2. Run `./build.sh`
3. Run `./box.sh`
4. Find Vagrant box in `/.vagrant`

## How To
- See available drives from Windows CLI?
  ```
  wmic logicaldisk get caption
  ```


## Directly and Indirectly-related Links
These are links that are useful for this repo's use-case, which are at the intersection of Packer, Windows, Vagrant and VirtualBox.
### Vagrant
- Docs
  - [Vagrant Boxes](https://www.vagrantup.com/docs/boxes)
  - [Vagrant Box Metadata](https://www.vagrantup.com/docs/boxes/format#box-metadata)
  - [Vagrant Repositories on jFrog Artifactory](https://www.jfrog.com/confluence/display/JFROG/Vagrant+Repositories)
  - [Vagrant Post-Processor for Packer](https://www.packer.io/docs/post-processors/vagrant/vagrant)
- Articles
  - [Self Hosted Vagrant Cloud](https://codingpackets.com/blog/self-hosted-vagrant-cloud/)
  - [How to set up a self-hosted "vagrant cloud" with versioned, self-packaged vagrant boxes](https://github.com/hollodotme/Helpers/blob/master/Tutorials/vagrant/self-hosted-vagrant-boxes-with-versioning.md).
- Repos
  - [CentOS, Ubuntu and Solaris Vagrant w/Puppet RPM's](https://github.com/biemond/packer-vagrant-builder)
  - [macOS Vagrant](https://github.com/rgl/macos-vagrant)
  - [Packer Vagrant](https://github.com/themalkolm/packer-builder-vagrant)
  - [Gogs Vagrant](https://github.com/rgl/gogs-vagrant)
  - [Logstash Playground](https://github.com/rgl/logstash-windows-vagrant)
  - [Baseline](https://github.com/bltavares/vagrant-baseline)
  - Windows
    - [Sql Server Express Vagrant](https://github.com/rgl/sql-server-vagrant)
    - [PowerShell/Win32-OpenSSH](https://github.com/rgl/openssh-server-windows-vagrant)
    - [Vagrant setup for .NET command line tools](https://github.com/brettporter/vagrant-windows-npanday)
    - [Customize Windows Vagrant](https://github.com/rgl/customize-windows-vagrant)
    - [Deployment Services](https://github.com/rgl/windows-deployment-services-vagrant)
    - [Router](https://github.com/rgl/windows-router-vagrant)
    - [Router via Ansible](https://github.com/rgl/windows-router-ansible-vagrant)
    - [With Nomad](https://github.com/rgl/nomad-windows-vagrant)
    - [With Sysprep](https://github.com/rgl/vagrant-windows-sysprep)
    - [Server 2019](https://github.com/rgl/docker-windows-2019-vagrant)
    - [Domain Controller](https://github.com/rgl/windows-domain-controller-vagrant)
    - [Base Boxes](https://github.com/rgl/windows-vagrant)
- Plugins
  - [List of Plugins](https://vagrant-lists.github.io/)
    - [Execute](https://github.com/rgl/vagrant-execute)
    - [Exec](https://github.com/p0deje/vagrant-exec)
    - [Parallels](https://github.com/Parallels/vagrant-parallels)
    - [Managed Servers](https://github.com/tknerr/vagrant-managed-servers)
    - [List](https://github.com/joshmcarthur/vagrant-list)
    - [Host Path](https://github.com/MOZGIII/vagrant-host-path)
    - [Copy My Conf](https://github.com/akshaymankar/copy_my_conf)
    - Domain Names: Hosts/DNS
      - [Hosts](https://github.com/oscar-stack/vagrant-hosts)
      - [Hosts Manager](https://github.com/devopsgroup-io/vagrant-hostmanager)
      - [Hosts Updater (unmaintained)](https://github.com/agiledivider/vagrant-hostsupdater)
      - [DNS (BerlinVagrant)](https://github.com/BerlinVagrant/vagrant-dns)
      - [dns (he9lin)](https://github.com/he9lin/vagrant-dns)
      - [DNSMasq (archived)](https://github.com/mattes/vagrant-dnsmasq)
      - [landrush](https://github.com/vagrant-landrush/landrush)

### EFI
- [Intel EFI Docs](https://www.intel.com/content/dam/support/us/en/documents/motherboards/server/sb/efi_instructions.pdf)
- [VirtualBox: Guest suddenly boots only into UEFI Interactive Shell](https://unix.stackexchange.com/questions/326956/virtualbox-guest-suddenly-boots-only-into-uefi-interactive-shell)
- [How to get out of EFI shell in virtual box](https://superuser.com/questions/1145681/how-to-get-out-of-efi-shell-in-virtual-box)
- [UEFI/GPT-based hard drive partitions](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions?view=windows-11)
- [UEFI: Building a Better BIOS](https://www.onlogic.com/company/io-hub/uefi-building-better-bios/)
- 
### Windows
- [Unattended Windows Setup Reference](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/)
- [Windows System Image Manager Technical Reference](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference)
  - [Open a Windows Image or Catalog File](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/open-a-windows-image-or-catalog-file)
  - [What is the difference between boot.wim and install.wim?](https://www.mvorganizing.org/what-is-the-difference-between-boot-wim-and-install-wim/)
  - [How To Create A Windows Server 2019 Installation Answer File](https://techsnips.io/snips/how-to-create-a-windows-server-2019-installation-answer-file-using-windows-systems-image-manager/)
- [How to create an unattended installation of Windows 10](https://www.windowscentral.com/how-create-unattended-media-do-automated-installation-windows-10)
- 
- [Create a new WinPE boot image](https://sysmansquad.com/2021/02/22/create-a-new-winpe-boot-image/)
- [Key Management Services (KMS) client activation and product keys](https://docs.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys)
- [Windows PowerShell Desired State Configuration (DSC) Overview](https://docs.microsoft.com/en-us/powershell/scripting/dsc/overview/overview)
- [Packer and Vagrant provisioning for Windows 2019 libvirt VM](https://github.com/deargle/lab-windows-2019-vuln)
- [Debugging a Packer build](http://pinter.org/archives/6871)
- [Enable Remote Desktop Protocol (RDP) on Windows Server 2019](https://computingforgeeks.com/how-to-enable-remote-desktop-protocol-rdp-on-windows-server-2019/)
- [How do I set the SMB username and password?](https://stackoverflow.com/a/44395248/102699)
### GoLang
- [go-artifactory](https://github.com/lusis/go-artifactory)
- [ovaify](https://github.com/stephen-fox/ovaify)
- [vmwareify](https://github.com/stephen-fox/vmwareify)
- [Packer script/provision Docker+Golang calc w/Jenkinsfile](https://github.com/joaodartora/golang-calculator-microservice)

### Jenkins
- [Example Jenkins Packer Job](https://github.com/RoundTower-io/simple-jenkins-packer-builder)
- [Packer script/provision Docker+Golang calc w/Jenkinsfile](https://github.com/joaodartora/golang-calculator-microservice)
- [source-packager-plugin](https://github.com/janinko/source-packager-plugin)
- [packer-workflow-plugin](https://github.com/ebeniezer/packer-workflow-plugin)
- [Setup Jenkins with Packer](https://github.com/ctaperts/packer-io-jenkins)
- 
### Testing
- [ServerSpec](https://serverspec.org/)
- [GOSS](https://github.com/aelsabbahy/goss)
  - [Container validation with Githib Actions](https://github.com/xr09/goss-test-example)
  - [Easy Infrastructure Testing with Goss](https://www.pysysops.com/2017/01/10/Easy-Infrastructure-Testing-with-Goss.html)
  - [Testing Docker Images with CircleCI and Goss](https://circleci.com/blog/testing-docker-images-with-circleci-and-goss/)
  - [How to unit test.. a server with goss](https://codeblog.dotsandbrackets.com/unit-test-server-goss/)

### Packer
- [Awesome Packer (not so awesome)](https://github.com/dawitnida/awesome-packer)  
- Getting Started
  - [Terminology](https://www.packer.io/docs/terminology)
  - [Installing](https://www.packer.io/docs/install)
  - [Configuring](https://www.packer.io/docs/configure)
  - [CLI Commands](https://www.packer.io/docs/commands)
  - [Debugging](https://www.packer.io/docs/debugging)
  - [Build a Windows Image (Amazon AMI)](https://learn.hashicorp.com/tutorials/packer/aws-windows-image?in=packer/integrations)
- [Templates](https://www.packer.io/docs/templates)
  - [HCL](https://www.packer.io/docs/templates/hcl_templates)
    - [HCL Native Syntax Specification](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md)
    - [The `build` block](https://www.packer.io/docs/templates/hcl_templates/blocks/build)
  - [JSON](https://www.packer.io/docs/templates)
- [Communicators](https://www.packer.io/docs/communicators)
    - [WinRM](https://www.packer.io/docs/communicators/winrm)
    - [SSH](https://www.packer.io/docs/communicators/ssh)
- [Builders](https://www.packer.io/docs/builders)
    - [VirtualBox](https://www.packer.io/docs/builders/virtualbox)
    - [VMware](https://www.packer.io/docs/builders/vmware)
- [Data Sources](https://www.packer.io/docs/datasources)
  - [SSH key](https://www.packer.io/docs/datasources/sshkey)
- [Provisioners](https://www.packer.io/docs/provisioners)
    - [File](https://www.packer.io/docs/provisioners/file)
    - [PowerShell](https://www.packer.io/docs/provisioners/powershell)
    - [Shell](https://www.packer.io/docs/provisioners/shell)
    - [Shell Local](https://www.packer.io/docs/provisioners/shell-local)
    - [Windows Restart](https://www.packer.io/docs/provisioners/windows-restart)
    - [Windows Shell](https://www.packer.io/docs/provisioners/windows-shell)
    - [Community](https://www.packer.io/docs/provisioners/community-supported)
        - [Windows Update](https://github.com/nstreet/packer-provisioner-windows-update)
        - [Comment](https://github.com/SwampDragons/packer-provisioner-comment)
        - [PowerShell Desired State Configuration (DSC)](https://github.com/mefellows/packer-dsc)
        - [ServerSpec](https://github.com/vamegh/packer-provisioner-serverspec)
        - [Lumberjack](https://github.com/curiositycasualty/packer-provisioner-lumberjack)
        - [Goss (Yale University)](https://github.com/YaleUniversity/packer-provisioner-goss)
        - [Goss (Ahmed Elsabbahy)](https://github.com/aelsabbahy/goss)
        - [Goss (Simon Bäumer/RedHat)](https://github.com/SimonBaeumer/goss)
        - [S3](https://github.com/enmand/packer-provisioner-s3)
    - [Custom](https://www.packer.io/docs/plugins/creation/custom-provisioners)
- [Post-Processors](https://www.packer.io/docs/post-processors)
    - [Artifice](https://www.packer.io/docs/post-processors/artifice)
    - [CheckSum](https://www.packer.io/docs/post-processors/checksum)
    - [Compress](https://www.packer.io/docs/post-processors/compress)
    - [Manifest](https://www.packer.io/docs/post-processors/manifest)
    - [Shell Local](https://www.packer.io/docs/post-processors/shell-local)
    - [Vagrant](https://www.packer.io/docs/post-processors/vagrant/vagrant)
      - [Tutorial](https://learn.hashicorp.com/tutorials/packer/aws-get-started-post-processors-vagrant?in=packer/integrations)
    - [vSphere](https://www.packer.io/docs/post-processors/vsphere/vsphere)
    - [vSphere Template](https://www.packer.io/docs/post-processors/vsphere/vsphere-template)
    - Docker
        - [Import](https://www.packer.io/docs/post-processors/docker/docker-import)
        - [Push](https://www.packer.io/docs/post-processors/docker/docker-push)
        - [Save](https://www.packer.io/docs/post-processors/docker/docker-save)
        - [Tag](https://www.packer.io/docs/post-processors/docker/docker-tag)
    - [Community](https://www.packer.io/docs/post-processors/community-supported)
      - [Artifactory](https://github.com/pyToshka/packer-post-processor-artifactory)
      - [Template](https://github.com/saymedia/packer-post-processor-template)
      - [OVAexport](https://github.com/daxgames/packer-post-processor-ovaexport)
      - [Tool OFV](https://github.com/Bazzaware/packer-post-processor-tool-ovf)
      - [Tarball](https://github.com/DavidWittman/packer-post-processor-tarball)
      - [vSphere Template](https://github.com/charandas/packer-post-processor-vsphere-template)
      - [VHD](https://github.com/benwebber/packer-post-processor-vhd)
      - [Slack Notifications](https://github.com/Horgix/packer-post-processor-slack-notifications)
      - [ovftool](https://github.com/iancmcc/packer-post-processor-ovftool)
      - [JSON updater](https://github.com/cliffano/packer-post-processor-json-updater)
      - [S3](https://github.com/shaunduncan/packer-post-processor-s3)
      - [OVA Forge](https://github.com/stephen-fox/packer-ova-forge)
      - Vagrant
        - [S3](https://github.com/lmars/packer-post-processor-vagrant-s3)
        - [Path](https://github.com/praveenraonp/packer-post-processor-vagrant-path)
        - [Metadata](https://github.com/YOwatari/packer-post-processor-vagrant-metadata)
        - [Netty (S3)](https://github.com/zongze1026/netty)
- [Plugins](https://www.packer.io/docs/plugins)
  - [Creating](https://www.packer.io/docs/plugins/creation)
    - [Builders](https://www.packer.io/docs/plugins/creation/custom-builders)
    - [Post-Processors](https://www.packer.io/docs/plugins/creation/custom-post-processors)
    - [Provisioners](https://www.packer.io/docs/plugins/creation/custom-provisioners)
    - [Data Sources](https://www.packer.io/docs/plugins/creation/custom-datasources)
  - [Integration Program](https://www.packer.io/docs/plugins/packer-integration-program)
  - Community
    - [Robox](https://github.com/lavabit/robox)
    - [Github Actions](https://github.com/dawitnida/packer-github-actions)
    - [Chocolatey](https://github.com/packer-community/packer-community-chocolatey)
      - [Chocolatey.org](https://chocolatey.org/)
    - [Podman](https://github.com/Polpetta/packer-plugin-podman)
    - [Windows Update](https://github.com/rgl/packer-plugin-windows-update)
  - How-To Examples
    - [FileDownload](https://github.com/dkoudela/packer-provisioner-filedownload)
    - [WinRS-Shell](https://github.com/mefellows/packer-winrm-shell)
    - [Tunnel](https://github.com/josharian/packer-provisioner-tunnel)
    - [Command](https://github.com/mizzy/packer-provisioner-command)
    - [Host Command](https://github.com/shaunduncan/packer-provisioner-host-command)
    - [Windows Update](https://github.com/nstreet/packer-provisioner-windows-update)
    - [SSHProxy](https://github.com/gshively/packer-provisioner-sshproxy)
    - [Mount](https://github.com/gildas/packer-provisioner-mount) 
    - [FakeSSH](https://github.com/leocp1/packer-provisioner-fakessh)
    - [Parallels](https://github.com/YungSang/packer-parallels)
    - [Docker SSH](https://github.com/tonnydourado/packer-builder-docker-ssh)
    - [VirtualBox](https://github.com/dregin/packer-post-processor-virtualbox)
    - [vSphere VM Tools](https://github.com/cacoyle/packer-vsphere-vm-tools)
    - [vSphere Cleanup](https://github.com/jetbrains-infra/packer-post-processor-vsphere-cleanup)
    - [Shell](https://github.com/stephenranjit/packer-post-processor-shell)
    - [vmware-ova](https://github.com/spiegela/packer-builder-vmware-ova)
    - [s3file](https://github.com/acornies/packer-provisioner-s3file)
    - [Wait](https://github.com/gildas/packer-provisioner-wait/blob/master/provisioner.go)
    - [SSHKey](https://github.com/ivoronin/packer-plugin-sshkey)
    - [Deno](https://github.com/dontlaugh/packer-provisioner-deno)
    - [Caryatid](https://github.com/mrled/caryatid)
    - [Vagrant Cloud Standalone](https://github.com/armab/packer-post-processor-vagrant-cloud-standalone)
    - 
#### Packer Articles
- [HCL Windows 10 Pro using VMware vSphere ISO Builder](https://www.danielmartins.online/post/hashicorp-packer-build-hcl-windows-10-pro-using-vmware-vsphere-iso-builder)
- [With EFI Firmware for Windows in VMware vCenter](https://www.danielmartins.online/post/packer-build-using-efi-firmware-for-vmware-vsphere)
- [Unattended Windows 10 Evaluation for QEMU/KVM](https://github.com/meeuw/unattended-windows-10)
- [How to create a VirtualBox VM from command line](https://www.andreafortuna.org/2019/10/24/how-to-create-a-virtualbox-vm-from-command-line/)
- [carmark/vboxmanage_examples](https://gist.github.com/carmark/547004053a266b20fb24)
- 
####  How-To Examples
- [Packer with Windows-Update Plugin in Docker](https://github.com/jak119/packer-windows-update)
- [Windows HomeBrew](https://github.com/packer-community/packer-windows-plugins-brew)
- [Multiple Disks Virtual Box](https://github.com/hashicorp/packer/issues/1147)
