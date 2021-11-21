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
  boot_wait     = "3s"  # If the boot gets stuck on the UEFI Shell, decrease this wait time
  build_path    = "${path.cwd}/${var.build_dir}"
  cpus          = 2
  disk_size     = 40960
  format        = "ovf"
  guest_os_type = "Windows2019_64"
  iso_checksum  = "3022424f777b66a698047ba1c37812026b9714c5"
  iso_url       = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
  memory        = 2048
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "virtualbox-iso" "boot" {
  format               = "${local.format}"
  boot_command         = ["<enter>"]
  cd_files             = ["${path.cwd}/${path.root}/autounattend.xml"]
  guest_additions_mode = "disable"
  disk_size            = "${local.disk_size}"
  guest_os_type        = "${local.guest_os_type}"
  iso_checksum         = "${local.iso_checksum}"
  iso_url              = "${local.iso_url}"
  boot_wait            = "${local.boot_wait}"
  communicator         = "${var.communicator}"
  headless             = "${var.headless}"
  iso_interface        = "${var.iso_interface}"
  output_directory     = "${local.build_path}/${local.format}"
  output_filename      = "${var.vm_name}"
  shutdown_command     = "${var.shutdown_command}"
  shutdown_timeout     = "${var.shutdown_timeout}"
  vm_name              = "${var.vm_name}"
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
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{ .Name }}", "--memory", "${local.memory}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${local.cpus}"]
  ]
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.virtualbox-iso.boot"]

  post-processor "manifest" {
    output      = "${local.build_path}/${local.format}/manifest.json"
    strip_path  = true
    custom_data = {
      disk_size      = "${local.disk_size}"
      format         = "${local.format}"
      headless       = "${var.headless}"
      hypervisor     = "${var.hypervisor}"
      iso_url        = "${local.iso_url}"
      vm_name        = "${var.vm_name}"
      vm_version     = "${var.vm_version}"
      winrm_username = "${var.winrm_username}"
      winrm_password = "${var.winrm_password}"
    }
  }

}
