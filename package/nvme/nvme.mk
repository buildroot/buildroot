################################################################################
#
# nvme
#
################################################################################

NVME_VERSION = 2.15
NVME_SITE = $(call github,linux-nvme,nvme-cli,v$(NVME_VERSION))
NVME_LICENSE = GPL-2.0+
NVME_LICENSE_FILES = LICENSE
NVME_DEPENDENCIES = libnvme

ifeq ($(BR2_PACKAGE_JSON_C),y)
NVME_CONF_OPTS += -Djson-c=enabled
NVME_DEPENDENCIES += json-c
else
NVME_CONF_OPTS += -Djson-c=disabled
endif

$(eval $(meson-package))
