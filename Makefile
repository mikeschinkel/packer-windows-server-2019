
define packer_build
	@echo "==> Building $2"
	@echo "==> Logs can be found in $1-build.log"
	@echo "==> Packer file used is $1.pkr.hcl"
	@rm -f "$1-build.log"
	@PACKER_LOG_PATH="$1-build.log"
	packer build \
		-force \
		-only=virtualbox-iso.virtualbox \
		"$1.pkr.hcl"
endef

.PHONY: start ova box

default: start ova box

start:
	[ "${PACKER_LOG}" == "" ] && clear
	@PACKER_LOG=1

ova: start
	$(call packer_build,ova,"VirtualBox OVA")

box: start
	$(call packer_build,box,"Vagrant Box")
