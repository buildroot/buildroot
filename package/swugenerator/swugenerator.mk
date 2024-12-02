################################################################################
#
# swugenerator
#
################################################################################

SWUGENERATOR_VERSION = 0.4
SWUGENERATOR_SITE = $(call github,sbabic,swugenerator,$(SWUGENERATOR_VERSION))
SWUGENERATOR_LICENSE = GPL-3.0
SWUGENERATOR_LICENSE_FILES = LICENSE
HOST_SWUGENERATOR_SETUP_TYPE = setuptools
HOST_SWUGENERATOR_DEPENDENCIES = \
	host-gzip \
	host-openssl \
	host-python-libconf \
	host-zstd

$(eval $(host-python-package))
