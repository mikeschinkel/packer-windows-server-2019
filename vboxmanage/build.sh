#!/usr/bin/env bash

#From https://gist.github.com/carmark/547004053a266b20fb24

VM="Windows2019_64"
ISO="/Volumes/Tech/ISOs/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"

VBoxManage createhd \
  --filename "${VM}.vdi" \
  --size 32768

VBoxManage createvm \
  --name "${VM}" \
  --ostype "${VM}" \
  --register

VBoxManage storagectl "${VM}" \
  --name "SATA Controller" \
  --add sata \
  --controller IntelAHCI

VBoxManage storageattach "${VM}" \
  --storagectl "SATA Controller" \
  --port 0 \
  --device 0 \
  --type hdd \
  --medium "${VM}.vdi"


VBoxManage storagectl "${VM}" \
  --name "IDE Controller" \
  --add ide

VBoxManage storageattach "${VM}" \
  --storagectl "IDE Controller" \
  --port 0 \
  --device 0 \
  --type dvddrive \
  --medium "${ISO}"


VBoxManage modifyvm "${VM}" --ioapic on
VBoxManage modifyvm "${VM}" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm "${VM}" --memory 1024 --vram 128
VBoxManage modifyvm "${VM}" --nic1 bridged --bridgeadapter1 e1000g0

VBoxHeadless -s "${VM}"

echo "Now RDP to vboxhost:3389"

exit

# Once you have configured the operating system, you can shutdown and eject the DVD.

# Eject DVD
VBoxManage storageattach "${VM}" \
  --storagectl "IDE Controller" \
  --port 0 \
  --device 0 \
  --type dvddrive \
  --medium none

# Take Snapshot
VBoxManage snapshot "${VM}" take my-snapshot

# Restore Snapshot
VBoxManage snapshot "${VM}" restore my-snapshot