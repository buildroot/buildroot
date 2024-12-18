################################################################################
#
# dpdk
#
################################################################################

DPDK_VERSION = 24.11.1
DPDK_SOURCE = dpdk-$(DPDK_VERSION).tar.xz
DPDK_SITE = https://fast.dpdk.org/rel
DPDK_LICENSE = \
	BSD-3-Clause, \
	MIT

# Only the Windows target has the 2 following licenses:
# - license/bsd-2-clause.txt
# - license/isc.txt
# which is related to a Windows getopt.[ch] compatibility layer.
# Since Buildroot is not used for Windows target, it is not listed
# here.
#
# All the userland files of DPDK have dual licences BSD or GPL/LGPL
# Since the Linux kernel modules had been removed from the DPDK, there
# is no GPL only code into the DPDK anymore.
# The usage of DPDK with Buildroot is for userland only, it means
# that for the dual licenced files, BSD clause is used but not the
# following ones:
# - license/gpl-2.0.txt
# - license/lgpl-2.1.txt
# See the DPDK's license/README for more details.
#
# The legacy and historical license of the DPDK is BSD-3-clause.
DPDK_LICENSE_FILES = \
	license/README \
	license/bsd-3-clause.txt \
	license/exceptions.txt \
	license/mit.txt

DPDK_INSTALL_STAGING = YES

DPDK_DEPENDENCIES = \
	host-pkgconf \
	host-python-pyelftools

ifeq ($(BR2_PACKAGE_DPDK_EXAMPLES),y)
DPDK_CONF_OPTS += -Dexamples=all
else
DPDK_CONF_OPTS += -Dexamples=
endif

ifeq ($(BR2_PACKAGE_DPDK_TESTS),y)
DPDK_CONF_OPTS += -Dtests=true
else
DPDK_CONF_OPTS += -Dtests=false
endif

ifeq ($(BR2_PACKAGE_LIBBSD),y)
DPDK_DEPENDENCIES += libbsd
endif

ifeq ($(BR2_PACKAGE_JANSSON),y)
DPDK_DEPENDENCIES += jansson
endif

ifeq ($(BR2_PACKAGE_LIBPCAP),y)
DPDK_DEPENDENCIES += libpcap
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
DPDK_DEPENDENCIES += zlib
endif

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
DPDK_DEPENDENCIES += libexecinfo
endif

ifeq ($(BR2_PACKAGE_NUMACTL),y)
DPDK_DEPENDENCIES += numactl
endif

ifeq ($(BR2_PACKAGE_LIBARCHIVE),y)
DPDK_DEPENDENCIES += libarchive
endif

ifeq ($(BR2_PACKAGE_LIBBPF),y)
DPDK_DEPENDENCIES += libbpf
endif

ifeq ($(BR2_PACKAGE_RDMA_CORE),y)
DPDK_DEPENDENCIES += rdma-core
endif

# DPDK's meson shall need to be clean'd, hack here along the enclosed patch
DPDK_CONF_OPTS += -Dcpu_instruction_set=$(BR2_GCC_TARGET_ARCH)
# Keep the following, even if not mandatory, until the removal of the patch
DPDK_MESON_EXTRA_PROPERTIES += platform='generic'

$(eval $(meson-package))
