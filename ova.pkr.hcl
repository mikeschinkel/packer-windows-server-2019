packer {
  required_plugins {
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> v1.0.3"
    }
#    download = {
#      version = "~> 0.0.1"
#      source = "github.com/mikeschinkel/download"
#    }
  }
}

#data "download-url" "sql_server" {
#  url = "https://download.microsoft.com/download/4/8/6/486005eb-7aa8-4128-aac0-6569782b37b0/SQL2019-SSEI-Eval.exe"
#  description = "Microsoft SQL Server 2019"
#  filename = "ss_install.exe"
#  checksum = "none"
#}
#
#data "download-url" "chocolatey" {
#  url = "https://community.chocolatey.org/install.ps1"
#  description = "Chocolatey Package Manager for Windows"
#}

locals {
  boot_wait = "3s"  # If the boot gets stuck on the UEFI Shell, decrease this wait time
  disk_size = 40960
  iso_checksum = "3022424f777b66a698047ba1c37812026b9714c5"
  iso_url = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
  memsize = 2048
  numvcpus = 2
  vm_name = "WindowServer2019.17763"
  username = "Administrator"
  password = "packer"
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "virtualbox-iso" "virtualbox" {
  format               = "ova"
  output_directory     = "virtualbox"
  output_filename      = "${local.vm_name}"
  boot_command         = ["<enter>"]
  boot_wait            = "${local.boot_wait}"
  communicator         = "winrm"
  disk_size            = "${local.disk_size}"
  guest_additions_mode = "disable"
  guest_os_type        = "Windows2019_64"
  headless             = false
  iso_checksum         = "${local.iso_checksum}"
  iso_interface        = "sata"
  iso_url              = "${local.iso_url}"
  cd_files             = ["./autounattend.xml","./scripts"]
  shutdown_command     = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout     = "30m"
  vboxmanage           = [
    ["modifyvm", "{{ .Name }}", "--memory", "${local.memsize}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${local.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"]
  ]
  vm_name              = "${local.vm_name}"
  winrm_insecure       = true
  winrm_password       = "${local.password}"
  winrm_timeout        = "4h"
  winrm_use_ssl        = true
  winrm_username       = "${local.username}"
}

source "vmware-iso" "vmware_NOT_TESTED" {
  format           = "ova"
  output_directory = "vmware"
  output_filename  = "${local.vm_name}"
  boot_command     = ["<spacebar>"]
  boot_wait        = "${local.boot_wait}"
  communicator     = "winrm"
  disk_size        = "${local.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "windows9Server64Guest"
  headless         = false
  iso_checksum     = "${local.iso_checksum}"
  iso_url          = "${local.iso_url}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  vm_name          = "${local.vm_name}"
  vmx_data         = {
    firmware            = "efi"
    cdrom_type          = "sata"
    memsize             = "${local.memsize}"
    numvcpus            = "${local.numvcpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
  winrm_insecure   = true
  winrm_password   = "${local.password}"
  winrm_timeout    = "4h"
  winrm_use_ssl    = true
  winrm_username   = "${local.username}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = [
    "source.virtualbox-iso.virtualbox",
    "source.vmware-iso.vmware_NOT_TESTED"
  ]

  provisioner "powershell" {
    only         = ["vmware-iso"]
    pause_before = "1m0s"
    scripts      = ["scripts/vmware-tools.ps1"]
  }

  provisioner "powershell" {
    only         = ["virtualbox-iso"]
    pause_before = "1m0s"
    scripts      = ["scripts/virtualbox-guest-additions.ps1"]
  }

  provisioner "powershell" {
    scripts = ["scripts/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["scripts/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["scripts/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    pause_before = "1m0s"
    scripts      = ["scripts/cleanup.ps1"]
  }

  post-processor "manifest" {
    output      = "${source.name}/manifest.json"
    strip_path  = true
    custom_data = {
      hypervisor = "${source.name}"
      iso        = "${local.iso_url}"
      vm_name    = "${local.vm_name}"
    }
  }

}
