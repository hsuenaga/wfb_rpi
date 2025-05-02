#!/usr/bin/env sh

TOPDIR=$PWD

SRCDIR="${TOPDIR}/buildroot"
OUTDIR="${TOPDIR}/output"
EXTDIR="${TOPDIR}/external"

#BR2_GLOBAL_PATCH_DIR="$(BR2_EXTERNAL_WFB_PATH)/patches/"
#BR2_ROOTFS_OVERLAY="$(BR2_EXTERNAL_WFB_PATH)/rootfs_overlay/"
#BR2_ROOTFS_POST_IMAGE_SCRIPT="$(BR2_EXTERNAL_WFB_PATH)/board/hsuenaga/raspberrypi4-64/post-image.sh"
#BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="$(BR2_EXTERNAL_WFB_PATH)/board/hsuenaga/raspberrypi4-64/kernel.config"

if [ ! -d ${OUTDIR} ]; then
  mkdir -p $OUTDIR
fi

echo "Buildroot source: ${SRCDIR}"
echo "Buildroot external: ${EXTDIR}"
echo "Buildroot output: ${OUTDIR}"
echo ""
exec make O=${OUTDIR} \
	"BR2_EXTERNAL=${EXTDIR}" \
	"BR2_GLOBAL_PATCH_DIR=\$(BR2_EXTERNAL_WFB_PATH)/patches/" \
	"BR2_ROOTFS_OVERLAY=\$(BR2_EXTERNAL_WFB_PATH)/rootfs_overlay/" \
	"BR2_DEFCONFIG=\$(BR2_EXTERNAL_WFB_PATH)/configs/wfb_defconfig" \
	-C "${SRCDIR}" \
	$1
