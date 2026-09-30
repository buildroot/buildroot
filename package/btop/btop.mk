################################################################################
#
# btop
#
################################################################################

BTOP_VERSION = 1.4.7
BTOP_SITE = $(call github,aristocratos,btop,v$(BTOP_VERSION))
BTOP_LICENSE = Apache-2.0, MIT with exception (fmt)
BTOP_LICENSE_FILES = LICENSE include/fmt/LICENSE.rst

BTOP_SUPPORTS_IN_SOURCE_BUILD = NO

BTOP_CONF_OPTS = \
	-DBTOP_GPU=$(if $(BR2_PACKAGE_BTOP_GPU),ON,OFF) \
	-DBTOP_LTO=$(if $(BR2_ENABLE_LTO),ON,OFF) \
	-DBTOP_RSMI_STATIC=OFF \
	-DBTOP_STATIC=$(if $(BR2_STATIC_LIBS),ON,OFF)

ifeq ($(BR2_PACKAGE_BTOP_GPU),y)
BTOP_LICENSE += , MIT (intel_gpu_top)
BTOP_LICENSE_FILES += src/linux/intel_gpu_top/intel_gpu_top.c
endif

ifneq ($(BR2_TOOLCHAIN_HAS_SSP),y)
BTOP_CONF_OPTS += -DHAS_FSTACK_PROTECTOR=OFF
endif

$(eval $(cmake-package))
