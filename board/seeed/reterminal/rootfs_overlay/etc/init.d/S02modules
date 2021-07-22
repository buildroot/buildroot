#!/bin/sh
########################################################################
#
# Description : Module auto-loading script
#
# Authors     : Zack Winkles
#
# Version     : 00.00
#
# Notes       :
#
########################################################################

. /etc/sysconfig/functions

# Assure that the kernel has module support.
[ -e /proc/ksyms -o -e /proc/modules ] || exit 0

case "${1}" in
    start)

        # Exit if there's no modules file or there are no
        # valid entries
        [ -r /etc/sysconfig/modules ] &&
            egrep -qv '^($|#)' /etc/sysconfig/modules ||
            exit 0

        boot_mesg -n "Loading modules:" ${INFO}

        # Only try to load modules if the user has actually given us
        # some modules to load.
        while read module args; do

            # Ignore comments and blank lines.
            case "$module" in
                ""|"#"*) continue ;;
            esac

            # Attempt to load the module, making
            # sure to pass any arguments provided.
            modprobe ${module} ${args} >/dev/null

            # Print the module name if successful,
            # otherwise take note.
            if [ $? -eq 0 ]; then
                boot_mesg -n " ${module}" ${NORMAL}
            else
                failedmod="${failedmod} ${module}"
            fi
        done < /etc/sysconfig/modules

        boot_mesg "" ${NORMAL}
        # Print a message about successfully loaded
        # modules on the correct line.
        echo_ok

        # Print a failure message with a list of any
        # modules that may have failed to load.
        if [ -n "${failedmod}" ]; then
            boot_mesg "Failed to load modules:${failedmod}" ${FAILURE}
            echo_failure
        fi
        ;;
    *)
        echo "Usage: ${0} {start}"
        exit 1
        ;;
esac