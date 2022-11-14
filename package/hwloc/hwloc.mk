################################################################################
#
# hwloc
#
################################################################################

HWLOC_VERSION_MAJOR = 2.8
HWLOC_VERSION = $(HWLOC_VERSION_MAJOR).0
HWLOC_SOURCE = hwloc-$(HWLOC_VERSION).tar.bz2
HWLOC_SITE = https://download.open-mpi.org/release/hwloc/v$(HWLOC_VERSION_MAJOR)
HWLOC_LICENSE = BSD-3-Clause
HWLOC_LICENSE_FILES = COPYING
HWLOC_DEPENDENCIES = host-pkgconf
HWLOC_INSTALL_STAGING = YES
HWLOC_SELINUX_MODULES = hwloc

# ac_cv_prog_cc_c99 is required for BR2_USE_WCHAR=n because the C99 test
# provided by autoconf relies on wchar_t.
HWLOC_CONF_ENV = ac_cv_prog_cc_c99=-std=gnu99

HWLOC_CONF_OPTS = \
	--disable-opencl \
	--disable-cuda \
	--disable-nvml \
	--disable-gl \
	--disable-cairo \
	--disable-doxygen

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
HWLOC_CONF_OPTS += --enable-libudev
HWLOC_DEPENDENCIES += udev
else
HWLOC_CONF_OPTS += --disable-libudev
endif

ifeq ($(BR2_PACKAGE_LIBPCIACCESS),y)
HWLOC_CONF_OPTS += --enable-pci
HWLOC_DEPENDENCIES += libpciaccess
else
HWLOC_CONF_OPTS += --disable-pci
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
HWLOC_CONF_OPTS += --enable-libxml2
HWLOC_DEPENDENCIES += libxml2
else
HWLOC_CONF_OPTS += --disable-libxml2
endif

ifeq ($(BR2_PACKAGE_NCURSES),y)
HWLOC_DEPENDENCIES += ncurses
endif

ifeq ($(BR2_PACKAGE_NUMACTL),y)
HWLOC_DEPENDENCIES += numactl
endif

$(eval $(autotools-package))
