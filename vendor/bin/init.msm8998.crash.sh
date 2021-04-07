#!/vendor/bin/sh
# Copyright (c) 2014-2017, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

enable=`getprop persist.vendor.lge.service.crash.enable`

# Function MSM8998 DCC configuration
enable_msm8998_dcc_config()
{
    DCC_PATH="/sys/bus/platform/devices/10b3000.dcc"
    if [ ! -d $DCC_PATH ]; then
        echo "DCC don't exist on this build."
        return
    fi

    echo  0 > $DCC_PATH/enable
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    echo  1 > $DCC_PATH/config_reset

    #OSM WDOG
    echo 0x179C1C00 37 > $DCC_PATH/config
    echo 0x179C3C00 37 > $DCC_PATH/config
    #APM
    echo 0x179D0000 1 > $DCC_PATH/config
    echo 0x179D000C 1 > $DCC_PATH/config
    echo 0x179D0018 1 > $DCC_PATH/config
    #L2_SAW4_PMIC_STS
    echo 0x17912C18 1 > $DCC_PATH/config
    echo 0x17812C18 1 > $DCC_PATH/config
    #CPRH_STATUS
    echo 0x179CBAA4 1 > $DCC_PATH/config
    echo 0x179C7AA4 1 > $DCC_PATH/config

    # default configuration
    #SPM registers
    echo 0x17989000 > $DCC_PATH/config
    echo 0x17989C0C > $DCC_PATH/config
    echo 0x17988064 > $DCC_PATH/config
    echo 0x17999000 > $DCC_PATH/config
    echo 0x17999C0C > $DCC_PATH/config
    echo 0x17998064 > $DCC_PATH/config
    echo 0x179A9000 > $DCC_PATH/config
    echo 0x179A9C0C > $DCC_PATH/config
    echo 0x179A8064 > $DCC_PATH/config
    echo 0x179B9000 > $DCC_PATH/config
    echo 0x179B9C0C > $DCC_PATH/config
    echo 0x179B8064 > $DCC_PATH/config
    echo 0x17912000 > $DCC_PATH/config
    echo 0x17912C0C > $DCC_PATH/config
    echo 0x17911210 > $DCC_PATH/config
    echo 0x17911290 > $DCC_PATH/config
    echo 0x17911218 > $DCC_PATH/config
    echo 0x17889000 > $DCC_PATH/config
    echo 0x17889C0C > $DCC_PATH/config
    echo 0x17888064 > $DCC_PATH/config
    echo 0x17899000 > $DCC_PATH/config
    echo 0x17899C0C > $DCC_PATH/config
    echo 0x17898064 > $DCC_PATH/config
    echo 0x178A9000 > $DCC_PATH/config
    echo 0x178A9C0C > $DCC_PATH/config
    echo 0x178A8064 > $DCC_PATH/config
    echo 0x178B9000 > $DCC_PATH/config
    echo 0x178B9C0C > $DCC_PATH/config
    echo 0x178B8064 > $DCC_PATH/config
    echo 0x17812000 > $DCC_PATH/config
    echo 0x17812C0C > $DCC_PATH/config
    echo 0x17811210 > $DCC_PATH/config
    echo 0x17811290 > $DCC_PATH/config
    echo 0x17811218 > $DCC_PATH/config
    echo 0x179D2000 > $DCC_PATH/config
    echo 0x179D2C0C > $DCC_PATH/config
    echo 0x7ba4008 > $DCC_PATH/config
    echo 0x7ba400C > $DCC_PATH/config
    echo 0x7ba4010 > $DCC_PATH/config
    echo 0x7ba4014 > $DCC_PATH/config

    # CCI ACE / Stalled Transaction
    echo 0x7ba82B0 > $DCC_PATH/config

    # 8 times, same register
    echo 0x7ba1000 > $DCC_PATH/config
    echo 0x7ba1000 > $DCC_PATH/config
    echo 0x7ba1000 > $DCC_PATH/config
    echo 0x7ba1000 > $DCC_PATH/config
    echo 0x7ba1000 > $DCC_PATH/config
    echo 0x7ba1000 > $DCC_PATH/config
    echo 0x7ba1000 > $DCC_PATH/config
    echo 0x7ba1000 > $DCC_PATH/config

    #SCMO STATUS
    echo 0x01030560  1 > $DCC_PATH/config
    echo 0x010305A0  1 > $DCC_PATH/config
    echo 0x0103C560  1 > $DCC_PATH/config
    echo 0x0103C5A0  1 > $DCC_PATH/config

    #DPE STATUS
    echo 0x0103409C 1 > $DCC_PATH/config
    echo 0x0104009C 1 > $DCC_PATH/config

    # DDR registers Masterport status
    echo 0x01008400 38 > $DCC_PATH/config
    echo 0x0101C400 38 > $DCC_PATH/config
    echo 0x01014400 38 > $DCC_PATH/config
    echo 0x01010400 38 > $DCC_PATH/config
    echo 0x01018400 38 > $DCC_PATH/config

    #SWAY
    echo 0x01048400 16 > $DCC_PATH/config
    echo 0x01050400 16 > $DCC_PATH/config
    echo 0x01058400 16 > $DCC_PATH/config

    #ARB
    echo 0x01049800  1 > $DCC_PATH/config
    echo 0x01051800  1 > $DCC_PATH/config
    echo 0x01059800  1 > $DCC_PATH/config

    #DRAM Status
    echo 0x01035074 1 > $DCC_PATH/config
    echo 0x01041074 1 > $DCC_PATH/config
    echo 0x01030450 1 > $DCC_PATH/config
    echo 0x0103C450 1 > $DCC_PATH/config

    # APCS_ALIAS0_CPU_PWR_CTL
    echo 0x17988004 2 > $DCC_PATH/config
    echo 0x17998004 2 > $DCC_PATH/config
    echo 0x179A8004 2 > $DCC_PATH/config
    echo 0x179B8004 2 > $DCC_PATH/config
    echo 0x17888004 2 > $DCC_PATH/config
    echo 0x17898004 2 > $DCC_PATH/config
    echo 0x178A8004 2 > $DCC_PATH/config
    echo 0x178B8004 2 > $DCC_PATH/config
    echo 0x17911014 2 > $DCC_PATH/config
    echo 0x17811014 2 > $DCC_PATH/config

    echo  1 > $DCC_PATH/enable
}

disable_msm8998_dcc_config()
{
    DCC_PATH="/sys/bus/platform/devices/10b3000.dcc"
    if [ ! -d $DCC_PATH ]; then
        echo "DCC don't exist on this build."
        return
    fi

    echo  0 > $DCC_PATH/enable
}

enable_msm8998_core_hang_config()
{
    CORE_PATH_SILVER="/sys/devices/system/cpu/hang_detect_silver"
    CORE_PATH_GOLD="/sys/devices/system/cpu/hang_detect_gold"
    if [ ! -d $CORE_PATH_SILVER ]; then
        echo "CORE hang does not exist on this build."
        return
    fi

    #select instruction retire as the pmu event
    echo 0x7 > $CORE_PATH_SILVER/pmu_event_sel
    echo 0xA > $CORE_PATH_GOLD/pmu_event_sel

    #set the threshold to around 9 milli-second
    echo 0x2a300 > $CORE_PATH_SILVER/threshold
    echo 0x2a300 > $CORE_PATH_GOLD/threshold

    #To the enable core hang detection
    #echo 0x1 > /sys/devices/system/cpu/hang_detect_silver/enable
    #echo 0x1 > /sys/devices/system/cpu/hang_detect_gold/enable
}

disable_msm8998_core_hang_config()
{
    CORE_PATH_SILVER="/sys/devices/system/cpu/hang_detect_silver"
    CORE_PATH_GOLD="/sys/devices/system/cpu/hang_detect_gold"
    if [ ! -d $CORE_PATH_SILVER ]; then
        echo "CORE hang does not exist on this build."
        return
    fi

    #To the disable core hang detection
    #echo 0x0 > /sys/devices/system/cpu/hang_detect_silver/enable
    #echo 0x0 > /sys/devices/system/cpu/hang_detect_gold/enable
}

enable_msm8998_gladiator_hang_config()
{
    GLADIATOR_PATH="/sys/devices/system/cpu/gladiator_hang_detect"
    if [ ! -d $GLADIATOR_PATH ]; then
        echo "Gladiator hang does not exist on this build."
        return
    fi

    #set the threshold to around 9 milli-second
    echo 0x0002a300 > $GLADIATOR_PATH/ace_threshold
    echo 0x0002a300 > $GLADIATOR_PATH/io_threshold
    echo 0x0002a300 > $GLADIATOR_PATH/m1_threshold
    echo 0x0002a300 > $GLADIATOR_PATH/m2_threshold
    echo 0x0002a300 > $GLADIATOR_PATH/pcio_threshold

    #To enable gladiator hang detection
    #echo 0x1 > /sys/devices/system/cpu/gladiator_hang_detect/enable
}

disable_msm8998_gladiator_hang_config()
{
    GLADIATOR_PATH="/sys/devices/system/cpu/gladiator_hang_detect"
    if [ ! -d $GLADIATOR_PATH ]; then
        echo "Gladiator hang does not exist on this build."
        return
    fi

    #To disable gladiator hang detection
    #echo 0x0 > /sys/devices/system/cpu/gladiator_hang_detect/enable
}

case "$enable" in
    "1")
        enable_msm8998_dcc_config
        enable_msm8998_core_hang_config
        enable_msm8998_gladiator_hang_config
        ;;
    "0")
        disable_msm8998_dcc_config
        disable_msm8998_core_hang_config
        disable_msm8998_gladiator_hang_config
        ;;
esac

