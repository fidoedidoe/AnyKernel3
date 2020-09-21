# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=ExampleKernel by osm0sis @ xda-developers
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=dreamlte
device.name2=dream2lte
device.name3=greatlte
supported.versions=9
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/11120000.ufs/by-name/BOOT;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.rc
#backup_file init.rc;
#replace_string init.rc "cpuctl cpu,timer_slack" "mount cgroup none /dev/cpuctl cpu" "mount cgroup none /dev/cpuctl cpu,timer_slack";

# Remove RMM lock (credits: @corsicanu)
ui_print "Removing RMM lock... (credits: corsicanu@XDA)";
replace_string /system/build.prop "ro.security.vaultkeeper.feature=1" "ro.security.vaultkeeper.feature=0";
sed -i 's/vaultkeeper\.feature\=1/vaultkeeper\.feature\=0/' /system/build.prop;
rm -f /system/lib/libvk*;
rm -f /system/lib64/libvk*;
rm -rf /system/priv-app/Rlc;
rm -rf /system/priv-app/KnoxGuard;

# init.tuna.rc
#backup_file init.tuna.rc;
#insert_line init.tuna.rc "nodiratime barrier=0" after "mount_all /fstab.tuna" "\tmount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data remount nosuid nodev noatime nodiratime barrier=0";
#append_file init.tuna.rc "bootscript" init.tuna;

# fstab.tuna
#backup_file fstab.tuna;
#patch_fstab fstab.tuna /system ext4 options "noatime,barrier=1" "noatime,nodiratime,barrier=0";
#patch_fstab fstab.tuna /cache ext4 options "barrier=1" "barrier=0,nomblk_io_submit";
#patch_fstab fstab.tuna /data ext4 options "data=ordered" "nomblk_io_submit,data=writeback";
#append_file fstab.tuna "usbdisk" fstab;

# end ramdisk changes

# Check device dtb
mv -f $home/*${device_name}*/Image $home/Image;
mv -f $home/*${device_name}*/dtb_$device_name.img $split_img/extra;

write_boot;
## end install

