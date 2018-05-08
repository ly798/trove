#!/bin/bash

export DISTRO=ubuntu
export RELEASE=xenial
export DIB_RELEASE=$RELEASE
export SERVICE_TYPE=${1:-mariadb}
export VM=${DISTRO}-${RELEASE}-${SERVICE_TYPE}
# assign a suitable value for each of these environment
# variables that change the way the elements behave.
export HOST_USERNAME=$(whoami) # 现不需要
export HOST_SCP_USERNAME=$HOST_USERNAME # 现不需要
export GUEST_USERNAME=trovedb
export CONTROLLER_IP=192.168.1.1 # 现不需要
export PATH_TROVE="/home/yippee/GlobalProject/trove" # 需要配置
export TROVESTACK_SCRIPTS=${PATH_TROVE}/integration/scripts
export ESCAPED_PATH_TROVE=${PATH_TROVE}
export SSH_DIR=${PATH_TROVE}/integration/scripts/files/keys # 可选配置，指定注入到虚拟机的公钥文件路径
export GUEST_LOGDIR="/tmp/trove-logs" # 先不需要
export ESCAPED_GUEST_LOGDIR=${GUEST_LOGDIR}
export DIB_CLOUD_INIT_DATASOURCES="ConfigDrive"
#export DATASTORE_PKG_LOCATION
#export BRANCH_OVERRIDE

#export PATH_DISKIMAGEBUILDER=/home/yippee/GlobalProject/diskimage-builder/diskimage_builder
export PATH_DISKIMAGEBUILDER=/home/yippee/GlobalProject/diskimage-builder # 需要配置
export PATH_TRIPLEO_ELEMENTS=/home/yippee/GlobalProject/tripleo-image-elements # 需要配置

# you typically do not have to change these variables
export ELEMENTS_PATH=$TROVESTACK_SCRIPTS/files/elements
#export ELEMENTS_PATH+=:$PATH_DISKIMAGEBUILDER/elements
export ELEMENTS_PATH+=:$PATH_DISKIMAGEBUILDER/diskimage-builder/elements
export ELEMENTS_PATH+=:$PATH_TRIPLEO_ELEMENTS/elements
export DIB_APT_CONF_DIR=/etc/apt/apt.conf.d
export DIB_CLOUD_INIT_ETC_HOSTS=true
#local QEMU_IMG_OPTIONS=$(! $(qemu-img | grep -q 'version 1') && echo "--qemu-img-options compat=0.10")

# run disk-image-create that actually causes the image to be built
#${PATH_DISKIMAGEBUILDER}/bin/disk-image-create -a amd64 -o "${VM}" \
disk-image-create -a amd64 -o "${VM}" \
    -x ${QEMU_IMG_OPTIONS} ${DISTRO} ${EXTRA_ELEMENTS} vm \
    cloud-init-datasources ${DISTRO}-${RELEASE}-${SERVICE_TYPE} ${DISTRO}-${RELEASE}-guest

