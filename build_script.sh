#! /bin/bash

#
# Build support you to
#       - Completely build your system( with buildroot)
#       - Prepare sdk: just make sdk then copy to crosstool folder
#       
#
USAGE=$"usage: build_script.sh (-setup | -full | -app | -rebuild_rootfs | -clean | -sdk)"

set -o  pipefail
set -e


##################################### GLOBAL VAR WTIH DEFAULT VALUE ##########################
APP_PATH="telematic_pkg"
CLEAN_BUILD="false"
SETUP="false"
BUILD_APP="false"
BUILD_FULL="false"
REBUILD_ROOTFS="false"
BUILD_CROSSTOOL="false"


if [ ! -d $APP_PATH ]; then
    echo "ERROR: there is no source in \"${PWD}\""
    exit -1
fi

# start date of masterbuild, format is: yyyymmdd
BUILD_DATE=`date +%Y-%m-%d`
# Start time of masterbuild, format is: hh:mm
BUILD_TIME=`date +%R`
BUILD_TIME_EXT=`date +%H-%M`
BUILD_MACHINE=`hostname`

SHORT_HASH=`git rev-parse --short HEAD`
BUILD_LOG=$PWD/build_${SHORT_HASH}_${BUILD_DATE}_${BUILD_TIME}.log

echo "Starting your job"

################################################# FUNCTION ###################################

is_using_internal_crosstool()
{
    # Function to check whether Buildroot is using an internal or external crosstool
    local config_file=".config"

    if [ ! -f "$config_file" ]; then
        echo "Configuration file ($config_file) not found!"
        return 1
    fi

    # Check for the configuration option indicating use of the internal toolchain
    if grep -q '^BR2_TOOLCHAIN=y' "$config_file"; then
        return 0 # Internal toolchain
    elif grep -q '^BR2_TOOLCHAIN_EXTERNAL=y' "$config_file"; then
        return 1 # External toolchain
    else
        echo "Unknown toolchain configuration."
        return 2 # Unknown
    fi
}


build_crosstool()
{
    # Should add user to make sure that their current config is internal tool chain
    if [ ! is_using_internal_crosstool ]; then
        echo "This command only supported when your crosstool config is internal"
        exit 1
    fi
    rm crosstool.tar.gz
    rm -rf crosstool
    make clean
    make sdk
    mkdir -p crosstool
    cd output/images
    tar -xvf arm-buildroot-linux-gnueabi_sdk-buildroot.tar.gz
    cd -
    cp -rdf  output/images/arm-buildroot-linux-gnueabi_sdk-buildroot/* crosstool
    # remove unused file
    rm crosstool/relocate-sdk.sh
    tar -cvf crosstool.tar.gz crosstool
    setup
    echo "Build sdk and setup env done, now you can update for toolchain in config file
    to external toolchain and specify crosstool.tar.gz dir"
}

setup()
{
    echo "Setting up environment"
    if [ ! -d "crosstool" ]; then 
        tar -xvf crosstool.tar.gz
    fi
    export CROSSTOOL_PATH=${PWD}/crosstool
    export CC=${PWD}/crosstool/bin/arm-buildroot-linux-gnueabi-gcc
    export CXX=${PWD}/crosstool/bin/arm-buildroot-linux-gnueabi-g++
    # dont forget to set sysroot path in your CMake/Makefiles
    echo "Setting up environment done"
}

clean()
{
    echo "Do cleaning output/telematic_pkg"
    rm -rf output/telematic_pkg
    if [ -d "crosstool" ]; then 
        rm -rf crosstool
    fi
}

build_app()
{
    setup
    mkdir -p output
    cd output
    mkdir -p telematic_pkg
    cd telematic_pkg
    cmake ../../telematic_pkg
    cd ../..
}

rebuild_rootfs()
{
    echo "Becarefully, disable build for kernel, just rootfs and package"
    local temp_name=/tmp/${BUILD_DATE}_${BUILD_TIME_EXT}_config
    cp .config ${temp_name}
    sed -i 's/^BR2_LINUX_KERNEL=y/BR2_LINUX_KERNEL=n/' .config
    set +e
    make
    set -e
    cp ${temp_name} .config
}

build_full()
{
    setup
    build_app
    make clean
    make all
}

main()
{
    if [ "$CLEAN_BUILD" = "true" ]; then
        clean
    fi

    if [ "$SETUP" = "true" ]; then
        setup
    fi

    if [ "$BUILD_CROSSTOOL" = "true" ]; then
        build_crosstool
    fi

    if [ "$BUILD_APP" = "true" ]; then
        build_app
    fi

    if [ "$REBUILD_ROOTFS" = "true" ]; then
        rebuild_rootfs
    fi

    if [ "$BUILD_FULL" = "true" ]; then
        build_full
    fi
}

################################################## MAIN ######################################
while [ "$#" != "0" ] ; do
    if [ "$1" = "-clean" ] ; then
        CLEAN_BUILD="true"
    fi
	if [ "$1" = "-setup" ] ; then
        SETUP="true"
    fi
    if [ "$1" = "-full" ] ; then
        BUILD_FULL="true"
    fi
    if [ "$1" = "-app" ]; then
        BUILD_APP="true"
    fi
    if [ "$1" = "-rebuild_rootfs" ]; then
        REBUILD_ROOTFS="true"
    fi
    if [ "$1" = "-sdk" ]; then
        BUILD_CROSSTOOL="true"
    fi
    shift
done

main