################################################################################
#
# swipl
#
################################################################################

SWIPL_VERSION = 9.2.8
SWIPL_SITE = https://www.swi-prolog.org/download/stable/src
SWIPL_LICENSE = BSD-2-Clause
SWIPL_LICENSE_FILES = LICENSE

HOST_SWIPL_DEPENDENCIES = host-zlib

SWIPL_DEPENDENCIES = host-swipl zlib

# A host-swipl is needed to compile the target prolog boot
# boot.prl file.
HOST_SWIPL_CONF_OPTS = \
	-DBUILD_PDF_DOCUMENTATION=OFF \
	-DSWIPL_PACKAGES=OFF \
	-DUSE_GMP=OFF \
	-DUSE_TCMALLOC=OFF

# swipl uses cmake macros try_run() and check_c_source_runs(), which
# are not suitable for cross compilation. We add results in cache to
# avoid running those tests. The SWIPL_NATIVE_FRIEND variable, is
# meant to point to build directory of a host native swipl, rather
# than the binary itself. The Cmake macro will append "src/swipl" to
# the path set to this variable. Therefore, we cannot use the host
# "swipl" binary installed in $(HOST_DIR)/usr/bin.
SWIPL_CONF_OPTS = \
	-DBUILD_PDF_DOCUMENTATION=OFF \
	-DHAVE_WEAK_ATTRIBUTE=1 \
	-DLLROUND_OK=1 \
	-DMODF_OK=1 \
	-DQSORT_R_GNU=1 \
	-DSWIPL_NATIVE_FRIEND=$(HOST_SWIPL_SRCDIR) \
	-DSWIPL_PACKAGES=OFF \
	-DUSE_TCMALLOC=OFF \
	-DCMAKE_CXX_COMPILER=true

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
SWIPL_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

ifeq ($(BR2_PACKAGE_GMP),y)
SWIPL_CONF_OPTS += -DUSE_GMP=ON
SWIPL_DEPENDENCIES += gmp
else
SWIPL_CONF_OPTS += -DUSE_GMP=OFF
endif

ifeq ($(BR2_PACKAGE_NCURSES),y)
SWIPL_DEPENDENCIES += ncurses
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
