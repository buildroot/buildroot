#!/bin/sh
set -eu

BOARD_DIR="$(dirname "$0")"

cp "${BOARD_DIR}/nand-full.lst" "${BINARIES_DIR}"
