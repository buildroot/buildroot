################################################################################
#
# avocado
#
################################################################################

AVOCADO_VERSION = 113.0
AVOCADO_SITE = $(call github,avocado-framework,avocado,$(AVOCADO_VERSION))
AVOCADO_SETUP_TYPE = setuptools
AVOCADO_LICENSE = GPL-2.0
AVOCADO_LICENSE_FILES = LICENSE

$(eval $(python-package))
