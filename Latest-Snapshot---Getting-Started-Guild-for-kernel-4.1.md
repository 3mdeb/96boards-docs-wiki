2. Usman to follow up with Vishal to make sure we have M working with 4.1 from Github. Need instructions on how to build 4.1 + M from source from Github.

These are the instructions. Please update the wiki with these :
`
repo init -u git clone https://android.googlesource.com/platform/manifest -b android-6.0.0_r26
cd .repo/
git clone https://github.com/96boards/android_manifest -b android-6.0 local_manifests
cd ../
repo sync -j16
Download and extract vendor tarball from the link below:
http://builds.96boards.org/snapshots/hikey/linaro/binaries/20150706/vendor.tar.bz2
source build/envsetup.sh
lunch hikey-userdebug
make droidcore -j32
`