#!/usr/bin/env bash
set -e
COMPATIBLE_TYPE="buildroot-arm"
ARTIFACT_NAME="RUNTIME_TEST_ARTIFACT_NAME"

generate_mender_bootstrap_artifact() {
  img_checksum=$(sha256sum "${BINARIES_DIR}"/rootfs.cpio |awk '{print $1}')

  "${HOST_DIR}"/bin/mender-artifact \
    write bootstrap-artifact \
    --compression none \
    --artifact-name "${ARTIFACT_NAME}" \
    --compatible-types "${COMPATIBLE_TYPE}" \
    --provides "rootfs-image.version:${ARTIFACT_NAME}" \
    --provides "rootfs-image.checksum:${img_checksum}" \
    --clears-provides "rootfs-image.*" \
    --output-path "${TARGET_DIR}"/var/lib/mender/bootstrap.mender \
    --version 3
}

function mender_fixup() {
  rm -rf "${TARGET_DIR}"/var/lib/mender
  mkdir -p "${TARGET_DIR}"/var/lib/mender
  echo "device_type=${COMPATIBLE_TYPE}" > "${TARGET_DIR}"/var/lib/mender/device_type

}

mender_fixup
generate_mender_bootstrap_artifact
