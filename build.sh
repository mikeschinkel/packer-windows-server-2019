#!/usr/bin/env bash

clear
rm -f build.log
PACKER_LOG=1 packer build \
  -on-error=ask \
  -debug \
  -force \
  -only=virtualbox-iso.ova \
  "ova.pkr.hcl" \
  | tee build.log
