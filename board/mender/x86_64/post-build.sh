#!/usr/bin/env bash
set -e
COMPATIBLE_TYPES="buildroot-x86_64"

parse_args() {
    local o O opts
    o='a:o:c:'
    O='artifact-name:,data-part-size:,compatible-types:'
    opts="$(getopt -o "${o}" -l "${O}" -- "${@}")"
    eval set -- "${opts}"
    while [ ${#} -gt 0 ]; do
        case "${1}" in
        (-o|--data-part-size)
            # Ignored to have same options as other scripts
            shift 2
            ;;
        (-c|--compatible-types)
            COMPATIBLE_TYPES="${2}"; shift 2
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
    echo "device_type=${COMPATIBLE_TYPES}" > "${TARGET_DIR}/etc/mender/device_type"
}

main "${@}"
