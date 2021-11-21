packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> v1.0.0"
    }
  }
}

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
  format       = "box"
  input_format = "ova"
  provider     = "virtualbox"
}

source "null" "builder" {
  communicator = "none"
}

build {
  sources = [
    "source.null.builder"
  ]
  post-processors {
    post-processor "artifice" {
      files = [
        "${local.build_path}/${local.input_format}/${var.vm_name}.${local.input_format}",
      ]
    }
    post-processor "vagrant" {
      compression_level   = "${var.compression_level}"
      keep_input_artifact = true
      provider_override   = "${var.hypervisor}"
      output              = "${local.build_path}/${local.format}/${var.vm_name}.${local.format}"
    }

#    post-processor "manifest" {
#      output      = "${local.build_path}/${local.format}/manifest.json"
#      strip_path  = true
#      custom_data = {
#        format     = "${local.format}"
#        hypervisor = "${var.hypervisor}"
#        vm_name    = "${var.vm_name}"
#        vm_version = "${var.vm_version}"
#      }
#    }
  }
}


