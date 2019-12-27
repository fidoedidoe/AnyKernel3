# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=by fidoedidoe @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=konawifi
device.name2=n5110
device.name3=GT-N5110
device.name4=konawifixx
device.name5=
supported.versions=7.1.2
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/dw_mmc/by-name/BOOT;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

##
ui_print "  =================================";
ui_print "            Version 0.1";
ui_print "  =================================";
ui_print " ";
ui_print "  _____ _                          ";
ui_print " /  __ \ |                         ";
ui_print " | /  \/ |__   ___ _ __ _ __ _   _ ";
ui_print " | |   | '_ \ / _ \ '__| '__| | | |";
ui_print " | \__/\ | | |  __/ |  | |  | |_| |";
ui_print "  \____/_| |_|\___|_|  |_|   \__, |";
ui_print "                              __/ |";
ui_print "                             |___/ ";
ui_print " ______ _      _            _      ";
ui_print " | ___ (_)    | |          | |     ";
ui_print " | |_/ /_  ___| | _____  __| |     ";
ui_print " |  __/| |/ __| |/ / _ \/ _| |     ";
ui_print " | |   | | (__|   <  __/ (_| |     ";
ui_print " \_|   |_|\___|_|\_\___|\__,_|     ";
ui_print " ";
ui_print " ";                                  

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.rc
backup_file init.rc;
insert_line init.rc "init.cpk.rc" after "import /init.cm.rc" "import /init.cpk.rc";

# end ramdisk changes

write_boot;
## end install
