#!/bin/sh
set -eu

BOARD_DIR=$(dirname "$0")

# Copy xen configuration.
cp -f "${BOARD_DIR}/xen.cfg" "${BINARIES_DIR}/xen.cfg"
