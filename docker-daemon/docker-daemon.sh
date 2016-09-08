#!/bin/bash

# You need to modify the ${DEVICE} on your on machine.
# And maybe you also need to modiy the `docker.service`

DEVICE="/dev/sda3"

echo "dmsetup remove"
/usr/sbin/dmsetup remove docker-thinpool
/usr/sbin/dmsetup remove docker-thinpool_tmeta
/usr/sbin/dmsetup remove docker-thinpool_tdata

echo " "
echo "pvcreate ${DEVICE}"
/usr/sbin/pvcreate ${DEVICE} -ff

echo " "
echo "vgcreate docker ${DEVICE}"
/usr/sbin/vgcreate docker ${DEVICE}

echo " "
echo "lvcreate --wipesignatures y -n thinpool docker -l 95%VG"
/usr/sbin/lvcreate --wipesignatures y -n thinpool docker -l 95%VG

echo " "
echo "lvcreate --wipesignatures y -n thinpoolmeta docker -l 1%VG"
/usr/sbin/lvcreate --wipesignatures y -n thinpoolmeta docker -l 1%VG

echo " "
echo "lvconvert -y --zero n -c 512K --thinpool docker/thinpool --poolmetadata docker/thinpoolmeta"
/usr/sbin/lvconvert -y --zero n -c 512K --thinpool docker/thinpool --poolmetadata docker/thinpoolmeta

echo " "
echo "lvchange --metadataprofile docker-thinpool docker/thinpool"
/usr/sbin/lvchange --metadataprofile docker-thinpool docker/thinpool

echo " "
echo "lvs -o+seg_monitor"
/usr/sbin/lvs -o+seg_monitor

echo " "
echo "rm -rf /var/lib/docker/*"
/usr/bin/rm -rf /var/lib/docker/*

echo " "
echo "dockerd"
#/usr/bin/dockerd --storage-driver=devicemapper --storage-opt=dm.thinpooldev=/dev/mapper/docker-thinpool --storage-opt dm.use_deferred_removal=true



