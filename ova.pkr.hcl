packer {
  required_plugins {
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> v1.0.3"
    }
  }
}

variable "boot_wait" {
  type    = string
  # If the boot gets stuck on the UEFI Shell, decrease this wait time
  default = "3s"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "3022424f777b66a698047ba1c37812026b9714c5"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "vm_name" {
  type    = string
  default = "WindowServer2019.17763"
}

variable "username" {
  type    = string
  default = "Administrator"
}

variable "password" {
  type    = string
  default = "packer"
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "virtualbox-iso" "virtualbox" {
  format               = "ova"
  output_directory     = "virtualbox"
  output_filename      = "${var.vm_name}"
  boot_command         = ["<enter>"]
  boot_wait            = "${var.boot_wait}"
  communicator         = "winrm"
  disk_size            = "${var.disk_size}"
  guest_additions_mode = "disable"
  guest_os_type        = "Windows2019_64"
  headless             = false
  iso_checksum         = "${var.iso_checksum}"
  iso_interface        = "sata"
  iso_url              = "${var.iso_url}"
  cd_files             = ["./autounattend.xml"]
  shutdown_command     = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout     = "30m"
  vboxmanage           = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"]
#    ,[
#      "storageattach", "{{ .Name }}", "--storagectl", "SATA Controller", "--type", "dvddrive", "--port", "4",
#      "--medium", "./autounattend/autounattend.iso"
#    ]
  ]
  vm_name              = "${var.vm_name}"
  winrm_insecure       = true
  winrm_password       = "${var.password}"
  winrm_timeout        = "4h"
  winrm_use_ssl        = true
  winrm_username       = "${var.username}"
}

source "vmware-iso" "vmware" {
  format           = "ova"
  output_directory = "vmware"
  output_filename  = "${var.vm_name}"
  boot_command     = ["<spacebar>"]
  boot_wait        = "${var.boot_wait}"
  communicator     = "winrm"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "windows9Server64Guest"
  headless         = false
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  vm_name          = "${var.vm_name}"
  vmx_data         = {
    firmware            = "efi"
    cdrom_type          = "sata"
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
  winrm_insecure   = true
  winrm_password   = "${var.password}"
  winrm_timeout    = "4h"
  winrm_use_ssl    = true
  winrm_username   = "${var.username}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = [
    "source.virtualbox-iso.virtualbox",
    "source.vmware-iso.vmware"
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
      iso        = "${var.iso_url}"
      vm_name    = "${var.vm_name}"
    }
  }

}
