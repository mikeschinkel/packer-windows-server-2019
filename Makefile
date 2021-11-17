
define packer_build
	@echo "==> Building $2 with Packer using $1.pkr.hcl."
	@echo "==> Logs can be found in $1-build.log."
	@rm -f "$1-build.log"
	@PACKER_LOG_PATH="$1-build.log"
	@packer build ${FLAGS} \
		-force \
		"$1.pkr.hcl"
endef

.PHONY: start ova box

default: start ova box

start:
	[ "${PACKER_LOG}" == "" ] && clear
	@PACKER_LOG=1

box: start
	$(call packer_build,box,"Vagrant Box")

ova: FLAGS = -only=virtualbox-iso.virtualbox
ova: start
	$(call packer_build,ova,"VirtualBox OVA")

