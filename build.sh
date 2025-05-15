#!/usr/bin/env sh

while getopts c OPT; do
  case $OPT in
    c) C_FLAG="Y" ;;
    *) exit 1 ;;
  esac
done
shift $((OPTIND - 1))

TOPDIR=$PWD

SRCDIR="${TOPDIR}/buildroot"
OUTDIR="${TOPDIR}/output"
EXTDIR="${TOPDIR}/external"
DLDIR="${TOPDIR}/dl"

if [ ! -d ${OUTDIR} ]; then
  mkdir -p $OUTDIR
fi

do_build () {
	make O=${OUTDIR} \
		"BR2_DL_DIR=${DLDIR}" \
		"BR2_EXTERNAL=${EXTDIR}" \
		-C "${SRCDIR}" \
		$1
}

echo "Buildroot source: ${SRCDIR}"
echo "Buildroot external: ${EXTDIR}"
echo "Buildroot output: ${OUTDIR}"
echo "Buildroot dl: ${DLDIR}"
echo ""

if [ X"${C_FLAG}" = "XY" ]; then
	echo "Force clean..."
	do_build clean
fi

if [ -z "$1" ]; then
	do_build wfb_defconfig
	do_build all
else
	do_build $1
fi
