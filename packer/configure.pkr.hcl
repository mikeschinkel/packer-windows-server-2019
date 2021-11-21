variables {
  compression_level = 0

  headless       = false
  winrm_insecure = false
  winrm_use_ntlm = false
  winrm_use_ssl  = false

  build_dir        = ""
  scripts_dir      = ""
  communicator     = ""
  hypervisor       = ""
  iso_interface    = ""
  provider         = ""
  shutdown_command = ""
  shutdown_timeout = ""
  vm_name          = ""
  vm_version       = ""
  winrm_password   = ""
  winrm_timeout    = ""
  winrm_username   = ""

}

locals {
  build_path   = "${path.cwd}/${var.build_dir}"
  scripts_path = "${path.cwd}/${var.scripts_dir}"
  format       = "ova"
  boot_wait    = "3s"
  cpus         = 2
  input_format = "ovf"
  memory       = 2048
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "virtualbox-ovf" "configured" {
  format               = "${local.format}"
  guest_additions_mode = "attach"
  checksum             = "none"
  boot_command         = ["<enter>"]
  cd_files             = ["${var.scripts_dir}"]
  boot_wait            = "${local.boot_wait}"
  communicator         = "${var.communicator}"
  headless             = "${var.headless}"
  output_directory     = "${local.build_path}/${local.format}"
  output_filename      = "${var.vm_name}"
  shutdown_command     = "${var.shutdown_command}"
  shutdown_timeout     = "${var.shutdown_timeout}"
  source_path          = "${local.build_path}/${local.input_format}/${var.vm_name}.${local.input_format}"
  winrm_insecure       = "${var.winrm_insecure}"
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "${var.winrm_timeout}"
  winrm_use_ntlm       = "${var.winrm_use_ntlm}"
  winrm_use_ssl        = "${var.winrm_use_ssl}"
  winrm_username       = "${var.winrm_username}"
  export_opts          = [
    "--manifest",
    "--vsys", "0",
    "--description", "${var.vm_name}",
    "--version", "${var.vm_version}"
  ]
  vboxmanage           = [
    ["modifyvm", "{{ .Name }}", "--memory", "${local.memory}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${local.cpus}"],
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{ .Name }}", "--audio", "none"],
    ["modifyvm", "{{ .Name }}", "--clipboard", "bidirectional"],
    ["modifyvm", "{{ .Name }}", "--draganddrop", "bidirectional"]
  ]

}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.virtualbox-ovf.configured"]

  provisioner "powershell" {
    inline = ["Write-Host \"Hello WinRM, PowerShell to the rescue!\""]
  }

  provisioner "powershell" {
    script = "scripts/software.ps1"
  }

  provisioner "powershell" {
    only         = ["virtualbox-iso"]
    pause_before = "1m0s"
    script       = "scripts/virtualbox-guest-additions.ps1"
  }

  provisioner "powershell" {
    script = "scripts/setup.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    script = "scripts/win-update.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    script = "scripts/win-update.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    script = "scripts/software.ps1"
  }

  provisioner "powershell" {
    pause_before = "1m0s"
    script       = "scripts/cleanup.ps1"
  }

  post-processor "manifest" {
    output      = "${local.build_path}/${local.format}/manifest.json"
    strip_path  = true
    custom_data = {
      format         = "${local.format}"
      memory         = "${local.memory}"
      cpus           = "${local.cpus}"
      hypervisor     = "${var.hypervisor}"
      vm_name        = "${var.vm_name}"
      vm_version     = "${var.vm_version}"
      winrm_username = "${var.winrm_username}"
      winrm_password = "${var.winrm_password}"
    }
  }

}
