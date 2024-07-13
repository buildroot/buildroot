################################################################################
#
# blake3
#
################################################################################

BLAKE3_VERSION = 1.5.1
BLAKE3_SITE = $(call github,BLAKE3-team,BLAKE3,$(BLAKE3_VERSION))
BLAKE3_SUBDIR = c
BLAKE3_LICENSE = Apache-2.0, CC0-1.0
BLAKE3_LICENSE_FILES = LICENSE

# The package is a dependency to ccache so ccache cannot be a dependency
HOST_BLAKE3_ADD_CCACHE_DEPENDENCY = NO

# We may be a ccache dependency, so we can't use ccache; reset the
# options set by the cmake infra.
HOST_BLAKE3_CONF_OPTS += \
	-UCMAKE_C_COMPILER_LAUNCHER \
	-UCMAKE_CXX_COMPILER_LAUNCHER

$(eval $(host-cmake-package))
