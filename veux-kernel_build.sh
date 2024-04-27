#!/bin/bash
git clone https://github.com/jiganomegsdfdf/linux.git --branch master --depth 1 linux
cd linux
make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig veux_defconfig
make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
#_kernel_version="$(make kernelrelease -s)"

cp arch/arm64/boot/Image.gz ../boot-by-partition-build/boot32/kernel
sed -i "s/kernel_size=10421535/kernel_size=$(du ../boot-by-partition-build/boot32/kernel)/"


#cp arch/arm64/boot/Image.gz ../linux-xiaomi-veux/boot/vmlinuz-$_kernel_version
#cp arch/arm64/boot/dts/qcom/sm6375-xiaomi-veux.dtb ../linux-xiaomi-veux/boot/dtb-$_kernel_version
#sed -i "s/Version:.*/Version: ${_kernel_version}/" ../linux-xiaomi-veux/DEBIAN/control

#make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=../linux-xiaomi-veux modules_install
#rm ../linux-xiaomi-veux/lib/modules/**/build
cd ..
rm -rf linux

dpkg-deb --build --root-owner-group firmware-xiaomi-veux
