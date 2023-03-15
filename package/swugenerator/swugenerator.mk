################################################################################
#
# swugenerator
#
################################################################################

SWUGENERATOR_VERSION = 0.2
SWUGENERATOR_SITE = $(call github,sbabic,swugenerator,v$(SWUGENERATOR_VERSION))
SWUGENERATOR_LICENSE = GPL-3.0
SWUGENERATOR_LICENSE_FILES = LICENSE
HOST_SWUGENERATOR_SETUP_TYPE = setuptools
HOST_SWUGENERATOR_DEPENDENCIES = host-python-libconf

$(eval $(host-python-package))
