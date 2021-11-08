#!/usr/bin/env bash

PACKER_LOG=1 packer build \
  -force \
  -only=virtualbox-iso.windows-server_1 \
  bios.pkr.hcl \
  | tee build.log
