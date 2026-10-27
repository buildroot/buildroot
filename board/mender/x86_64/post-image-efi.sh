#!/usr/bin/env bash
set -e
BOARD_DIR="$(realpath "$(dirname "$0")")"
DATA_PART="${BINARIES_DIR}"/data-part
DATA_PART_SIZE="32M"
COMPATIBLE_TYPES="buildroot-x86_64"
ARTIFACT_NAME="1.0"

# Parse arguments.
parse_args() {
    local o O opts
    o='a:o:c:'
    O='artifact-name:,data-part-size:,compatible-types:'
    opts="$(getopt -o "${o}" -l "${O}" -- "${@}")"
    eval set -- "${opts}"
    while [ ${#} -gt 0 ]; do
        case "${1}" in
        (-o|--data-part-size)
            DATA_PART_SIZE="${2}"; shift 2
            ;;
        (-c|--compatible-types)
            COMPATIBLE_TYPES="${2}"; shift 2
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
make_data_partition() {
    "${HOST_DIR}/sbin/mkfs.ext4" \
        -d "${DATA_PART}" \
        -F \
        -r 1 \
        -N 0 \
        -m 5 \
        -L "data" \
        "${BINARIES_DIR}/data-part.ext4" "${DATA_PART_SIZE}"
}

# Generate a mender bootstrap artifact.
# See https://github.com/mendersoftware/mender/blob/3.5.3/Documentation/automatic-bootstrap-artifact.md
generate_mender_bootstrap_artifact() {

  rm -rf "${DATA_PART}"
  mkdir -p "${DATA_PART}"
  img_checksum=$(sha256sum "${BINARIES_DIR}"/rootfs.ext4 |awk '{print $1}')

  "${HOST_DIR}"/bin/mender-artifact \
    write bootstrap-artifact \
    --compression none \
    --artifact-name "${ARTIFACT_NAME}" \
    --compatible-types "${COMPATIBLE_TYPES}" \
    --provides "rootfs-image.version:${ARTIFACT_NAME}" \
    --provides "rootfs-image.checksum:${img_checksum}" \
    --clears-provides "rootfs-image.*" \
    --output-path "${DATA_PART}"/bootstrap.mender \
    --version 3
}

# Create a mender image.
generate_mender_image() {
    echo "Creating ${BINARIES_DIR}/${ARTIFACT_NAME}.mender"
    "${HOST_DIR}/bin/mender-artifact" \
        write rootfs-image \
        --compression none \
        -c "${COMPATIBLE_TYPES}" \
        -n "${BR2_VERSION}" \
        -f "${BINARIES_DIR}/rootfs.ext2" \
        -o "${BINARIES_DIR}/${ARTIFACT_NAME}.mender"
}

generate_image() {
    support/scripts/genimage.sh -c "${BOARD_DIR}/genimage-efi.cfg"
}

# Main function.
main() {
    parse_args "${@}"
    generate_mender_bootstrap_artifact
    make_data_partition
    generate_image
    generate_mender_image
    exit $?
}

main "${@}"
