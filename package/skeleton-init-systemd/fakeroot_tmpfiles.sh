#!/bin/sh
#
# The systemd-tmpfiles has the ability to grab information
# from the filesystem (instead from the running system).
#
# tmpfs directories (/tmp, /proc, ...) are skipped since they're not
# relevant for the rootfs image.
#
# However there are a few specifiers that *always* will grab
# information from the running system examples are %a, %b, %m, %H
# (Architecture, Boot UUID, Machine UUID, Hostname).
#
# See [1] for historic information.
#
# This script will (conservatively) skip tmpfiles lines that have
# such an specifier to prevent leaking host information.
#
# shell expansion is critical to be POSIX compliant,
# this script won't work with zsh in its default mode for example.
#
# The script takes several measures to handle more complex stuff
# like passing this correctly:
# f+  "/var/example" - - - - %B\n%o\n%w\n%W%%\n
#
# [1] - https://github.com/systemd/systemd/pull/16187

[ -n "${HOST_SYSTEMD_TMPFILES-}" ] ||
    HOST_SYSTEMD_TMPFILES=systemd-tmpfiles

[ -n "${1-}" -a -d "${1-}"/usr/lib/tmpfiles.d ] ||
    { echo 1>&2 "$0: need ROOTFS argument"; exit 1; }

${HOST_SYSTEMD_TMPFILES} --no-pager --cat-config --root="$1" |
    sed -e '/^[[:space:]]*#/d' -e 's,^[[:space:]]*,,' -e '/^$/d' |
    while read -r line; do
        # it is allowed to use quotes around arguments,
        # so let the shell pack the arguments
        eval "set -- $line"

        # dont output warnings for directories we dont process
        [ "${2#/dev}" = "${2}" ] && [ "${2#/proc}" = "${2}" ] &&
            [ "${2#/run}" = "${2}" ] && [ "${2#/sys}" = "${2}" ] &&
            [ "${2#/tmp}" = "${2}" ] && [ "${2#/mnt}" = "${2}" ] ||
            continue

        # blank out all specs that are ok to use,
        # test if some remain. (Specs up to date with v250)
        if echo "$2 ${7-}" | sed -e 's,%[%BCEgGhLMosStTuUVwW],,g' | grep -v -q '%'; then
            # no "bad" specifiers, pass the line unmodified
            eval "printf '%s\n' '$line'"
        else
            # warn
            eval "printf 'ignored spec: %s\n' '$line' 1>&2"
        fi
    done |
    TMPDIR= TEMP= TMP= ${HOST_SYSTEMD_TMPFILES} --create --boot --root="$1" \
        --exclude-prefix=/dev --exclude-prefix=/proc --exclude-prefix=/run \
        --exclude-prefix=/sys --exclude-prefix=/tmp --exclude-prefix=/mnt \
        -
