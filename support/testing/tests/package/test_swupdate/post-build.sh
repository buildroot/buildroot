#!/bin/sh
set -e

SWU_SRC_DIR="$(dirname "$0")"

# Generate the SWU image to be installed by the runtime test. The
# default swupdate configuration has no crypto support, so do not
# store hashes in sw-description.
"${HOST_DIR}"/bin/swugenerator \
	--no-hash \
	--sw-description "${SWU_SRC_DIR}"/sw-description \
	--artifactory "${SWU_SRC_DIR}" \
	--swu-file "${TARGET_DIR}"/root/test.swu \
	create
