
compression_level = 0

headless          = false
winrm_insecure    = true
winrm_use_ntlm    = true
winrm_use_ssl     = true

build_dir         = "build"
scripts_dir       = "scripts"
communicator      = "winrm"
iso_interface     = "sata"
hypervisor        = "virtualbox"
shutdown_command  = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
shutdown_timeout  = "30m"
vm_name           = "WindowsServer2019"
vm_version        = "1.0.0"
winrm_password    = "vagrant"
winrm_timeout     = "4h"
winrm_username    = "Administrator"


