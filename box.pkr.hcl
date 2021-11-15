packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> v1.0.0"
    }
  }
}

variable "vm_name" {
  type    = string
  default = "WindowServer2019.17763"
}

source "null" "example" {
  communicator = "none"
}

build {
  sources = [
    "source.null.example"
  ]
  post-processors {
    post-processor "artifice" {
      files = [
        "${path.cwd}/virtualbox/${var.vm_name}.ova",
      ]
    }
    post-processor "vagrant" {
      compression_level   = 0
      keep_input_artifact = true
      provider_override   = "virtualbox"
      output = "vagrant/${var.vm_name}.box"
    }
  }
}


