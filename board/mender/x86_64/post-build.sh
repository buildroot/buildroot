#!/usr/bin/env bash
set -e
DEVICE_TYPE="buildroot-x86_64"

parse_args() {
    local o O opts
    o='a:o:d:'
    O='artifact-name:,data-part-size:,device-type:'
    opts="$(getopt -o "${o}" -l "${O}" -- "${@}")"
    eval set -- "${opts}"
    while [ ${#} -gt 0 ]; do
        case "${1}" in
        (-o|--data-part-size)
            # Ignored to have same options as other scripts
            shift 2
            ;;
        (-d|--device-type)
            DEVICE_TYPE="${2}"; shift 2
            ;;
        (-a|--artifact-name)
            # Ignored to have same options as other scripts
            shift 2
            ;;
        (--)
            shift; break
            ;;
        esac
    done
}

# Create a persistent directory to mount the data partition at.
mender_fixup() {
    pushd "${TARGET_DIR}"
    # The common paradigm is to have the persistent data volume at /data for mender.
    if [[ ! -L data ]]; then
        ln -s var/lib/mender data
    fi

    popd
}

main() {
    parse_args "${@}"
    mender_fixup
    echo "device_type=${DEVICE_TYPE}" > "${TARGET_DIR}/etc/mender/device_type"
}

main "${@}"
