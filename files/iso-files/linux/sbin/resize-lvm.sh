#!/bin/bash
# Script to resize all LVM disks/partitions after extending them in VMware
set -e

UNITS=$(pvs | awk 'FNR > 1 {print $1}')
for UNIT in ${UNITS}; do
  PARTNR=$(echo "${UNIT}" | sed "s/^\/dev\/sd.\([0-9]*\)$/\1/")
  DEVICE=${UNIT%${PARTNR}}

  echo 1 > "/sys/class/block/$(basename ${DEVICE})/device/rescan"
  if [ "${PARTNR}" != "" ]; then
    growpart -u auto "${DEVICE}" ${PARTNR}
  fi
  pvresize "${DEVICE}${PARTNR}"
done