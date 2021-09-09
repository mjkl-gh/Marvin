#!/bin/sh

echo
date
echo $0
TEMPDIR="temp"
PKGVERSION="v11_002034.fullos.55915876-2190-407a-9fcb-f1e760d9b623.pkg"
if [ ! -r "${TEMPDIR}" ]; then
    mkdir ${TEMPDIR}
fi

wget -nc https://vacuumz.info/download/gen2/stock/${PKGVERSION} -P ./${TEMPDIR}/
wget -nc https://vacuumz.info/download/gen2/stock/${PKGVERSION}.md5 -P ./${TEMPDIR}/

wget -nc https://github.com/Hypfer/Valetudo/releases/latest/download/valetudo-armv7 -O ./${TEMPDIR}/valetudo

sudo ./vacuum/builder_vacuum.sh     --run-custom-script=ALL \
                        --timezone=Europe/Amsterdam \
                        --ntpserver=pool.ntp.org \
                        --root-pass=cleaner \
                        --custom-user=cleaner \
                        --custom-user-pass=cleaner \
                        --enable-greeting \
                        --enable-addon \
                        --enable-binding \
                        --enable-turn-off-ny \
                        --disable-logs \
                        --enable-ramdisk \
                        --replace-adbd \
                        --enable-appproxy-patcher \
                        --valetudo-path=./${TEMPDIR}/ \
                        --replace-miio \
                        --enable-dns-catcher \
                        --enable-addon-sox \
                        --enable-local-ota \
                        --resize-root-fs=522240 \
                        --custom-dropbear \
                        --enable-sound-server \
                        --diff \
                        -f ./${TEMPDIR}/${PKGVERSION}

rm -r temp