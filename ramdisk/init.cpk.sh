#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

################################################################################

{

   UNSTABLE="0"

   # Print info to log
   #
   L="log -p i -t cm"

   $L "### ------------------------"
   $L "### init.cpl.sh: starting..."
   #$L "### UNSTABLE=$UNSTABLE"
   $L "### ------------------------"

   # Reset all properties, settings aren't stable!
   # updater script / manual intervention will remove this
   # to trigger a revert to defaults settings
   if [ ! -f /data/property/persist.cpk.stable ]; then
       UNSTABLE="1"
       setprop persist.cpk.stable "Delete this property & reboot to reset all 'on boot' settings to 'safe' defaults"
       # Print info to log
       #
       L="log -p i -t cm"

       $L "### ---------------------------------------------------"
       $L "### init.cpl.sh: resetting 'on boot' values to defaults"
       $L "### ---------------------------------------------------"
   fi


   # If there is no persistent values we need to set them
   if [ ! -f /data/property/persist.cpk.zzm_profile ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.zzm_profile "8"
   fi

   if [ ! -f /data/property/persist.cpk.zzm_profile ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.cpu_gov "zzmoove"
   fi
   
if [ ! -f /data/property/persist.cpk.cpu_min ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.cpu_min "200000"
   fi

   if [ ! -f /data/property/persist.cpk.cpu_max ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.cpu_max "1600000"
   fi
   
   if [ ! -f /data/property/persist.cpk.cpu_voltage ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.cpu_voltage "0"
   fi
   
   if [ ! -f /data/property/persist.cpk.cpu_idle ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.cpu_idle "3"
   fi
   
   if [ ! -f /data/property/persist.cpk.gpu_profile ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.gpu_profile "1-0"
   fi

   if [ ! -f /data/property/persist.cpk.internal_ra_kb ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.internal_ra_kb "512"
   fi

   if [ ! -f /data/property/persist.cpk.external_ra_kb ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.external_ra_kb "0"
   fi

   if [ ! -f /data/property/persist.cpk.module_debug ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.module_debug "0"
   fi

   if [ ! -f /data/property/persist.cpk.system_tweaks ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.system_tweaks "1"
   fi

   if [ ! -f /data/property/persist.cpk.io_scheduler ] || [ $UNSTABLE -eq 1 ]; then
       setprop persist.cpk.io_scheduler "row"
   fi

   #Read property values and set them again 
   #This triggers "on property" action in init.cp.rc

   # Print info to log
   #
   L="log -p i -t cm"

   $L "### ------------------------------"
   $L "### init.cpk.sh: Getting properties"
   $L "### ------------------------------"

   zzm_profile=$(getprop persist.cpk.zzm_profile)
   cpu_gov=$(getprop persist.cpk.cpu_gov)
   cpu_min=$(getprop persist.cpk.cpu_min)
   cpu_max=$(getprop persist.cpk.cpu_max)
   cpu_voltage=$(getprop persist.cpk.cpu_voltage)
   cpu_idle=$(getprop persist.cpk.cpu_idle)
   gpu_profile=$(getprop persist.cpk.gpu_profile)
   internal_ra_kb=$(getprop persist.cpk.internal_ra_kb)
   external_ra_kb=$(getprop persist.cpk.external_ra_kb)
   module_debug=$(getprop persist.cpk.module_debug)
   system_tweaks=$(getprop persist.cpk.system_tweaks)
   io_scheduler=$(getprop persist.cpk.io_scheduler)

   # Print info to log
   #
   L="log -p i -t cm"

   $L "### -------------------------------"
   $L "### init.cpk.sh: Setting properties"
   $L "###   setprop persist.cpk.zzm_profile $zzm_profile"
   $L "###   setprop persist.cpk.cpu_gov $cpu_gov"
   $L "###   setprop persist.cpk.cpu_min $cpu_min"
   $L "###   setprop persist.cpk.cpu_max $cpu_max"
   $L "###   setprop persist.cpk.cpu_voltage $cpu_voltage"
   $L "###   setprop persist.cpk.cpu_idle $cpu_idle"
   $L "###   setprop persist.cpk.gpu_profile $gpu_profile"
   $L "###   setprop persist.cpk.internal_ra_kb $internal_ra_kb"
   $L "###   setprop persist.cpk.external_ra_kb $external_ra_kb"
   $L "###   setprop persist.cpk.module_debug $module_debug"
   $L "###   setprop persist.cpk.system_tweaks $system_tweaks"
   $L "###   setprop persist.cpk.io_scheduler $io_scheduler"
   $L "### -------------------------------"

   setprop persist.cpk.zzm_profile $zzm_profile
   setprop persist.cpk.cpu_gov $cpu_gov
   setprop persist.cpk.cpu_min $cpu_min
   setprop persist.cpk.cpu_max $cpu_max
   setprop persist.cpk.cpu_voltage $cpu_voltage
   setprop persist.cpk.cpu_idle $cpu_idle
   setprop persist.cpk.gpu_profile $gpu_profile
   setprop persist.cpk.internal_ra_kb $internal_ra_kb
   setprop persist.cpk.external_ra_kb $external_ra_kb
   setprop persist.cpk.module_debug $module_debug
   setprop persist.cpk.system_tweaks $system_tweaks
   setprop persist.cpk.io_scheduler $io_scheduler

   # Print info to log
   #
   L="log -p i -t cm"

   $L "### ----------------------"
   $L "### init.cpk.sh: Finished!"
   $L "### ----------------------"
}&

