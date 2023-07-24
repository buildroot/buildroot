################################################################################
#
# rdma-core
#
################################################################################

RDMA_CORE_VERSION = 47.0
RDMA_CORE_SITE = $(call github,linux-rdma,rdma-core,v$(RDMA_CORE_VERSION))
RDMA_CORE_LICENSE = GPL-2.0 or BSD-2-Clause
RDMA_CORE_LICENSE_FILES = COPYING.GPL2 COPYING.BSD_MIT COPYING.md
RDMA_CORE_DEPENDENCIES = libnl
RDMA_CORE_INSTALL_STAGING = YES

RDMA_CORE_CONF_OPTS = \
	-DNO_MAN_PAGES=1 \
	-DNO_PYVERBS=1

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
RDMA_CORE_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS=-latomic \
	-DCMAKE_SHARED_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
