## Instructions on how to build 4.1 + M from source from Github

### Toolchain

```
export AOSP_SRC=<aosp_source_location>
make ARCH=arm64 CROSS_COMPILE=$AOSP_SRC/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- hikey_defconfig 
make ARCH=arm64 CROSS_COMPILE=$AOSP_SRC/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- Image dtbs
```

```
repo init -u git clone https://android.googlesource.com/platform/manifest -b android-6.0.0_r260
cd .repo/
git clone https://github.com/96boards/android_manifest -b android-6.0 local_manifests
cd ../
repo sync -j16
```
Download and extract vendor tarball from the link below:
http://builds.96boards.org/snapshots/hikey/linaro/binaries/20150706/vendor.tar.bz2

```
source build/envsetup.sh
lunch hikey-userdebug
make droidcore -j32
```
, from Vishal Bhoj.