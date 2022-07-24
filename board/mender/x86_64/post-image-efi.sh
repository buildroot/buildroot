#!/usr/bin/env bash
set -e
BOARD_DIR="$(realpath "$(dirname "$0")")"
DATA_PART_SIZE="32M"
DEVICE_TYPE="buildroot-x86_64"
ARTIFACT_NAME="1.0"


# Parse arguments.
function parse_args {
    local o O opts
    o='a:o:d:'
    O='artifact-name:,data-part-size:,device-type:'
    opts="$(getopt -o "${o}" -l "${O}" -- "${@}")"
    eval set -- "${opts}"
    while [ ${#} -gt 0 ]; do
        case "${1}" in
        (-o|--data-part-size)
            DATA_PART_SIZE="${2}"; shift 2
            ;;
        (-d|--device-type)
            DEVICE_TYPE="${2}"; shift 2
            ;;
        (-a|--artifact-name)
            ARTIFACT_NAME="${2}"; shift 2
            ;;
        (--)
            shift; break
            ;;
        esac
    done
}

# Create the data partition
function make_data_partition {
    "${HOST_DIR}/sbin/mkfs.ext4" \
        -F \
        -r 1 \
        -N 0 \
        -m 5 \
        -L "data" \
        "${BINARIES_DIR}/data-part.ext4" "${DATA_PART_SIZE}"
}


# Create a mender image.
function generate_mender_image {
    echo "Creating ${BINARIES_DIR}/${DEVICE_TYPE}-${ARTIFACT_NAME}.mender"
    "${HOST_DIR}/bin/mender-artifact" \
        --compression lzma \
        write rootfs-image \
        -t "${DEVICE_TYPE}" \
        -n "${BR2_VERSION}" \
        -f "${BINARIES_DIR}/rootfs.ext2" \
        -o "${BINARIES_DIR}/${DEVICE_TYPE}-${ARTIFACT_NAME}.mender"
}


function generate_image {
    sh support/scripts/genimage.sh -c "${BOARD_DIR}/genimage-efi.cfg"
}

# Main function.
function main {
    parse_args "${@}"
    make_data_partition
    generate_image
    generate_mender_image
    exit $?
}

main "${@}"
