#!/usr/bin/env bash
clear
rm build.log
PACKER_LOG=1 packer build box.pkr.hcl | tee build.log
