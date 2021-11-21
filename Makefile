#!/usr/bin/make -f

define packer_build
	@# Creating local variables in _packer_build() by passing them from here.
	@# See https://www.gnu.org/software/make/manual/make.html#Reading-Makefiles
	@# If there is a better way, I'm all ears.
	@$(call _packer_build,"$1","$2","build/logs/$1-build.log","./packer/$1.pkr.hcl")
endef

define _packer_build
	@echo "==> Building $2 [$1]"
	@echo "==> Logs can be found in $3"
	@echo "==> Packer file used is $4"
	@mkdir -p "./build/logs"
	@rm -f "$3"
	@PACKER_LOG_PATH="$3" PACKER_LOG=1 packer build -force -var-file="./packer/vm.pkrvar.hcl" "$4"
endef

.PHONY: install configure convert

default: install configure convert

install:
	$(call packer_build,install,"VirtualBox OFV from Windows Server ISO")

configure:
	$(call packer_build,configure,"VirtualBox OVA from VirtualBox OFV")

convert:
	$(call packer_build,convert,"Vagrant BOX from VirtualBox OVA")

